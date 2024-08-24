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
        result[res[0]] = [int(res[1]), float(res[2]), int(res[3])]
    result_file.close()
    return result

def analyze_a_type(directory):
    total_bytes = 2000000 * 64
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
    accumulative_wa = {}
    for res in result:
        for k, v in res.items():
            if k not in accumulative_wa:
                accumulative_wa[k] = []
            accumulative_wa[k].append(v[1])
    accumulative_duration = {}
    for res in result:
        for k, v in res.items():
            if k not in accumulative_duration:
                accumulative_duration[k] = []
            accumulative_duration[k].append(v[2])
    statistics = {}
    statistics['minimum'] = {}
    v = accumulative['minimum']
    statistics['minimum']['mean'] = np.mean(v)
    statistics['minimum']['median'] = np.median(v)
    statistics['minimum']['std'] = np.std(v)
    statistics['minimum']['min'] = np.min(v)
    statistics['minimum']['max'] = np.max(v)
    statistics['minimum']['25th'] = np.percentile(v, 25)
    statistics['minimum']['75th'] = np.percentile(v, 75)
    statistics['minimum']['duration'] = -1
    statistics['minimum']['wa'] = statistics['minimum']['mean'] / total_bytes
    statistics['minimum']['distance'] = -1

    for k, v in accumulative.items():
        if k == 'minimum':
            continue
        if k not in statistics:
            statistics[k] = {}
        mean_array = np.sort(np.array(v))[1:-1]
        # print(mean_array.shape)
        statistics[k]['mean'] = np.mean(mean_array)
        statistics[k]['mean'] = np.mean(v)
        statistics[k]['median'] = np.median(v)
        statistics[k]['std'] = np.std(v)
        statistics[k]['min'] = np.min(v)
        statistics[k]['max'] = np.max(v)
        statistics[k]['25th'] = np.percentile(v, 25)
        statistics[k]['75th'] = np.percentile(v, 75)
        statistics[k]['duration'] = np.mean(accumulative_duration[k])
        statistics[k]['wa'] = np.mean(accumulative_wa[k])
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
    # minimums = []
    # get the subdirectories in one layer deep
    subdirectories = [os.path.join(directory, d) for d in os.listdir(directory) if os.path.isdir(os.path.join(directory, d))]
    for dir in subdirectories:
        print(dir)
        result.append(read_result(dir))
        # minimums.append(read_minimum(dir))
    # compute average, maximum, minimum, median, mean, and standard deviation
    accumulative = {}
    for res in result:
        for k, v in res.items():
            if k not in accumulative:
                accumulative[k] = []
            accumulative[k].append(v[0])
    # accumulative['minimum'] = minimums
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

