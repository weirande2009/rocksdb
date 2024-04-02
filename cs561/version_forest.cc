//
// Created by bruce on 3/25/2023.
//
#include "cs561/version_forest.h"

#include <cassert>
#include <iomanip>
#include <limits>

namespace ROCKSDB_NAMESPACE {

std::ostream& operator<<(std::ostream& os,
                         const VersionNode& node) {
  static const std::string TAB = "\t";

  os << node.id << TAB;
  // check whether the parent_id is long max
  if (node.parent_id ==
      std::numeric_limits<size_t>::max()) {
    os << -1 << TAB;
  } else {
    os << node.parent_id << TAB;
  }
  os << std::setfill('0') << std::setw(sizeof(size_t) * 2)
     << std::hex << node.hash_value << std::dec << TAB;
  os << node.file_num << TAB << TAB << TAB;
  if (node.fully_enumerated) {
    os << "yes" << TAB << TAB << TAB << TAB << TAB;
  } else {
    os << "no" << TAB << TAB << TAB << TAB << TAB;
  }

  os << node.chosen_children.size() << TAB << TAB << TAB
     << TAB << TAB;

  for (size_t child_id : node.chosen_children) {
    if (child_id == std::numeric_limits<size_t>::max()) {
      os << -1 << TAB;
    } else {
      os << child_id << TAB;
    }
  }
  os << std::endl;

  return os;
}

std::istream& operator>>(std::istream& is,
                         VersionNode& node) {
  is >> node.id;
  // read parent id as a string to check whether it's -1
  std::string str_parent_id;
  is >> str_parent_id;
  if (str_parent_id == "-1") {
    node.parent_id = std::numeric_limits<size_t>::max();
  } else {
    node.parent_id = std::stoull(str_parent_id);
  }
  // read hash value and convert hex to dec
  is >> std::hex >> node.hash_value >> std::dec;
  is >> node.file_num;

  // read fully enumerated string (yes or no)
  std::string str_fully_enumerated;
  is >> str_fully_enumerated;
  if (str_fully_enumerated == "yes") {
    node.fully_enumerated = true;
  } else {
    node.fully_enumerated = false;
  }
  size_t sz;
  is >> sz;

  node.chosen_children.clear();
  node.chosen_children.reserve(sz);
  std::string str_child_id;
  for (size_t i = 0; i < sz; ++i) {
    is >> str_child_id;
    if (str_child_id == "-1") {
      node.chosen_children.push_back(
          std::numeric_limits<size_t>::max());
    } else {
      node.chosen_children.push_back(
          std::stoull(str_child_id));
    }
  }

  return is;
}

void LevelVersionTree::LoadFromFile() {
  assert(!file_path.empty());

  std::fstream f(file_path);

  // skip line
  std::string skip_line;

  // skip the first line
  std::getline(f, skip_line);
  // version_nodes
  size_t vn_size;
  f >> vn_size;
  // std::cout << "Number of nodes: " << vn_size <<
  // std::endl;
  if (vn_size == 0) {
    return;
  }
  std::getline(f, skip_line);
  VersionNode node{};
  version_nodes.clear();
  version_nodes.reserve(vn_size);
  // skip the third line
  std::getline(f, skip_line);
  // std::cout << skip_line << std::endl;

  for (size_t i = 0; i < vn_size; ++i) {
    f >> node;
    version_nodes.emplace_back(std::move(node));
  }

  // hash_to_id
  size_t sz = version_nodes.size();
  if (version_nodes.size() != 0) {
    hash_to_id.reserve(version_nodes.size());
  }
  for (size_t i = 0; i < sz; ++i) {
    hash_to_id[version_nodes[i].hash_value] = i;
  }
}

void LevelVersionTree::DumpToFile() {
  static const std::string TAB = "\t";

  assert(!file_path.empty());

  std::ofstream f(file_path);

  // the first line
  f << "Number of nodes" << std::endl;

  // version_nodes
  size_t vn_size = version_nodes.size();
  f << vn_size << std::endl;

  // the first line
  f << "ID" << TAB << "PID" << TAB << "Hash_Value" << TAB
    << TAB << TAB << "File_Number" << TAB
    << "Fully_Enumerated" << TAB << "Number_of_children"
    << TAB << "Children" << std::endl;

  for (const auto& vn : version_nodes) {
    f << vn;
  }

  // no need for dumping hash_to_id
}

void LevelVersionTree::AddNode(size_t hash_value, int file_num) {
  // check whether hash_value is a new version
  assert(hash_to_id.find(hash_value) == hash_to_id.end());
  // the id is the index in version_nodes which is the size
  // of current version_nodes
  version_nodes.emplace_back(VersionNode(version_nodes.size(), last_version_id, hash_value, file_num));
  // FIXME: it may not emplace to the hashmap
  // after emplace back, the index become the
  // version_nodes.size()-1 hash_to_id.insert(hash_value,
  // version_nodes.size()-1);
  hash_to_id[hash_value] = version_nodes.size() - 1;
  // we should check whether there is a last version, if
  // this is the first compaction, there will no last
  // version and we should not set the index
  if (last_version_id !=std::numeric_limits<size_t>::max()) {
    assert(!version_nodes[last_version_id].chosen_children.empty());
    // update the index of the new node to the children of last node
    version_nodes[last_version_id].chosen_children.back() = version_nodes.size() - 1;
  }
}

size_t LevelVersionTree::GetCompactionFile( size_t hash_value, int file_num) {
  // first check whether the version of hash_value already exists
  if (hash_to_id.find(hash_value) == hash_to_id.end()) {
    // create a new version
    AddNode(hash_value, file_num);
  }
  size_t index = hash_to_id[hash_value];
  if (last_version_id != std::numeric_limits<size_t>::max()) {
    assert(!version_nodes[last_version_id].chosen_children.empty());
    // update the index of the new node to the children of last node
    version_nodes[last_version_id].chosen_children.back() = index;
  }
  // iterate the file that has been selected and check
  // whether the children node has already iterate over all
  // its files. If not, find the best as the compaction file
  size_t compaction_file_index = std::numeric_limits<size_t>::max();
  for (size_t i = 0; i < version_nodes[index].chosen_children.size(); i++) {
    size_t child = version_nodes[index].chosen_children[i];
    // if child is long max, it's a leaf, we can't choose.
    if (child == std::numeric_limits<size_t>::max()) {
      continue;
    }
    // if the child is still not fully enumerated, we still
    // want to go to this child
    if (!version_nodes[child].fully_enumerated) {
      // the size will the index of the next
      compaction_file_index = i;
      break;
    }
  }
  // check whether we have found the file to compact
  if (compaction_file_index == std::numeric_limits<size_t>::max()) {  // if we didn't find one, we need to use the next file
    // if we have selected all files, return long max
    if (version_nodes[index].chosen_children.size() == static_cast<size_t>(version_nodes[index].file_num)) {
      version_nodes[index].fully_enumerated = true;
      std::stringstream ss;
      ss << std::setfill('0') << std::setw(sizeof(size_t) * 2) << std::hex << hash_value;
      CS561Log::Log("Terminate reason: all files of version " + ss.str() + " has been selected.");
      return std::numeric_limits<size_t>::max();
    }
    // size is the next index
    compaction_file_index = version_nodes[index].chosen_children.size();
    // add child, use long max as temporary id
    version_nodes[index].chosen_children.push_back(std::numeric_limits<size_t>::max());
    // log chosen children
    std::stringstream ss;
    ss << "Chosen a new child for version " << std::setfill('0') << std::setw(sizeof(size_t) * 2) << std::hex << hash_value << " with index " << compaction_file_index;
    CS561Log::Log(ss.str());
  }
  // set the last version
  last_version_id = index;

  return compaction_file_index;
}

LevelVersionTree::LevelVersionTree(const std::string& fp)
    : file_path(fp) {
  LoadFromFile();
}

LevelVersionTree::~LevelVersionTree() noexcept {
  DumpToFile();
}

void LevelVersionTree::SetCurrentVersionFullyEnumerated() {
  if (last_version_id ==
      std::numeric_limits<size_t>::max()) {
    return;
  }
  // current version is the last version's last child
  if (version_nodes[last_version_id]
          .chosen_children.back() !=
      std::numeric_limits<size_t>::max()) {
    int cur_version_id = static_cast<int>(version_nodes[last_version_id]
                             .chosen_children.back());
    version_nodes[cur_version_id].fully_enumerated = true;
  }
}

bool LevelVersionTree::IsVersionExist(size_t hash_value) {
  return hash_to_id.find(hash_value) != hash_to_id.end();
}

VersionForest::VersionForest(
    const std::vector<std::string>& level_file_path) {
  for (const auto& path : level_file_path)
    level_version_trees.emplace_back(
        LevelVersionTree(path));
}

size_t VersionForest::GetCompactionFile(int level,
                                        size_t hash_value,
                                        int file_num) {
  return level_version_trees[level].GetCompactionFile(
      hash_value, file_num);
}

void VersionForest::DumpToFile() {
  for (auto& lvf : level_version_trees) {
    lvf.DumpToFile();
  }
}

LevelVersionTree& VersionForest::GetLevelVersionTree(
    int level) {
  return level_version_trees[level];
}

bool VersionForest::IsVersionExist(int level,
                                   size_t hash_value) {
  return level_version_trees[level].IsVersionExist(
      hash_value);
}

}  // namespace ROCKSDB_NAMESPACE
