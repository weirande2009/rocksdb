# multiple times for a type
# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/multi_times_7200k_800k_0 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/multi_times_7200k_800k_0 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/multi_times_7200k_800k_0 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/multi_times_7200k_800k_0 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/multi_times_7200k_800k_0 800 1 mnt/rocksdb/ experiment 8

# run different update distribution
# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/update_normal_50_1 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 1
# ./scripts/run_for_a_type.sh 6400000 1600000 0 tmp/update_normal_50_1 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 1
# ./scripts/run_for_a_type.sh 5600000 2400000 0 tmp/update_normal_50_1 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 1
# ./scripts/run_for_a_type.sh 4800000 3200000 0 tmp/update_normal_50_1 800 1 mnt/roocksdb/ experiment 8 1 --UD\ 1
# ./scripts/run_for_a_type.sh 4000000 4000000 0 tmp/update_normal_50_1 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 1

# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/update_normal_50_2 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 1\ --UD_NDEV\ 2
# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/update_normal_50_4 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 1\ --UD_NDEV\ 4
# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/update_normal_50_8 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 1\ --UD_NMP\ 0.25\ --UD_NDEV\ 1
# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/update_normal_50_8 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 1\ --UD_NMP\ 0.25\ --UD_NDEV\ 2
# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/update_normal_50_8 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 1\ --UD_NMP\ 0.25\ --UD_NDEV\ 4

# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/update_normal_50_1 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 2
# ./scripts/run_for_a_type.sh 6400000 1600000 0 tmp/update_normal_50_1 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 2
# ./scripts/run_for_a_type.sh 5600000 2400000 0 tmp/update_normal_50_1 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 2
# ./scripts/run_for_a_type.sh 4800000 3200000 0 tmp/update_normal_50_1 800 1 mnt/roocksdb/ experiment 8 1 --UD\ 2
# ./scripts/run_for_a_type.sh 4000000 4000000 0 tmp/update_normal_50_1 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 2

# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/update_normal_50_1 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 3
# ./scripts/run_for_a_type.sh 6400000 1600000 0 tmp/update_normal_50_1 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 3
# ./scripts/run_for_a_type.sh 5600000 2400000 0 tmp/update_normal_50_1 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 3
# ./scripts/run_for_a_type.sh 4800000 3200000 0 tmp/update_normal_50_1 800 1 mnt/roocksdb/ experiment 8 1 --UD\ 3
# ./scripts/run_for_a_type.sh 4000000 4000000 0 tmp/update_normal_50_1 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 3

# run time for different workload
# time ./scripts/run_for_a_type.sh 8000000 0 0 tmp/run_time_for_different_workload 800 1 mnt/rocksdb/ experiment 8 0 0
# time ./scripts/run_for_a_type.sh 8000000 0 0 tmp/run_time_for_different_workload 800 1 mnt/rocksdb/ experiment 16 0 0

output_dir=tmp/select_last_similar_for_different_workload_all_insert/second
mkdir -p $output_dir
for i in {1..10}
do
    echo $i
    # ./scripts/run_once.sh 8000000 0 0 mnt/rocksdb experiment kSelectLastSimilar 8 0 0
    # mv experiment $output_dir/$i
done

for i in {1..10}
do
    echo $i
    # ./scripts/run_once.sh 8000000 0 0 mnt/rocksdb experiment kSelectLastSimilar 8 0 0
    # mv experiment $output_dir/$i
done


# ./scripts/run_once.sh 5400000 0 0 mnt/rocksdb experiment kMinOverlappingRatio 16 0 0
# mv experiment tmp/min_overlapping_ratio_for_different_workload/10


