#include <fstream>
#include <iomanip>
#include <iostream>
#include <string>
#include <filesystem>

#include "cs561/all_files_enumerator.h"
#include "cs561/cs561_option.h"
#include "rocksdb/advanced_options.h"
#include "rocksdb/cache.h"
#include "rocksdb/db.h"
#include "rocksdb/options.h"
#include "rocksdb/slice.h"
#include "rocksdb/table.h"
#include "rocksdb/rate_limiter.h"

using namespace rocksdb;
std::string kDBPath = "/mnt/ramdisk/cs561_project1";

std::vector<size_t> readManualList(
    const std::string& manual_list_path) {
  std::ifstream f(manual_list_path);
  if (!f.is_open()) {
    std::cout << "Read Manual List Error" << std::endl;
    exit(-1);
  }
  size_t manual_list_size = 0;
  f >> manual_list_size;
  if (manual_list_size <= 0) {
    std::cout << "Read Manual List Error" << std::endl;
    exit(-1);
  }
  std::vector<size_t> manual_list(manual_list_size);
  for (size_t i = 0; i < manual_list_size; ++i) {
    f >> manual_list[i];
  }
  return manual_list;
}

void backgroundJobMayComplete(DB* db) {
  uint64_t pending_compact;
  uint64_t pending_compact_bytes;
  uint64_t running_compact;
  uint64_t pending_flush;
  uint64_t running_flush;

  bool success = false;
  while (pending_compact || pending_compact_bytes ||
         running_compact || pending_flush ||
         running_flush || !success) {
    std::this_thread::sleep_for(
        std::chrono::milliseconds(200));
    success =
        db->GetIntProperty("rocksdb.compaction-pending",
                           &pending_compact) &&
        db->GetIntProperty(
            "rocksdb.estimate-pending-compaction-bytes",
            &pending_compact_bytes) &&
        db->GetIntProperty(
            "rocksdb.num-running-compactions",
            &running_compact) &&
        db->GetIntProperty(
            "rocksdb.mem-table-flush-pending",
            &pending_flush) &&
        db->GetIntProperty("rocksdb.num-running-flushes",
                           &running_flush);
  }
}

