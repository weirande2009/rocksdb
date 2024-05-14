import os
import numpy as np

def read_minimum(directory):
    minimum_file = open(os.path.join(directory, 'minimum.txt'), 'r')
    # read the first line of minimum file and get the first number
    minimum = int(minimum_file.readline().split()[0])
    minimum_file.close()
    return minimum

def read_result(directory):
    result_file = open(os.path.join(directory, 'result.txt'), 'r')
    result_file_data = result_file.read().split("\n")[1:]
    result = {}
    for line in result_file_data:
        if len(line) == 0:
            continue
        res = line.split("\t")
        result[res[0]] = [int(res[1]), int(res[2])]
    result_file.close()
    return result

def analyze_a_type(directory):
    total_bytes = 5 * 1024 *1024 * 1024
    result = []
    minimums = []
    # get the subdirectories in one layer deep
    subdirectories = [os.path.join(directory, d) for d in os.listdir(directory) if os.path.isdir(os.path.join(directory, d))]
    for dir in subdirectories:
        print(dir)
        result.append(read_result(dir))
        minimums.append(read_minimum(dir))
    # compute average, maximum, minimum, median, mean, and standard deviation
    accumulative = {}
    for res in result:
        for k, v in res.items():
            if k not in accumulative:
                accumulative[k] = []
            accumulative[k].append(v[0])
    accumulative['minimum'] = minimums
    accumulative_duration = {}
    for res in result:
        for k, v in res.items():
            if k not in accumulative_duration:
                accumulative_duration[k] = []
            accumulative_duration[k].append(v[1])
    statistics = {}
    # statistics['minimum'] = {}
    # v = accumulative['minimum']
    # statistics['minimum']['mean'] = np.mean(v)
    # statistics['minimum']['median'] = np.median(v)
    # statistics['minimum']['std'] = np.std(v)
    # statistics['minimum']['min'] = np.min(v)
    # statistics['minimum']['max'] = np.max(v)
    # statistics['minimum']['25th'] = np.percentile(v, 25)
    # statistics['minimum']['75th'] = np.percentile(v, 75)
    # statistics['minimum']['duration'] = -1
    # statistics['minimum']['wa'] = statistics['minimum']['mean'] / total_bytes
    # statistics['minimum']['distance'] = -1

    for k, v in accumulative.items():
        if k == 'minimum':
            continue
        if k not in statistics:
            statistics[k] = {}
        statistics[k]['mean'] = np.mean(v)
        statistics[k]['median'] = np.median(v)
        statistics[k]['std'] = np.std(v)
        statistics[k]['min'] = np.min(v)
        statistics[k]['max'] = np.max(v)
        statistics[k]['25th'] = np.percentile(v, 25)
        statistics[k]['75th'] = np.percentile(v, 75)
        statistics[k]['duration'] = np.mean(accumulative_duration[k])
        statistics[k]['wa'] = statistics[k]['mean'] / total_bytes
        # statistics[k]['distance'] = (statistics[k]['mean'] - statistics['minimum']['mean']) / statistics[k]['mean'] * 100
    
    # output the result
    output_file = open(os.path.join(directory, 'result.txt'), 'w')
    # output_file.write("Strategy\tMean\tMedian\tStd\tMin\tMax\t25th\t75th\tduration(us)\tavg WA\tDistance(%)\n")
    # for k, v in statistics.items():
    #     output_file.write("%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%f\t%f\n" % (k, v['mean'], v['median'], v['std'], v['min'], v['max'], v['25th'], v['75th'], v['duration'], v['wa'], v['distance']))
    output_file.write("Strategy\tMean\tMedian\tStd\tMin\tMax\t25th\t75th\tduration(us)\tavg WA\n")
    for k, v in statistics.items():
        output_file.write("%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%f\n" % (k, v['mean'], v['median'], v['std'], v['min'], v['max'], v['25th'], v['75th'], v['duration'], v['wa']))


def analyze_a_type_short(directory):
    result = []
    minimums = []
    # get the subdirectories in one layer deep
    subdirectories = [os.path.join(directory, d) for d in os.listdir(directory) if os.path.isdir(os.path.join(directory, d))]
    for dir in subdirectories:
        print(dir)
        result.append(read_result(dir))
        minimums.append(read_minimum(dir))
    # compute average, maximum, minimum, median, mean, and standard deviation
    accumulative = {}
    for res in result:
        for k, v in res.items():
            if k not in accumulative:
                accumulative[k] = []
            accumulative[k].append(v[0])
    accumulative['minimum'] = minimums
    accumulative_duration = {}
    for res in result:
        for k, v in res.items():
            if k not in accumulative_duration:
                accumulative_duration[k] = []
            accumulative_duration[k].append(v[1])
    statistics = {}
    for k, v in accumulative.items():
        if k not in statistics:
            statistics[k] = {}
        statistics[k]['mean'] = np.mean(v)
        if k in accumulative_duration:
            statistics[k]['duration'] = np.mean(accumulative_duration[k])
        else:
            statistics[k]['duration'] = -1
    # output the result
    output_file = open(os.path.join(directory, 'short_result.txt'), 'w')
    output_file.write("\t")
    for k, v in statistics.items():
        output_file.write("%s\t" % k)
    output_file.write("\n")
    output_file.write("Mean\t")
    for k, v in statistics.items():
        output_file.write("%d\t" % v['mean'])

