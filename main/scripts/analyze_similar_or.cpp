#include <iostream>
#include <fstream>
#include <vector>
#include <map>
#include <string>
#include <filesystem>

void read_result_file(const std::string& dirname) {
    std::ifstream result_file(dirname + "/log.txt");
    if (!result_file) {
        std::cerr << "Error: cannot open file '" << dirname << "'" << std::endl;
        return;
    }

    std::string line;
    while (std::getline(result_file, line)) {
        if (line.find("Compaction strategy: ") != std::string::npos) {
            break;
        }
    }

    bool valid = false;
    bool reading = false;
    int similar_compaction_times = 0;
    while (std::getline(result_file, line)) {
        if (line.find("Compaction strategy: ") != std::string::npos) {
            break;
        }

        if (line.find("in level 1 Choice") != std::string::npos) {
            valid = true;
            continue;
        }

        if (valid && line.find("Information of files in level 1: ") != std::string::npos) {
            reading = true;
            continue;
        }

        if (reading) {
            std::vector<uint64_t> overlapping_ratio;
            while (std::getline(result_file, line)){
                if (line.empty()) {
                    break;
                }

                // split line by \t
                size_t pos = 0;
                std::vector<std::string> parts;
                std::string token;
                while ((pos = line.find("\t")) != std::string::npos) {
                    if (pos == 0) {
                        line.erase(0, 1);
                        continue;
                    }
                    token = line.substr(0, pos);
                    parts.push_back(token);
                    line.erase(0, pos + 1);
                }

                // get the last one
                overlapping_ratio.push_back(std::stoull(parts[parts.size() - 1]));
                // std::cout << overlapping_ratio.back() << std::endl;
            }

            // get the minimum overlapping ratio
            uint64_t min_overlapping_ratio = *std::min_element(overlapping_ratio.begin(), overlapping_ratio.end());
            int min_overlapping_ratio_index = std::distance(overlapping_ratio.begin(), std::min_element(overlapping_ratio.begin(), overlapping_ratio.end()));
            // std::cout << "Min overlapping ratio: " << min_overlapping_ratio << std::endl;
            // check if there is other files with similiar overlapping ratio
            if (min_overlapping_ratio > 0) {
                for (size_t i = 0; i < overlapping_ratio.size(); i++) {
                    if (i == min_overlapping_ratio_index) {
                        continue;
                    }
                    if (overlapping_ratio[i] <= min_overlapping_ratio * 1.05) {
                        similar_compaction_times++;
                        break;
                    }
                }
            }

            reading = false;
            valid = false;
        }

    }

    std::cout << "Similar compaction times: " << similar_compaction_times << std::endl;

    std::cout << "====================" << std::endl;

    // second time
    valid = false;
    reading = false;
    similar_compaction_times = 0;
    int same_choice_times = 0;
    while (std::getline(result_file, line)) {
        if (line.find("Compaction strategy: ") != std::string::npos) {
            break;
        }

        if (line.find("in level 1 Choice") != std::string::npos) {
            valid = true;
            continue;
        }

        if (valid && line.find("Information of files in level 1: ") != std::string::npos) {
            reading = true;
            continue;
        }

        if (reading) {
            std::vector<uint64_t> overlapping_ratio;
            int choice_num;
            while (std::getline(result_file, line)){
                if (line.empty()) {
                    break;
                }

                // split line by \t
                size_t pos = 0;
                std::vector<std::string> parts;
                std::string token;
                while ((pos = line.find("\t")) != std::string::npos) {
                    if (pos == 0) {
                        line.erase(0, 1);
                        continue;
                    }
                    token = line.substr(0, pos);
                    parts.push_back(token);
                    line.erase(0, pos + 1);
                }

                // get the last one
                overlapping_ratio.push_back(std::stoull(parts[parts.size() - 1]));
                // std::cout << overlapping_ratio.back() << std::endl;

                // check *
                if (parts.size() > 0 && parts[0].back() == '*') {
                    // get the first part without *
                    std::string choice = parts[0].substr(0, parts[0].size() - 1);
                    choice_num = std::stoi(choice);
                }
            }

            // get the minimum overlapping ratio
            uint64_t min_overlapping_ratio = *std::min_element(overlapping_ratio.begin(), overlapping_ratio.end());
            // get the minimum overlapping ratio's index
            int min_overlapping_ratio_index = std::distance(overlapping_ratio.begin(), std::min_element(overlapping_ratio.begin(), overlapping_ratio.end()));
            // check if there is other files with similiar overlapping ratio
            if (min_overlapping_ratio > 0) {
                for (size_t i = 0; i < overlapping_ratio.size(); i++) {
                    if (i == min_overlapping_ratio_index) {
                        continue;
                    }
                    if (overlapping_ratio[i] <= min_overlapping_ratio * 1.05) {
                        similar_compaction_times++;
                        std::cout << "min_overlapping_ratio_index: " << min_overlapping_ratio_index << std::endl;
                        std::cout << "choice_num: " << choice_num << std::endl;
                        if (min_overlapping_ratio_index == choice_num) {
                            same_choice_times++;
                        }
                        break;
                    }
                }
            }

            reading = false;
            valid = false;
        }

    }

    std::cout << "Similar compaction times: " << similar_compaction_times << std::endl;
    std::cout << "Same choice times: " << same_choice_times << std::endl;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
      std::cerr << "Usage: analyze_result <result_file>" << std::endl;
      return 1;
    }

    read_result_file(argv[1]);
    return 0;
}
