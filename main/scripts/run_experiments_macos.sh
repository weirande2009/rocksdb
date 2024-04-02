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

# output_dir=tmp/select_last_similar_for_different_workload/test_more_operations_90_10
# mkdir -p $output_dir

# for i in {1..10}
# do
#     echo $i
#     ./scripts/run_multiple_strategy.sh 12000000 1200000 0 mnt/rocksdb experiment$i 8 0 0
#     mv experiment$i $output_dir/
# done

# ./scripts/run_for_a_type.sh 8000000 0 0 tmp/test_skip_0_wa 800 1 mnt/rocksdb/ experiment 8 0 0
# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/test_skip_1_wa 800 1 mnt/rocksdb/ experiment 8 0 0
# ./scripts/run_for_a_type.sh 6400000 1600000 0 tmp/test_skip_2_wa 800 1 mnt/rocksdb/ experiment 8 0 0
# ./scripts/run_for_a_type.sh 5600000 2400000 0 tmp/test_skip_3_wa 800 1 mnt/rocksdb/ experiment 8 0 0
# ./scripts/run_for_a_type.sh 4800000 3200000 0 tmp/test_skip_4_wa 800 1 mnt/rocksdb/ experiment 8 0 0
# ./scripts/run_for_a_type.sh 4000000 4000000 0 tmp/test_skip_5_wa 800 1 mnt/rocksdb/ experiment 8 0 0

# ./scripts/run_for_a_type.sh 8000000 0 0 tmp/test_skip_0_wa 800 1 mnt/rocksdb/ experiment1 16 0 0
# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/test_skip_0_wa 800 1 mnt/rocksdb/ experiment2 16 0 0
# ./scripts/run_for_a_type.sh 6400000 1600000 0 tmp/test_skip_0_wa 800 1 mnt/rocksdb/ experiment3 16 0 0
# ./scripts/run_for_a_type.sh 5600000 2400000 0 tmp/test_skip_0_wa 800 1 mnt/rocksdb/ experiment4 16 0 0
# ./scripts/run_for_a_type.sh 4800000 3200000 0 tmp/test_skip_0_wa 800 1 mnt/rocksdb/ experiment5 16 0 0
# ./scripts/run_for_a_type.sh 4000000 4000000 0 tmp/test_skip_0_wa 800 1 mnt/rocksdb/ experiment6 16 0 0

# output_dir=tmp/select_last_similar_for_different_workload/test_baseline_100_0
# mkdir -p $output_dir

# for i in {1..10}
# do
#     echo $i
#     ./scripts/run_multiple_strategy.sh 8000000 0 0 mnt/rocksdb experiment$i 8 0 0
#     mv experiment$i $output_dir/
# done

# output_dir=tmp/select_last_similar_for_different_workload/level3
# mkdir -p $output_dir/1200000_256_10_90_0

# for j in {1..10}
# do
#     echo $j
#     experiment_name=experiment$j
#     ./scripts/run_multiple_strategy.sh 120000 1080000 0 mnt/rocksdb $experiment_name 256 0 0
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1200000_256_10_90_0/
# done

# ./scripts/run_for_a_type.sh 3000000 0 0 tmp/level4_opt_mac 800 1 mnt/rocksdb experiment 256 1 -L\ 0.015625
# ./scripts/run_for_a_type.sh 2700000 300000 0 tmp/level4_opt_mac 800 1 mnt/rocksdb experiment 256 1 -L\ 0.015625

# output_dir=tmp/test_10_mor
# mkdir -p $output_dir/1500000_512_90_10_0

# for j in {1..10}
# do
#     echo $j
#     experiment_name=experiment$j
#     ./scripts/run_multiple_strategy.sh 1350000 150000 0 mnt/rocksdb $experiment_name 512 1 -L\ 0.0078125
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_90_10_0
# done

# output_dir=tmp/select_last_similar_for_different_workload/level4_8_mac

# mkdir -p $output_dir/1500000_512_100_0_0
# mkdir -p $output_dir/1500000_512_90_10_0
# mkdir -p $output_dir/1500000_512_80_20_0
# mkdir -p $output_dir/1500000_512_70_30_0
# mkdir -p $output_dir/1500000_512_60_40_0
# mkdir -p $output_dir/1500000_512_50_50_0
# mkdir -p $output_dir/1500000_512_40_60_0
# mkdir -p $output_dir/1500000_512_30_70_0
# mkdir -p $output_dir/1500000_512_20_80_0
# mkdir -p $output_dir/1500000_512_10_90_0

