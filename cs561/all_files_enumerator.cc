#include "cs561/all_files_enumerator.h"

#include "cs561/cs561_log.h"

namespace ROCKSDB_NAMESPACE {

AllFilesEnumerator::AllFilesEnumerator()
    : last_version(std::vector<std::size_t>(
          2, std::numeric_limits<size_t>::max())),
      collector(),
      entry_num_collector(INFO_COLLECTOR_SIZE),
      deletion_num_collector(INFO_COLLECTOR_SIZE),
      file_size_collector(INFO_COLLECTOR_SIZE),
      log_level(1),
      compaction_counter(0) {}

AllFilesEnumerator::~AllFilesEnumerator() {}

int AllFilesEnumerator::GetPickingFile(
    std::vector<rocksdb::Fsize>& temp, int level) {
  size_t index = std::numeric_limits<size_t>::max();
  // compute hash of the current version
  static std::hash<std::vector<ROCKSDB_NAMESPACE::Fsize>>
      hasher;
  std::size_t hash_value = hasher(temp);
  // if temp is empty or the version of temp remains
  // unchanged, just return
  if (temp.empty() || hash_value == last_version[level]) {
    return -1;
  }
  last_version[level] = hash_value;
  ++compaction_counter;
  // if this is a new version, record the file information
  // of this version to disk
  if (!collector.GetVersionForest().IsVersionExist(
          level, hash_value)) {
    CS561Log::LogVersion(temp, hash_value);
  }
  // log
  if (log_level == 1) {
    CS561Log::Log(
        "Level: " + std::to_string(level) +
        ", Version: " + std::to_string(hash_value) +
        ", File index: " + std::to_string(index));
  }
  // select a file according to the history
  index = collector.GetVersionForest().GetCompactionFile(
      level, hash_value, static_cast<int>(temp.size()));
  // check whether we find a file to compact
  if (index != std::numeric_limits<size_t>::max()) {
    // swap the chosen file to the first position
    rocksdb::Fsize tmp = temp[index];
    temp[index] = temp[0];
    temp[0] = tmp;
  } else {
    // we need to terminate the program because we don't
    // need to continue
    Terminate();
  }
  return static_cast<int>(index);
}

int AllFilesEnumerator::GetEstimatedFile(const std::vector<FileMetaData*>* files, int level, int num_level, const Options& op, const InternalKeyComparator& icmp){
  // build simulated file from FileMetaData
  std::vector<std::vector<std::shared_ptr<SimulatedFileMetaData>>> simulated_files(num_level);
  for(int i = 0; i < num_level; ++i) {
    for(size_t j = 0; j < files[i].size(); ++j) {
      simulated_files[i].emplace_back(std::make_shared<SimulatedFileMetaData>(files[i][j]));
    }
  }
  
  const std::vector<std::shared_ptr<SimulatedFileMetaData>>& level_files = simulated_files[level];

  std::vector<uint64_t> estimated_written_bytes(level_files.size(), 0);

  // for each file in this level, we compute the estimated cost in terms of written bytes if we choose the file to compact
  for(size_t i = 0; i < level_files.size(); ++i) {
    // compute the written bytes to the next level of each file
    estimated_written_bytes[i] += ComputeWrittenBytesForCompaction({level_files[i]}, simulated_files[level+1], icmp);

    // remove level_files[i] from this level since we compact it
    std::vector<std::shared_ptr<SimulatedFileMetaData>> simulated_level_files_after_compaction;
    simulated_level_files_after_compaction.reserve(level_files.size()-1);
    for(size_t j = 0; j < level_files.size(); ++j) {
      if (j == i) {
        continue;
      }
      simulated_level_files_after_compaction.push_back(level_files[j]);
    }

    // estimate the next level in the next compaction (i.e. after compacting level_files[i] to it)
    std::vector<std::shared_ptr<SimulatedFileMetaData>> simulated_next_level_files_in_next_compaction = Compaction({level_files[i]}, simulated_files[level+1], level+1, op);

    // compute the estimated overlapping bytes from the previous level if we remove level_files[i] in the next compaction
    std::vector<std::shared_ptr<SimulatedFileMetaData>> simulated_prev_level_files_in_next_compaction = simulated_files[level-1];
    // if the number of files is less than op.level0_file_num_compaction_trigger, assume there will be op.level0_file_num_compaction_trigger files. 
    for(size_t j = 0; j < static_cast<size_t>(op.level0_file_num_compaction_trigger) - simulated_files[level-1].size(); ++j) {
      simulated_prev_level_files_in_next_compaction.emplace_back(MakeEstimatedLevel0File());
    }
    estimated_written_bytes[i] += ComputeWrittenBytesForCompaction(simulated_prev_level_files_in_next_compaction, simulated_level_files_after_compaction, icmp);
    
    // estimate this level after the next compaction
    std::vector<std::shared_ptr<SimulatedFileMetaData>> simulated_level_files_in_next_compaction = Compaction(simulated_prev_level_files_in_next_compaction, simulated_level_files_in_next_compaction, level, op);

    // find that file with the smallest overlapping bytes and use it to compact
    uint64_t smallest_overlapping_bytes = std::numeric_limits<uint64_t>::max();
    size_t file_index = 0;
    for(size_t j = 0; j < simulated_level_files_in_next_compaction.size(); ++j) {
      uint64_t overlapping_bytes = ComputeOverlappingBytesForFile(simulated_level_files_in_next_compaction[j], simulated_next_level_files_in_next_compaction, icmp);
      if (overlapping_bytes < smallest_overlapping_bytes) {
        smallest_overlapping_bytes = overlapping_bytes;
        file_index = j;
      }
    }
    estimated_written_bytes[i] += ComputeWrittenBytesForCompaction({simulated_level_files_in_next_compaction[file_index]}, simulated_next_level_files_in_next_compaction, icmp);

    // build a vector for this level after the next compaction
    std::vector<std::shared_ptr<SimulatedFileMetaData>> simulated_level_files_after_next_compaction;
    simulated_level_files_after_next_compaction.reserve(level_files.size()-1);
    for(size_t j = 0; j < level_files.size(); ++j) {
      if (j == file_index) {
        continue;
      }
      simulated_level_files_after_next_compaction.push_back(simulated_level_files_in_next_compaction[j]);
    }

    // estimate the overlapping bytes again for the previous level to this level
    // now all files in previous needed to be estimated
    std::vector<std::shared_ptr<SimulatedFileMetaData>> simulated_prev_level_files_after_next_compaction;
    simulated_prev_level_files_after_next_compaction.reserve(static_cast<size_t>(op.level0_file_num_compaction_trigger));
    // if the number of files is less than op.level0_file_num_compaction_trigger, assume there will be op.level0_file_num_compaction_trigger files. 
    for(size_t j = 0; j < static_cast<size_t>(op.level0_file_num_compaction_trigger); ++j) {
      simulated_prev_level_files_in_next_compaction.emplace_back(MakeEstimatedLevel0File());
    }
    estimated_written_bytes[i] += ComputeWrittenBytesForCompaction(simulated_prev_level_files_after_next_compaction, simulated_level_files_after_next_compaction, icmp);
  }
  
  uint64_t smallest_overlapping_bytes = std::numeric_limits<uint64_t>::max();
  size_t optimal_file_index = 0;
  for(size_t i = 0; i < level_files.size(); ++i) {
    if (estimated_written_bytes[i] < smallest_overlapping_bytes) {
      smallest_overlapping_bytes = estimated_written_bytes[i];
      optimal_file_index = i;
    }
  }

  return static_cast<int>(optimal_file_index);
}

uint64_t AllFilesEnumerator::ComputeOverlappingBytesForFile(
  const std::shared_ptr<SimulatedFileMetaData>& file, 
  const std::vector<std::shared_ptr<SimulatedFileMetaData>>& next_level_files,
  const InternalKeyComparator& icmp) {
  
  auto next_level_it = next_level_files.begin();
  uint64_t overlapping_bytes = 0;
  // Skip files in next level that is smaller than current file
  while (next_level_it != next_level_files.end() &&
         icmp.Compare((*next_level_it)->largest,
                      file->smallest) < 0) {
    next_level_it++;
  }

  // iterate until the file's smallest is larger than largest key
  while (next_level_it != next_level_files.end() &&
         icmp.Compare((*next_level_it)->smallest,
                      file->largest) < 0) {
    overlapping_bytes += (*next_level_it)->file_size;

    if (icmp.Compare((*next_level_it)->largest,
                     file->largest) > 0) {
      // next level file cross large boundary of current file.
      break;
    }
    next_level_it++;
  }

  return overlapping_bytes;
}

uint64_t AllFilesEnumerator::ComputeOverlappingEntriesForFile(
    const std::shared_ptr<SimulatedFileMetaData>& file, 
    const std::vector<std::shared_ptr<SimulatedFileMetaData>>& next_level_files,
    const InternalKeyComparator& icmp) {
  
  uint64_t overlapping_entries = 0;

  auto next_level_it = next_level_files.begin();
  // Skip files in next level that is smaller than current file
  while (next_level_it != next_level_files.end() &&
         icmp.Compare((*next_level_it)->largest,
                      file->smallest) < 0) {
    next_level_it++;
  }

  // iterate until the file's smallest is larger than largest key
  while (next_level_it != next_level_files.end() &&
         icmp.Compare((*next_level_it)->smallest,
                      file->largest) < 0) {
    overlapping_entries += (*next_level_it)->num_entries;

    if (icmp.Compare((*next_level_it)->largest,
                     file->largest) > 0) {
      // next level file cross large boundary of current file.
      break;
    }
    next_level_it++;
  }

  return overlapping_entries;
}

std::vector<size_t> AllFilesEnumerator::FindOverlappingFiles(
    const std::shared_ptr<SimulatedFileMetaData>& file, 
    const std::vector<std::shared_ptr<SimulatedFileMetaData>>& next_level_files,
    const InternalKeyComparator& icmp) {

  std::vector<size_t> overlapping_files;

  auto next_level_it = next_level_files.begin();
  // Skip files in next level that is smaller than current file
  while (next_level_it != next_level_files.end() &&
         icmp.Compare((*next_level_it)->largest,
                      file->smallest) < 0) {
    next_level_it++;
  }

  // iterate until the file's smallest is larger than largest key
  while (next_level_it != next_level_files.end() &&
         icmp.Compare((*next_level_it)->smallest,
                      file->largest) < 0) {
    overlapping_files.push_back(std::distance(next_level_files.begin(), next_level_it));

    if (icmp.Compare((*next_level_it)->largest,
                     file->largest) > 0) {
      // next level file cross large boundary of current file.
      break;
    }
    next_level_it++;
  }

  return overlapping_files;
}

uint64_t AllFilesEnumerator::ComputeWrittenBytesForCompaction(
    const std::vector<std::shared_ptr<SimulatedFileMetaData>>& input_level_files,
    const std::vector<std::shared_ptr<SimulatedFileMetaData>>& target_level_files,
    const InternalKeyComparator& icmp) {

  // find overlapping files
  std::unordered_set<size_t> overlapping_files_set;
  for(size_t i = 0; i < input_level_files.size(); ++i) {
    std::vector<size_t> overlapping_files = FindOverlappingFiles(input_level_files[i], target_level_files, icmp);
    for(size_t j = 0; j < overlapping_files.size(); ++j) {
      overlapping_files_set.insert(overlapping_files[j]);
    }
  }

  // merge all input files and overlapping files in target level
  uint64_t unique_entry_num = 0;
  for(size_t j = 0; j < input_level_files.size(); ++j) {
    unique_entry_num = Merge(unique_entry_num, input_level_files[j]->num_entries);
  }
  // Count the number of entries in current level because there are no duplicates in target level
  for(size_t index: overlapping_files_set) {
    unique_entry_num += target_level_files[index]->num_entries;
  }
  double avg_bytes_per_entry = (ComputeAvgBytesPerEntry(input_level_files) + ComputeAvgBytesPerEntry(target_level_files)) / 2;
  uint64_t written_bytes = static_cast<uint64_t>(unique_entry_num * avg_bytes_per_entry);
  return written_bytes;
}

double AllFilesEnumerator::ComputeAvgBytesPerEntry(
    const std::vector<std::shared_ptr<SimulatedFileMetaData>>& input_level_files) {

  uint64_t total_bytes = 0;
  uint64_t total_entries = 0;

  for(size_t i = 0; i < input_level_files.size(); ++i) {
    total_bytes += input_level_files[i]->file_size;
    total_entries += input_level_files[i]->num_entries;
  }

  return static_cast<double>(total_bytes) / total_entries;
}

std::shared_ptr<SimulatedFileMetaData> AllFilesEnumerator::MakeEstimatedLevel0File() {
  return std::make_shared<SimulatedFileMetaData>(smallest_key_, largest_key_, entry_num_collector.Avg(), deletion_num_collector.Avg(), file_size_collector.Avg());
}

uint64_t AllFilesEnumerator::KeyToNumber(const InternalKey& key) {
  uint64_t num = 0;
  uint64_t base = 1;
  std::string_view key_str = key.user_key().ToStringView();
  for(size_t i = key_str.length()-1; i >= 0; --i) {
    num += static_cast<uint64_t>(key_str[i]) * base;
    base *= 256;
  }
  return num;
}

InternalKey AllFilesEnumerator::NumberToKey(uint64_t num) {
  std::string key_str;
  uint64_t base = std::pow(256, 7);
  bool started = false;
  for(size_t i = 0; i < 8; ++i) {
    uint64_t c = num / base;
    if (c == 0 && !started) {
      continue;
    }
    started = true;
    key_str.push_back(static_cast<char>(c));
  }
  InternalKey key(Slice(key_str), 0, kTypeValue);
  return key;
}

uint64_t AllFilesEnumerator::Unique(uint64_t request_num) {
  return KEY_SPACE_SIZE * (1 - std::pow(1 - 1.0 / KEY_SPACE_SIZE, request_num));
}

uint64_t AllFilesEnumerator::UniqueInversed(uint64_t unique_num) {
  return static_cast<uint64_t>(std::log(KEY_SPACE_SIZE / (KEY_SPACE_SIZE-unique_num)) / std::log(KEY_SPACE_SIZE / (KEY_SPACE_SIZE-1)));
}

uint64_t AllFilesEnumerator::Merge(uint64_t unique_num1, uint64_t unique_num2) {
  return Unique(UniqueInversed(unique_num1) + UniqueInversed(unique_num2));
}

std::vector<std::shared_ptr<SimulatedFileMetaData>> AllFilesEnumerator::Compaction(
  const std::vector<std::shared_ptr<SimulatedFileMetaData>>& input_files, 
  const std::vector<std::shared_ptr<SimulatedFileMetaData>>& target_level_files,
  size_t target_level, const Options& op) {

  // the threshold of file size in bytes difference that we consider two sizes are the same
  const uint64_t FILE_SIZE_DIF_THRESHOLD = 10;

  // merge all files to one vector
  std::vector<std::shared_ptr<SimulatedFileMetaData>> files;
  files.reserve(input_files.size() + target_level_files.size());
  files.insert(files.end(), input_files.begin(), input_files.end());
  files.insert(files.end(), target_level_files.begin(), target_level_files.end());

  uint64_t total_file_size = 0;
  for(const std::shared_ptr<SimulatedFileMetaData>& f: files) {
    total_file_size += f->file_size;
  }
  uint64_t per_file_size = op.target_file_size_base * std::pow(op.target_file_size_multiplier, target_level);
  uint64_t per_file_entries = per_file_size / ComputeAvgBytesPerEntry(files);
  uint64_t file_num = std::ceil(static_cast<double>(total_file_size) / per_file_size);

  std::vector<std::vector<uint64_t>> files_key_interval;
  files_key_interval.reserve(input_files.size()+target_level_files.size());
  uint64_t start_key = KeyToNumber(largest_key_);
  for(const std::shared_ptr<SimulatedFileMetaData>& f: input_files) {
    files_key_interval.push_back({KeyToNumber(f->smallest), KeyToNumber(f->largest)});
    start_key = std::min(start_key, files_key_interval.back()[0]);
  }

  uint64_t largest_key = KeyToNumber(largest_key_);

  std::vector<std::shared_ptr<SimulatedFileMetaData>> files_after_compaction;
  files_after_compaction.reserve(file_num);

  for(size_t i = 0; i < file_num; ++i) {
    uint64_t low = start_key;
    uint64_t high  = largest_key;
    uint64_t end_key = 0;

    while (low < high) {
      uint64_t mid = (low + high) / 2;
      uint64_t file_size = 0;
      for(size_t j = 0; j < files.size(); ++j) {
        file_size += (mid - files_key_interval[j][0]) / (files_key_interval[j][1] - files_key_interval[j][0]) * files[j]->file_size;
      }
      if ((file_size >= per_file_size && (file_size-per_file_size) < FILE_SIZE_DIF_THRESHOLD) || 
          (per_file_size > file_size && (per_file_size-file_size) < FILE_SIZE_DIF_THRESHOLD)) {
        end_key = mid;
        break;
      } else if (file_size > per_file_size) {
        high = mid - 1;
      } else {
        low = mid + 1;
      }
    }

    std::shared_ptr<SimulatedFileMetaData> f = std::make_shared<SimulatedFileMetaData>(NumberToKey(start_key), NumberToKey(end_key), per_file_entries, deletion_num_collector.Avg(), per_file_size);
    files_after_compaction.push_back(f);
  }

  return files_after_compaction;
}

void AllFilesEnumerator::CollectCompactionInfo(
    std::vector<FileMetaData*>* files,
    const std::vector<uint64_t>& file_overlapping_ratio,
    int num_level, int level, int index) {
  // compute hash of the current version
  static std::hash<std::vector<ROCKSDB_NAMESPACE::Fsize>>
      hasher;
  std::vector<Fsize> temp(files[level].size());
  for (size_t i = 0; i < files[level].size(); i++) {
    temp[i].index = i;
    temp[i].file = files[level][i];
  }
  std::size_t hash_value = hasher(temp);
  // collect this seletion
  collector.CollectCompactionInfo(
      level, files, file_overlapping_ratio, num_level,
      hash_value, index);
  // log
  if (log_level == 2) {
    CS561Log::LogRegularCompactionInfo(
        collector.GetCompactionsInfo().back(),
        static_cast<int>(collector.GetCompactionsInfo().size()));
  }
}

int AllFilesEnumerator::NextChoiceForManual() {
  return static_cast<int>(manual_list[compaction_counter++]);
}

void AllFilesEnumerator::SetManualList(
    const std::vector<size_t>& ml) {
  manual_list = ml;
}

PickingHistoryCollector&
AllFilesEnumerator::GetCollector() {
  return collector;
}

void AllFilesEnumerator::Terminate() {
  // Before termination, dump version forests to file
  collector.GetVersionForest().DumpToFile();
  // record WA and minimum in this run
  // collector.DumpWAResult();
  // Log
  // CS561Log::Log("Terminate program due to early stop");
  // Terminate program
  exit(1);
}

void AllFilesEnumerator::Pruning() {
  // Check whether current WA already exceeds global min
  if (!collector.CheckContinue()) {
    // Set the current version to be fully enumerated (not
    // need to explore further)
    collector.GetVersionForest()
        .GetLevelVersionTree(1)
        .SetCurrentVersionFullyEnumerated();
    // set the flag of the current node
    CS561Log::Log(
        "Terminate reason: current WA already exceeds the "
        "minimum");
    Terminate();
  }
}

int AllFilesEnumerator::GetLogLevel() {
  return log_level;
}

void AllFilesEnumerator::SetLogLevel(int log_level_) {
  log_level = log_level_;
}

bool AllFilesEnumerator::CheckFinishEnumeration() {
  return false;
}

}  // namespace ROCKSDB_NAMESPACE