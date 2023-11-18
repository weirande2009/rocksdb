#pragma once

#include <iostream>

#include "cs561/picking_history_collector.h"
#include "cs561/request_info_collector.h"

#include "db/version_set.h"

namespace ROCKSDB_NAMESPACE {

struct SimulatedFileMetaData {
  InternalKey smallest;
  InternalKey largest;
  uint64_t num_entries = 0;
  uint64_t num_deletions = 0;
  uint64_t file_size = 0;

  SimulatedFileMetaData(const InternalKey& smallest_, 
                        const InternalKey& largest_, 
                        uint64_t num_entries_, 
                        uint64_t num_deletions_,
                        uint64_t file_size_) : 
    smallest(smallest_), largest(largest_), num_entries(num_entries_), num_deletions(num_deletions_), file_size(file_size_) {}

  SimulatedFileMetaData(const FileMetaData* file) :
    smallest(file->smallest), largest(file->largest), num_entries(file->num_entries), num_deletions(file->num_deletions), file_size(file->fd.file_size) {}

};

class AllFilesEnumerator {
public:
  enum CompactionStrategy {
    RoundRobin,
    MinOverlappingRatio,
    EnumerateAll,
    Manual,
  };

  // Compaction strategy
  CompactionStrategy strategy;

  static AllFilesEnumerator& GetInstance() {
    static AllFilesEnumerator instance;
    return instance;
  }

  /**
   * according to the current file version, choose a new
   * file as the first file
   * @param temp current version
   * @param level the level of the version
   *
   * @return the index of the chosen file
   */
  int GetPickingFile(std::vector<Fsize>& temp, int level);

  /**
   * according to the algorithm we provided, choose a new file
   * with the smallest estimated WA as the first file
   * @param files all the files in all levels
   * @param level the level that need compaction
   * @param num_level number of levels
   * 
   * @return the index of the chosen file in its level
  */
  int GetEstimatedFile(const std::vector<FileMetaData*>* files, int level, int num_level, const Options& op, const InternalKeyComparator& icmp);

  /**
   * Estimate the written bytes for one round, including a compaction to the next level and a compaction from the
   * previous level
  */
  uint64_t EstimateOneRound(const std::vector<std::shared_ptr<SimulatedFileMetaData>>& prev_level_files,
    const std::vector<std::shared_ptr<SimulatedFileMetaData>>& level_files,
    const std::vector<std::shared_ptr<SimulatedFileMetaData>>& next_level_files,
    size_t file_index, bool manual_picking,
    std::vector<std::shared_ptr<SimulatedFileMetaData>>& out_prev_level_files,
    std::vector<std::shared_ptr<SimulatedFileMetaData>>& out_level_files,
    std::vector<std::shared_ptr<SimulatedFileMetaData>>& out_next_level_files);

  /**
   * Compute the overlapping bytes of a file to the next level
  */
  uint64_t ComputeOverlappingBytesForFile(
    const std::shared_ptr<SimulatedFileMetaData>& file, 
    const std::vector<std::shared_ptr<SimulatedFileMetaData>>& next_level_files,
    const InternalKeyComparator& icmp);

  /**
   * Compute the overlapping file's total entry number
  */
  uint64_t ComputeOverlappingEntriesForFile(
    const std::shared_ptr<SimulatedFileMetaData>& file, 
    const std::vector<std::shared_ptr<SimulatedFileMetaData>>& next_level_files,
    const InternalKeyComparator& icmp);

  /**
   * Find overlapping files with input file
  */
  std::vector<size_t> FindOverlappingFiles(
    const std::shared_ptr<SimulatedFileMetaData>& file, 
    const std::vector<std::shared_ptr<SimulatedFileMetaData>>& next_level_files,
    const InternalKeyComparator& icmp);