void runWorkload(Options& op, WriteOptions& write_op,
                 ReadOptions& read_op,
                 std::string compaction_strategy,
                 uint64_t total_written_bytes,
                 const std::string& experiment_path,
                 const std::string& workload_path) {
  DB* db;

  op.create_if_missing = true;
  op.level0_file_num_compaction_trigger = 4;
  op.max_bytes_for_level_multiplier = 4;
  op.level_compaction_dynamic_level_bytes = false;

  // set the compaction strategy
  if (compaction_strategy == "kRoundRobin") {
    AllFilesEnumerator::GetInstance().strategy = AllFilesEnumerator::CompactionStrategy::Rocksdb;
    op.compaction_pri = kRoundRobin;
  } else if (compaction_strategy == "kMinOverlappingRatio") {
    AllFilesEnumerator::GetInstance().strategy = AllFilesEnumerator::CompactionStrategy::Rocksdb;
    op.compaction_pri = kMinOverlappingRatio;
  } else if (compaction_strategy == "kOldestLargestSeqFirst") {
    AllFilesEnumerator::GetInstance().strategy = AllFilesEnumerator::CompactionStrategy::Rocksdb;
    op.compaction_pri = kOldestLargestSeqFirst;
  } else if (compaction_strategy == "kOldestSmallestSeqFirst") {
    AllFilesEnumerator::GetInstance().strategy = AllFilesEnumerator::CompactionStrategy::Rocksdb;
    op.compaction_pri = kOldestSmallestSeqFirst;
  } else if (compaction_strategy == "kEnumerateAll") {
    AllFilesEnumerator::GetInstance().strategy = AllFilesEnumerator::CompactionStrategy::EnumerateAll;
  } else if (compaction_strategy == "kManual") {
    std::string manual_list_path = experiment_path + "/manual_list.txt";
    AllFilesEnumerator::GetInstance().strategy = AllFilesEnumerator::CompactionStrategy::Manual;
    AllFilesEnumerator::GetInstance().SetManualList(readManualList(manual_list_path));
  } else if (compaction_strategy == "kSelectLastSimilar") {
    AllFilesEnumerator::GetInstance().strategy = AllFilesEnumerator::CompactionStrategy::SelectLastSimilar;
  } else {
    std::cerr << "Invalid compaction strategy" << std::endl;
    exit(-1);
  }
  AllFilesEnumerator::GetInstance().SetLogLevel(2);
  // set the total bytes to be inserted to database
  uint64_t total_bytes = total_written_bytes;

  {
    op.memtable_factory = std::shared_ptr<VectorRepFactory>(
        new VectorRepFactory);
    op.allow_concurrent_memtable_write = false;
  }

  {
      // op.memtable_factory =
      // std::shared_ptr<SkipListFactory>(new
      // SkipListFactory);
  }

  {
      // op.memtable_factory =
      // std::shared_ptr<MemTableRepFactory>(NewHashSkipListRepFactory());
      // op.allow_concurrent_memtable_write = false;
  }

  {
    // op.memtable_factory =
    // std::shared_ptr<MemTableRepFactory>(NewHashLinkListRepFactory());
    // op.allow_concurrent_memtable_write = false;
  }

  // BlockBasedTableOptions table_options;
  // table_options.block_cache = NewLRUCache(8*1048576);
  // op.table_factory.reset(NewBlockBasedTableFactory(table_options));

  Status s = DB::Open(op, kDBPath, &db);
  if (!s.ok()) {
    std::cerr << s.ToString() << std::endl;
    exit(-1);
  }

  // opening workload file for the first time
  std::ifstream workload_file(workload_path);
  if (!workload_file.is_open()) {
    std::cerr << "Cannot open workload file" << std::endl;
    exit(-1);
  }

  // read the whole workload
  CS561Log::Log("Reading workload ...");
  std::vector<std::string> workload;
  std::string line;
  while (std::getline(workload_file, line)) {
    workload.push_back(line);
  }
  workload_file.close();
  CS561Log::Log("Finish reading workload");

  // Clearing the system cache
  // std::cout << "Clearing system cache ..." << std::endl; 
  // int clean_flag = system("sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches'"); 
  // if (clean_flag) {
  //     std::cerr << "Cannot clean the system cache" << std::endl; 
  //     exit(0);
  // }

  AllFilesEnumerator::GetInstance().GetCollector().UpdateLeftBytes(total_bytes);

  Iterator* it = db->NewIterator(read_op);  // for range reads
  uint64_t inserted_bytes = 0;

  auto start_time = std::chrono::system_clock::now();
  char instruction;
  std::string value, key, start_key, end_key;
  CS561Log::Log("Start running workload ...");
  for (size_t i = 0; i < workload.size(); i++){
    std::stringstream ss(workload[i]);
    ss >> instruction;
    switch (instruction) {
      case 'I':  // insert
      case 'U':  // update
        ss >> key >> value;
        inserted_bytes += key.length() + value.length();
        // Put key-value
        s = db->Put(write_op, key, value);
        if (!s.ok()) std::cerr << s.ToString() << std::endl;
        assert(s.ok());
        break;

      case 'Q':  // probe: point query
        ss >> key;
        s = db->Get(read_op, key, &value);
        // if (!s.ok()) std::cerr << s.ToString() << "key =
        // " << key << std::endl; assert(s.ok());
        break;

      case 'S':  // scan: range query
        ss >> start_key >> end_key;
        it->Refresh();
        assert(it->status().ok());
        for (it->Seek(start_key); it->Valid(); it->Next()) {
          // std::cout << "found key = " <<
          // it->key().ToString() << std::endl;
          if (it->key().ToString() == end_key) {
            break;
          }
        }
        if (!it->status().ok()) {
          std::cerr << it->status().ToString() << std::endl;
        }
        break;
      case 'D':
        ss >> key;
        s = db->Delete(write_op, key);
        if (!s.ok()) std::cerr << s.ToString() << std::endl;
        assert(s.ok());
        break;
      default:
        return;
        // std::cerr << "ERROR: Case match NOT found !!" <<
        // std::endl;
        break;
    }

    if (total_bytes >= inserted_bytes)
      AllFilesEnumerator::GetInstance().GetCollector().UpdateLeftBytes(total_bytes - inserted_bytes);
  }

  FlushOptions flush_options;
  db->Flush(flush_options);
  backgroundJobMayComplete(db);

  auto end_time = std::chrono::system_clock::now();
  auto durationInMicroseconds = std::chrono::duration_cast<std::chrono::microseconds>(end_time - start_time);   

  s = db->Close();
  if (!s.ok()) std::cerr << s.ToString() << std::endl;
  assert(s.ok());
  delete db;

  // std::cout << "Total running time: " << durationInMicroseconds.count() << "us" << std::endl;
  CS561Log::Log("Total running time: " + std::to_string(durationInMicroseconds.count()) + "us");
  AllFilesEnumerator::GetInstance().GetCollector().DumpToFile();

  std::string result_path = experiment_path + "/result.txt";
  // if the file does not exist, create it
  if (!std::filesystem::exists(result_path)) {
    // create the file
    std::ofstream result_file;
    result_file.open(result_path, std::ios::app);
    if (!result_file.is_open()) {
      std::cerr << "Cannot open result file" << std::endl;
      exit(-1);
    }
    result_file << "Strategy\tWB\tDuration" << std::endl;
    result_file.close();
  }
  std::ofstream result_file;
  result_file.open(result_path, std::ios::app);
  if (!result_file.is_open()) {
    std::cerr << "Cannot open result file" << std::endl;
    exit(-1);
  }

  // strategy WA duration
  if (compaction_strategy != "kEnumerateAll"){
    result_file << compaction_strategy << "\t" << AllFilesEnumerator::GetInstance().GetCollector().GetWA() << "\t" << durationInMicroseconds.count() << std::endl;
  }

  return;
}