def arrange(directory):
    # output file
    output_file = open(os.path.join(directory, 'result.txt'), 'w')
    result = {}
    for dir in os.listdir(directory):
        if not os.path.isdir(os.path.join(directory, dir)):
            continue
        dir_name = os.path.join(directory, dir)
        print(dir_name)
        file = open(os.path.join(dir_name, 'result.txt'), 'r')
        data = file.read()
        # output_file.write(dir + '\n')
        # output_file.write(data + '\n')
        result[dir] = data
        file.close()
    # sort by key in descending order
    result = sorted(result.items(), key=lambda x: x[0], reverse=True)
    # output the result
    for res in result:
        output_file.write(res[0] + '\n')
        output_file.write(res[1] + '\n')
    output_file.close()

def arrange_short(directory):
    # output file
    output_file = open(os.path.join(directory, 'short_result.txt'), 'w')
    result = {}
    for dir in os.listdir(directory):
        if not os.path.isdir(os.path.join(directory, dir)):
            continue
        dir_name = os.path.join(directory, dir)
        print(dir_name)
        file = open(os.path.join(dir_name, 'short_result.txt'), 'r')
        data = file.read()
        # output_file.write(dir + '\n')
        # output_file.write(data + '\n')
        result[dir] = data
        file.close()
    # sort by key in descending order
    result = sorted(result.items(), key=lambda x: x[0], reverse=True)
    # output the result
    for res in result:
        output_file.write(res[0] + '\n')
        output_file.write(res[1] + '\n')
    output_file.close()

def analyze_optimal(file_path):
    file = open(file_path, 'r')
    data = file.read().split("\n")
    file.close()

def collect_depth_1():
    # root path
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_optimal_with_baselines/2500000_64_8_memory/first_run'
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_optimal_with_baselines/307200_64_8_memory/first_run/buffer_size_1MB'
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_optimal_with_baselines/225280_64_8_memory/first_run/buffer_size_512KB'
    root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_delete/5gb/first_run/5242880'

    # dir1
    # names = ['50_50', '60_40', '70_30', '80_20', '90_10', '100_0']
    # names = ['50_50_0', '60_40_0', '70_30_0', '80_20_0', '90_10_0', '100_0_0']
    # names = ['80_10_10', '80_12_8', '80_14_6', '80_16_4', '80_18_2']
    names = ['100_0_5', '100_0_10', '100_0_15', '100_0_20', '100_0_25', '100_0_30', '100_0_35', '100_0_40', '100_0_45', '100_0_50']

    # walk through
    for name in names:
        directory = root_path + '/' + name
        analyze_a_type(directory)
        analyze_a_type_short(directory)

def collect_depth_2():
    # root path
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_optimal_with_baselines/2500000_64_8_memory/first_run'
    root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_devices/5gb/first_run'
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_workload_size/first_run'
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_distribution/5gb/first_run'

    # dir1
    # names_1 = ['normal1', 'normal2', 'normal3', 'zipfian1', 'zipfian2', 'zipfian3']
    names_1 = ['50_50', '60_40', '70_30', '80_20', '90_10', '100_0']
    # names_1 = ['80_10_10', '80_12_8', '80_14_6', '80_16_4', '80_18_2']
    # names_1 = ['size_5_2048', 'size_5_4096', 'size_5_8192', 'size_10_1024', 'size_20_1024', 'size_40_1024']

    # dir2
    # names_2 = ['90_10_0', '70_30_0', '50_50_0']
    names_2 = ['nvme1', 'ssd']
    # names_2 = ['50_50', '75_25', '100_0']

    # walk through
    for name1 in names_1:
        for name2 in names_2:
            directory = root_path + '/' + name1 + '/' + name2
            analyze_a_type(directory)
            analyze_a_type_short(directory)

    # for dir in os.listdir(root_path):
    #     if not os.path.isdir(os.path.join(root_path, dir)):
    #         continue
    #     sub_path = os.path.join(root_path, dir)
    #     for subdir in os.listdir(sub_path):
    #         if not os.path.isdir(os.path.join(sub_path, subdir)):
    #             continue
    #         analyze_a_type(os.path.join(sub_path, subdir))
    #         analyze_a_type_short(os.path.join(sub_path, subdir))