  /**
   * Compute the written bytes of compacting files to next level
  */
  uint64_t ComputeWrittenBytesForCompaction(
    const std::vector<std::shared_ptr<SimulatedFileMetaData>>& input_level_files,
    const std::vector<std::shared_ptr<SimulatedFileMetaData>>& target_level_files,
    const InternalKeyComparator& icmp);

  /**
   * Compute the average bytes per key for files
  */
  double ComputeAvgBytesPerEntry(
    const std::vector<std::shared_ptr<SimulatedFileMetaData>>& input_level_files);

  /**
   * Make an estimated file in level 0
  */
  std::shared_ptr<SimulatedFileMetaData> MakeEstimatedLevel0File();

  /**
   * Convert a string key to a uint64_t number
  */
  uint64_t KeyToNumber(const InternalKey& key);

  /**
   * Convert a number to a string key
  */
  InternalKey NumberToKey(uint64_t num);

  /**
   * Compute the unique number of keys in p request
   * @param request_num the number of request
   * @return the unique number of keys
  */
  uint64_t Unique(uint64_t request_num);

  /**
   * Compute the number of requests needed to achieve p unique keys
   * @param unique_num the number of unique keys
   * @return the number of requests needed
  */
  uint64_t UniqueInversed(uint64_t unique_num);

  /**
   * Compute the number of unique keys after merging two overlapping files
   * @param unique_num1 the number of unique keys in file1
   * @param unique_num2 the number of unique keys in file2
   * @return the number of unique keys after merging
  */
  uint64_t Merge(uint64_t unique_num1, uint64_t unique_num2);

  /**
   * Compute the simulated files after compaction
  */
  std::vector<std::shared_ptr<SimulatedFileMetaData>> Compaction(
    const std::vector<std::shared_ptr<SimulatedFileMetaData>>& input_files, 
    const std::vector<std::shared_ptr<SimulatedFileMetaData>>& target_level_files,
    size_t target_level, const InternalKeyComparator& icmp, const Options& op);

  /**
   * Collect the compaction information
   * @param files current version of all levels
   * @param file_overlapping_ratio the overlapping ratio of
   * each file in the level
   * @param num_level the number of levels
   * @param level the level of the triggered compaction
   * @param index the index of the chosen file
   */
  void CollectCompactionInfo(
      std::vector<FileMetaData*>* files,
      const std::vector<uint64_t>& file_overlapping_ratio,
      int num_level, int level, int index);

  int NextChoiceForManual();
  void SetManualList(const std::vector<size_t>& ml);
  PickingHistoryCollector& GetCollector();

  void Terminate();
  void Pruning();
  int GetLogLevel();
  void SetLogLevel(int log_level_);
  bool CheckFinishEnumeration();

  void CollectInfo(uint64_t entry_num);

private:
  const size_t INFO_COLLECTOR_SIZE = 10;
  const uint64_t KEY_SPACE_SIZE = 1e7;

  // record the last version of of each level, if the
  // version remains unchanged, there is no compaction
  // happening in this level, so we don't need to do
  // anything to this level
  std::vector<std::size_t> last_version;

  // history collector
  PickingHistoryCollector collector;

  // collect the entry number of each level0 file (i.e. flushed memory table)
  RequestInfoCollector entry_num_collector;
  RequestInfoCollector deletion_num_collector;
  RequestInfoCollector file_size_collector;

  // collect the smallest key and largest key
  InternalKey smallest_key_;
  InternalKey largest_key_;

  // log level
  // there are two log level (default 1):
  // 1- only log the hash value of the version and the
  // chosen file index 2- log the concrete information of
  // the version and the chosen file index all other level
  // will be treated as no log
  int log_level;

  // manual list: contains the file choice of each
  // compaction
  std::vector<size_t> manual_list;

  // the compaction counter, record the number of
  // compactions
  int compaction_counter;

  AllFilesEnumerator();
  ~AllFilesEnumerator();
};

}  // namespace ROCKSDB_NAMESPACE