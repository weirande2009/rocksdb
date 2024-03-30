#include <iostream>
#include <fstream>
#include <vector>
#include <map>
#include <string>
#include <filesystem>

struct Info {
    int64_t wa;
    int64_t wa_median;
    int64_t wa_stddev;
    int compaction_times;
    uint64_t duration;
    int similar_compaction_times;
    int same_choice_times;  // only for om
};

struct Result {
    std::unordered_map<std::string, Info> results;
};

void read_log_file_get_compaction_detail(const std::string& dirname, Result& result) {
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
                        result.mor_similar_compaction_times++;
                        break;
                    }
                }
            }

            reading = false;
            valid = false;
        }

    }

    // second time
    valid = false;
    reading = false;
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
                        result.om_similar_compaction_times++;
                        if (min_overlapping_ratio_index == choice_num) {
                            result.om_same_choice_times++;
                        }
                        break;
                    }
                }
            }

            reading = false;
            valid = false;
        }

    }
}


void read_result_file(const std::string& filename, Result& result) {
    std::ifstream result_file(filename + "/result.txt");
    if (!result_file) {
        std::cerr << "Error: cannot open file '" << filename << "'" << std::endl;
        return;
    }

    std::string line;
    int time_count = 0;
    while (std::getline(result_file, line)) {
        if (line.find("MinOverlappingRatio") != std::string::npos) {
            result.min_overlapping_ratio_wa = std::stoull(line.substr(line.find(":") + 2));
        } else if (line.find("SelectLastSimilar") != std::string::npos) {
            result.select_last_similar_wa = std::stoull(line.substr(line.find(":") + 2));
        } else if (line.find("Total running time") != std::string::npos) {
            time_count++;
            if (time_count == 1) {
                result.mor_duration = std::stoll(line.substr(line.find(":") + 2));
            } else if (time_count == 2) {
                result.om_duration = std::stoll(line.substr(line.find(":") + 2));
            }
        }
    }

    result_file.close();
    // return;

    result_file.open(filename + "/log.txt");
    if (!result_file) {
        std::cerr << "Error: cannot open file '" << filename << "'" << std::endl;
        return;
    }

    while (std::getline(result_file, line)) {
        if (line.find("Compaction strategy: ") != std::string::npos) {
            break;
        }
    }

    std::vector<uint64_t> mor_wb;
    while (std::getline(result_file, line)) {
        if (line.find("Compaction strategy: ") != std::string::npos) {
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

        // check * in parts[0]
        if (parts.size() > 0 && parts[0].back() == '*') {
            // get the last two elements 
            uint64_t file_size = std::stoull(parts[parts.size() - 2]);
            uint64_t overlapping_ratio = std::stoull(parts[parts.size() - 1]);
            uint64_t written_bytes = file_size * (1 + overlapping_ratio) / 1000;
            mor_wb.push_back(written_bytes);
        }
    }

    result.mor_compaction_times = mor_wb.size();

    std::vector<uint64_t> om_wb;
    bool valid = false;
    uint64_t count = 0;
    while (std::getline(result_file, line)) {
        if (line.find("Compaction strategy: ") != std::string::npos) {
            break;
        }
        if (line.find("in level 1 Choice") != std::string::npos) {
            valid = true;
            count++;
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

        // check * in parts[0]
        if (parts.size() > 0 && parts[0].back() == '*' && valid) {
            // get the last two elements 
            uint64_t file_size = std::stoull(parts[parts.size() - 2]);
            uint64_t overlapping_ratio = std::stoull(parts[parts.size() - 1]);
            uint64_t written_bytes = file_size * (1 + overlapping_ratio) / 1000;
            om_wb.push_back(written_bytes);
            valid = false;
        }
    }

    result.om_compaction_times = om_wb.size();

    result_file.close();
}

void read_result_directory(const std::string& directory, std::vector<Result>& results) {
    for (const auto& entry : std::filesystem::directory_iterator(directory)) {
        Result result;
        read_result_file(entry.path().string(), result);
        read_log_file_get_compaction_detail(entry.path().string(), result);
        results.push_back(result);
    }
}

void analyze_directory(const std::string& directory) {
    std::map<std::string, std::vector<Result>> results;
    for (const auto& entry : std::filesystem::directory_iterator(directory)) {
        if (!entry.is_directory()) {
            continue;
        }
        std::vector<Result> result;
        read_result_directory(entry.path().string(), result);
        results[entry.path().filename().string()] = result;
    }

    // compute the avarage distance between two results
    std::map<std::string, Result> averages;
    for (const auto& [name, result] : results) {
        Result res;
        int64_t smallest_mor_wa = INT64_MAX;
        int64_t largest_mor_wa = INT64_MIN;
        std::vector<int64_t> mor_wa;
        std::vector<int64_t> om_wa;
        for (int i = 0; i < result.size(); i++) {
            res.distance += static_cast<double>(result[i].min_overlapping_ratio_wa - result[i].select_last_similar_wa) / result[i].min_overlapping_ratio_wa;
            res.min_overlapping_ratio_wa += result[i].min_overlapping_ratio_wa;
            res.select_last_similar_wa += result[i].select_last_similar_wa;
            res.mor_compaction_times += result[i].mor_compaction_times;
            res.om_compaction_times += result[i].om_compaction_times;
            res.mor_duration += result[i].mor_duration;
            res.om_duration += result[i].om_duration;
            res.mor_similar_compaction_times += result[i].mor_similar_compaction_times;
            res.om_similar_compaction_times += result[i].om_similar_compaction_times;
            res.om_same_choice_times += result[i].om_same_choice_times;
            if (result[i].min_overlapping_ratio_wa < smallest_mor_wa) {
                smallest_mor_wa = result[i].min_overlapping_ratio_wa;
            }
            if (result[i].min_overlapping_ratio_wa > largest_mor_wa) {
                largest_mor_wa = result[i].min_overlapping_ratio_wa;
            }
            mor_wa.push_back(result[i].min_overlapping_ratio_wa);
            om_wa.push_back(result[i].select_last_similar_wa);
        }
        // compute the median and standard deviation of min_overlapping_ratio_wa
        std::sort(mor_wa.begin(), mor_wa.end());
        std::sort(om_wa.begin(), om_wa.end());
        res.min_overlapping_ratio_median = mor_wa[mor_wa.size() / 2];
        res.min_overlapping_ratio_stddev = 0;
        for (int i = 0; i < mor_wa.size(); i++) {
            res.min_overlapping_ratio_stddev += (mor_wa[i] - res.min_overlapping_ratio_median) * (mor_wa[i] - res.min_overlapping_ratio_median);
        }
        res.min_overlapping_ratio_stddev = std::sqrt(res.min_overlapping_ratio_stddev / mor_wa.size());
        res.select_last_similar_median = om_wa[om_wa.size() / 2];
        res.select_last_similar_stddev = 0;
        for (int i = 0; i < om_wa.size(); i++) {
            res.select_last_similar_stddev += (om_wa[i] - res.select_last_similar_median) * (om_wa[i] - res.select_last_similar_median);
        }
        res.select_last_similar_stddev = std::sqrt(res.select_last_similar_stddev / om_wa.size());
        res.distance /= result.size();
        res.min_overlapping_ratio_wa /= result.size();
        res.select_last_similar_wa /= result.size();
        res.mor_compaction_times /= result.size();
        res.om_compaction_times /= result.size();
        res.mor_duration /= result.size();
        res.om_duration /= result.size();
        res.mor_similar_compaction_times /= static_cast<double>(result.size());
        res.om_similar_compaction_times /= static_cast<double>(result.size());
        res.om_same_choice_times /= static_cast<double>(result.size());
        res.max_mor_distance = static_cast<double>(largest_mor_wa - smallest_mor_wa) / largest_mor_wa * 100;
        averages[name] = res;
    }

    // write the result to a file
    std::ofstream output_file(directory + "/result.txt");
    for (const auto& [name, ave] : averages) {
        output_file << name << "\t"<< ave.min_overlapping_ratio_wa << "\t";
        output_file << ave.select_last_similar_wa << "\t";
        output_file << ave.distance*100 << "%\t";
        output_file << ave.max_mor_distance << "%\t";
        output_file << ave.min_overlapping_ratio_median << "\t";
        output_file << ave.min_overlapping_ratio_stddev << "\t";
        output_file << ave.select_last_similar_median << "\t";
        output_file << ave.select_last_similar_stddev << "\t";
        output_file << ave.mor_duration << "\t";
        output_file << ave.om_duration << "\t";
        output_file << static_cast<double>(ave.mor_duration - ave.om_duration) / ave.mor_duration * 100 << "%\t";
        output_file << ave.mor_similar_compaction_times << "\t";
        output_file << ave.om_similar_compaction_times << "\t";
        output_file << ave.om_same_choice_times << "\t";
        output_file << ave.mor_compaction_times << "\t";
        output_file << ave.om_compaction_times << std::endl;
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
      std::cerr << "Usage: analyze_result <result_file>" << std::endl;
      return 1;
    }

    analyze_directory(argv[1]);
    return 0;
}