def collect(depth):
    '''depth 1'''
    

    '''depth 2'''

    # names_1 = ['size_5_2048', 'size_5_4096', 'size_5_8192', 'size_10_1024', 'size_20_1024', 'size_40_1024']
    # names_2 = ['50_50', '75_25', '100_0']
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_workload_size/first_run'
    # names_1 = ['normal1', 'normal2', 'normal3', 'zipfian1', 'zipfian2', 'zipfian3']
    # names_2 = ['50_50', '60_40', '70_30', '80_20', '90_10', '100_0']
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_update_distribution/5gb/first_run'
    # for name1 in names_1:
    #     for name2 in names_2:
    #         directory = root_path + '/' + name1 + '/' + name2
    #         analyze_a_type(directory)
    # names = ['non_skip', 'skip', 'optimal']
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_optimal_policies/1250000_1250000_0_64_8_memory/first_run'
    # names = ['50_50', '60_40', '70_30', '80_20', '90_10', '100_0']
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_optimal_with_baselines/2500000_64_8_nvme1/first_run'
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_optimal_with_baselines/2500000_64_8_memory/first_run'
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_delete/5gb/first_run/5242880'
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_workload_size/first_run'
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/case_study/first_run/100_0'
    # names = ['80_10_10', '80_12_8', '80_14_6', '80_16_4', '80_18_2']
    # names = ['100_0_5', '100_0_10', '100_0_15', '100_0_20', '100_0_25', '100_0_30', '100_0_35', '100_0_40', '100_0_45', '100_0_50']
    # for name in names:
    #     directory = root_path + '/' + name
    #     analyze_a_type(directory)
    #     analyze_a_type_short(directory)
    # analyze_a_type(root_path)
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_devices/5gb/first_run'
    # names_1 = ['80_10_10', '80_12_8', '80_14_6', '80_16_4', '80_18_2', '80_20']
    # names_2 = ['nvme1', 'ssd']
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_update_distribution/5gb/first_run'
    # names_1 = ['normal1', 'normal2', 'normal3', 'normal4', 'normal5', 'normal6']
    # names_1 = ['normal1', 'normal2', 'normal3', 'zipfian1', 'zipfian2', 'zipfian3']
    # names_1 = ['normal1', 'normal2', 'normal3', 'zipfian1', 'zipfian2', 'zipfian3']
    # names_2 = ['80_10_10', '80_12_8', '80_14_6', '80_16_4', '80_18_2']
    # names_2 = ['90_10_0', '70_30_0', '50_50_0']
    # for name1 in names_1:
    #     for name2 in names_2:
    #         directory = root_path + '/' + name1 + '/' + name2
    #         analyze_a_type(directory)
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_distribution/5gb/first_run'
    # for dir in os.listdir(root_path):
    #     if not os.path.isdir(os.path.join(root_path, dir)):
    #         continue
    #     sub_path = os.path.join(root_path, dir)
    #     for subdir in os.listdir(sub_path):
    #         if not os.path.isdir(os.path.join(sub_path, subdir)):
    #             continue
    #         analyze_a_type(os.path.join(sub_path, subdir))
    #         analyze_a_type_short(os.path.join(sub_path, subdir))
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_optimal_with_baselines/307200_64_8_memory/first_run/buffer_size_1MB'
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_optimal_with_baselines/225280_64_8_memory/first_run/buffer_size_512KB'
    # for dir in os.listdir(root_path):
    #     if not os.path.isdir(os.path.join(root_path, dir)):
    #         continue
    #     sub_path = os.path.join(root_path, dir)
    #     analyze_a_type(sub_path)
    #     analyze_a_type_short(sub_path)


def collect_2():
    # names = ['normal1', 'normal2', 'normal3', 'zipfian1', 'zipfian2', 'zipfian3']
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_update_distribution/5gb/first_run'
    # names = ['size_5_2048', 'size_5_4096', 'size_5_8192', 'size_10_1024', 'size_20_1024', 'size_40_1024']
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_workload_size/first_run'
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_update_distribution/5gb/first_run'
    # names = ['80_10_10', '80_12_8', '80_14_6', '80_16_4', '80_18_2', '80_20']
    # for name in names:
    #     directory = root_path + '/' + name
    #     arrange(directory)
    # arrange('/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_optimal_policies/1250000_1250000_0_64_8_memory/first_run')
    # arrange_short('/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_optimal_policies/1250000_1250000_0_64_8_memory/first_run')
    # arrange('/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_optimal_with_baselines/2500000_64_8_nvme1/first_run')
    # arrange('/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_optimal_with_baselines/2500000_64_8_memory/first_run')
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_optimal_with_baselines/2500000_64_8_memory/first_run'
    # names = ['80_10_10', '80_12_8', '80_14_6', '80_16_4', '80_18_2', '80_20']
    # names = ['normal1', 'normal2', 'normal3', 'zipfian1', 'zipfian2', 'zipfian3']
    # for name in names:
    #     directory = root_path + '/' + name
    #     arrange(directory)
    #     arrange_short(directory)
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_distribution/5gb/first_run' 
    # for dir in os.listdir(root_path):
    #     if not os.path.isdir(os.path.join(root_path, dir)):
    #         continue
    #     sub_path = os.path.join(root_path, dir)
    #     arrange(sub_path)
    #     arrange_short(sub_path)
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_optimal_with_baselines/307200_64_8_memory/first_run/buffer_size_1MB'
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_optimal_with_baselines/225280_64_8_memory/first_run/buffer_size_512KB'
    root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/compare_optimal_with_baselines/2500000_64_8_memory/first_run'
    arrange(root_path)
    arrange_short(root_path)

def main():
    # collect_depth_1()
    collect_depth_2()
    # collect_2()

if __name__ == '__main__':
    main()