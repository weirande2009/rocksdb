#include <iostream>
#include <fstream>
#include <vector>
#include <map>
#include <string>
#include <filesystem>

void read_result_file(const std::string& filename) {
    std::ifstream result_file(filename + "/log.txt");
    if (!result_file) {
        std::cerr << "Error: cannot open file '" << filename << "'" << std::endl;
        return;
    }

    std::string line;
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

    // std::cout << "count: " << count << std::endl;

    // write to file in the same directory as the input file
    std::string output_filename = filename + "/analysis.txt";
    std::ofstream output_file(output_filename);
    if (!output_file) {
        std::cerr << "Error: cannot open file '" << output_filename << "'" << std::endl;
        return;
    }
    
    // write mor_wb
    output_file << "MinOverlappingRatio" << std::endl;
    for (int i = 0; i < mor_wb.size(); i++) {
        output_file << i << " compaction: " << mor_wb[i] << std::endl;
    }

    // write om_wb
    output_file << "Our method" << std::endl;
    for (int i = 0; i < om_wb.size(); i++) {
        output_file << i << " compaction: " << om_wb[i] << std::endl;
    }

    result_file.close();
}

void read_result_directory(const std::string& directory) {
    for (const auto& entry : std::filesystem::directory_iterator(directory)) {
        if (!entry.is_directory()) {
            continue;
        }
        read_result_file(entry.path().string());
    }
}

void analyze_directory(const std::string& directory) {
    for (const auto& entry : std::filesystem::directory_iterator(directory)) {
        if (!entry.is_directory()) {
            continue;
        }
        read_result_directory(entry.path().string());
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