def analyze_minimum(directory):
    total_bytes = 2000000 * 64
    minimums = []
    # get the subdirectories in one layer deep
    subdirectories = [os.path.join(directory, d) for d in os.listdir(directory) if os.path.isdir(os.path.join(directory, d))]
    for dir in subdirectories:
        minimums.append(read_minimum(dir))
    # compute average, maximum, minimum, median, mean, and standard deviation
    accumulative = {}
    accumulative['minimum'] = minimums
    accumulative['minimum'] = minimums
    statistics = {}
    statistics['minimum'] = {}
    v = accumulative['minimum']
    statistics['minimum']['mean'] = np.mean(v)
    statistics['minimum']['median'] = np.median(v)
    statistics['minimum']['std'] = np.std(v)
    statistics['minimum']['min'] = np.min(v)
    statistics['minimum']['max'] = np.max(v)
    statistics['minimum']['25th'] = np.percentile(v, 25)
    statistics['minimum']['75th'] = np.percentile(v, 75)
    statistics['minimum']['duration'] = -1
    statistics['minimum']['wa'] = statistics['minimum']['mean'] / total_bytes
    statistics['minimum']['distance'] = -1

    # output the result
    output_file = open(os.path.join(directory, 'result.txt'), 'w')
    # output_file.write("Strategy\tMean\tMedian\tStd\tMin\tMax\t25th\t75th\tduration(us)\tavg WA\tDistance(%)\n")
    # for k, v in statistics.items():
    #     output_file.write("%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%f\t%f\n" % (k, v['mean'], v['median'], v['std'], v['min'], v['max'], v['25th'], v['75th'], v['duration'], v['wa'], v['distance']))
    output_file.write("Strategy\tMean\tMedian\tStd\tMin\tMax\t25th\t75th\tduration(us)\tavg WA\n")
    for k, v in statistics.items():
        output_file.write("%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%f\n" % (k, v['mean'], v['median'], v['std'], v['min'], v['max'], v['25th'], v['75th'], v['duration'], v['wa']))


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
    root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/edbt_revision/compare_distribution/5gb/first_run/uniform'

    # dir1
    names = ['100_0_0', '90_10_0', '80_20_0', '70_30_0', '60_40_0', '50_50_0', '40_60_0', '30_70_0', '20_80_0', '10_90_0']

    # walk through
    for name in names:
        directory = root_path + '/' + name
        analyze_a_type(directory)
    
    # for dir in os.listdir(root_path):
    #     if not os.path.isdir(os.path.join(root_path, dir)):
    #         continue
    #     sub_path = os.path.join(root_path, dir)
    #     analyze_a_type(sub_path)
    #     analyze_a_type_short(sub_path)

def collect_depth_2():
    # root path
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/edbt_revision/compare_distribution/5gb/first_run'
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/edbt_revision/compare_workload_size/first_run'
    root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/edbt_revision/compare_optimal_policies/2000000_64_8_memory/first_run'
    
    # dir1
    # names_1 = ['update_normal1', 'update_normal2', 'update_normal3', 'update_zipfian1', 'update_zipfian2', 'update_zipfian3']
    # names_1 = ['10_1024_size', '20_512_size', '20_1024_size', '40_512_size', '40_1024_size', '80_512_size']
    names_1 = ['100_0', '80_20', '60_40']
    # names_1 = ['90_10', '70_30', '50_50']

    # dir2
    # names_2 = ['90_10_0', '70_30_0', '50_50_0']
    # names_2 = ['100_0', '75_25', '50_50']
    names_2 = ['skip', 'non_skip', 'optimal']
    # names_2 = ['skip']

    # walk through
    for name1 in names_1:
        for name2 in names_2:
            directory = root_path + '/' + name1 + '/' + name2
            analyze_a_type(directory)

    # for dir in os.listdir(root_path):
    #     if not os.path.isdir(os.path.join(root_path, dir)):
    #         continue
    #     if dir == 'update_distribution_influence':
    #         continue
    #     sub_path = os.path.join(root_path, dir)
    #     for subdir in os.listdir(sub_path):
    #         if not os.path.isdir(os.path.join(sub_path, subdir)):
    #             continue
    #         analyze_a_type(os.path.join(sub_path, subdir))
    #         analyze_a_type_short(os.path.join(sub_path, subdir))

def collect_depth_3():
    # root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/edbt/write_buffer_data_structure'
    root_path = '/Users/weiran/BU/Thesis/rocksdb/main/workspace/edbt/file_size/mixed'
    # names_1 = ['normal', 'uniform', 'zipfian']
    names_1 = ['16M', '32M', '64M', '128M']
    # names_2 = ['hash_link_list/5242880_1024', 'hash_skip_list/5242880_1024', 'skip_list/5242880_1024', 'vector/5242880_1024']
    names_2 = ['4', '6', '8', '10']
    # names_3 = ['100_0_0', '75_25_0', '50_50_0']
    names_3 = ['100_0', '50_50']

    for name1 in names_1:
        for name2 in names_2:
            for name3 in names_3:
                directory = root_path + '/' + name1 + '/' + name2 + '/' + name3
                analyze_a_type(directory)
                analyze_a_type_short(directory)

def main():
    # collect_depth_1()
    collect_depth_2()
    # collect_depth_3()

if __name__ == '__main__':
    main()