int main(int argc, char* argv[]) {
  if (argc != 11) {
    std::cout << "There should three parameters: " << std::endl;
    std::cout << "1. Compaction strategy" << std::endl;
    std::cout << "2. Total written bytes in the workload" << std::endl;
    std::cout << "3. The database path" << std::endl;
    std::cout << "4. The experiment root path" << std::endl;
    std::cout << "5. The workload path" << std::endl;
    std::cout << "6. Skip trivial move" << std::endl;
    std::cout << "7. Skip extend non-L0 trivial move" << std::endl;
    std::cout << "8. Write buffer size" << std::endl;
    std::cout << "9. Target file size base" << std::endl;
    std::cout << "10. Target file number" << std::endl;
    return -1;
  }
  // parse parameter
  std::string compaction_strategy = argv[1];
  uint64_t total_written_bytes = std::stoull(argv[2]);
  kDBPath = argv[3];
  std::string experiment_path = argv[4];
  std::string workload_path = argv[5];
  bool skip_trivial_move = std::stoi(argv[6]);
  bool skip_extend_non_l0_trivial_move = std::stoi(argv[7]);
  uint64_t write_buffer_size = std::stoull(argv[8]);
  uint64_t target_file_size_base = std::stoull(argv[9]);
  uint64_t target_file_number = std::stoull(argv[10]);

  CS561Log::SetLogRootPath(experiment_path);

  CS561Log::Log( "==================================================");
  CS561Log::Log("Program information: ");
  CS561Log::Log("Compaction strategy: " + compaction_strategy);
  CS561Log::Log("Total workload size: " + std::to_string(total_written_bytes));
  CS561Log::Log("Database path: " + kDBPath);
  CS561Log::Log("Experiment path: " + experiment_path);
  CS561Log::Log("Workload path: " + workload_path);
  CS561Log::Log("Skip trivial move: " + std::to_string(skip_trivial_move));
  CS561Log::Log("Skip extend non-L0 trivial move: " + std::to_string(skip_extend_non_l0_trivial_move));
  CS561Log::Log("Write buffer size: " + std::to_string(write_buffer_size));
  CS561Log::Log("Target file size base: " + std::to_string(target_file_size_base));
  CS561Log::Log("Target file number: " + std::to_string(target_file_number));
  
  AllFilesEnumerator::GetInstance();
  CS561Option::skip_trivial_move = skip_trivial_move;
  CS561Option::skip_extend_non_l0_trivial_move = skip_extend_non_l0_trivial_move;

  Options options;
  options.write_buffer_size = write_buffer_size;
  options.target_file_size_base = target_file_size_base;
  options.max_bytes_for_level_base = target_file_number * target_file_size_base;
  WriteOptions write_op;
  ReadOptions read_op;
  runWorkload(options, write_op, read_op, compaction_strategy, total_written_bytes, experiment_path, workload_path);
  
  AllFilesEnumerator::GetInstance().GetCollector().GetVersionForest().DumpToFile();
  return 0;
}