# for k in {1..10}
# do
#     echo $k
#     experiment_name=experiment$k
#     ./scripts/run_multiple_strategy.sh 1500000 0 0 mnt/rocksdb $experiment_name 512 1 -L\ 0.0078125
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_100_0_0/
#     ./scripts/run_multiple_strategy.sh 1350000 150000 0 mnt/rocksdb $experiment_name 512 1 -L\ 0.0078125
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_90_10_0/
#     ./scripts/run_multiple_strategy.sh 1200000 300000 0 mnt/rocksdb $experiment_name 512 1 -L\ 0.0078125
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_80_20_0/
#     ./scripts/run_multiple_strategy.sh 1050000 450000 0 mnt/rocksdb $experiment_name 512 1 -L\ 0.0078125
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_70_30_0/
#     ./scripts/run_multiple_strategy.sh 900000 600000 0 mnt/rocksdb $experiment_name 512 1 -L\ 0.0078125
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_60_40_0/
#     ./scripts/run_multiple_strategy.sh 750000 750000 0 mnt/rocksdb $experiment_name 512 1 -L\ 0.0078125
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_50_50_0/
#     ./scripts/run_multiple_strategy.sh 600000 900000 0 mnt/rocksdb $experiment_name 512 1 -L\ 0.0078125
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_40_60_0/
#     ./scripts/run_multiple_strategy.sh 450000 1050000 0 mnt/rocksdb $experiment_name 512 1 -L\ 0.0078125
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_30_70_0/
#     ./scripts/run_multiple_strategy.sh 300000 1200000 0 mnt/rocksdb $experiment_name 512 1 -L\ 0.0078125
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_20_80_0/
#     ./scripts/run_multiple_strategy.sh 150000 1350000 0 mnt/rocksdb $experiment_name 512 1 -L\ 0.0078125
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_10_90_0/
# done

# output_dir=tmp/optimal_searching/8000000_16
# mkdir -p $output_dir

# ./scripts/run_for_a_type.sh 8000000 0 0 $output_dir 800 1 mnt/rocksdb experiment 16 0 0
# ./scripts/run_for_a_type.sh 7200000 800000 0 $output_dir 800 1 mnt/rocksdb experiment 16 0 0
# ./scripts/run_for_a_type.sh 6400000 1600000 0 $output_dir 800 1 mnt/rocksdb experiment 16 0 0
# ./scripts/run_for_a_type.sh 5600000 2400000 0 $output_dir 800 1 mnt/rocksdb experiment 16 0 0
# ./scripts/run_for_a_type.sh 4800000 3200000 0 $output_dir 800 1 mnt/rocksdb experiment 16 0 0

# ./load_gen --output_path workloads/1.txt -I 2000000 -U 0 -D 0 -E 64 -L 0.125
# ./scripts/run_for_a_type.sh 3000 mnt/rocksdb/ experiment1 workloads/1.txt 128000000

# ./load_gen --output_path workloads/1.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
# total_bytes=$((2000000 * 64))
# output_dir=tmp/test_workload_compaction_times/

# ./scripts/run_for_a_type.sh 3000 mnt/rocksdb/ experiment1 workloads/1.txt $total_bytes

# ./load_gen --output_path workloads/1.txt -I 1000000 -U 1000000 -D 0 -E 64 -K 8
# ./load_gen --output_path workloads/1.txt -I 1000000 -U 1000000 -D 0 -E 64 -K 8
# ./load_gen --output_path workloads/1.txt -I 2500000 -U 0 -D 0 -E 64 -K 8
# total_bytes=$((2500000 * 64))
# # time ./scripts/run_once_existing.sh mnt/rocksdb/ experiment1 kMinOverlappingRatio $total_bytes workloads/1.txt
# ./scripts/run_for_a_type.sh 1000 mnt/rocksdb/ experiment1 workloads/1.txt $total_bytes

# ./load_gen --output_path workloads/1.txt -I 1000000 -U 1000000 -D 0 -E 64 -K 8
total_bytes=$((2000000 * 64))
./scripts/run_for_a_type.sh 10 mnt/rocksdb/ experiment_non_skip workloads/1.txt $total_bytes 0
