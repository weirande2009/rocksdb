#!/bin/bash

# run multiple times
# ./scripts/run_for_a_type.sh 8000000 0 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 8000000 0 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 8000000 0 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 8000000 0 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 8000000 0 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8

# ./scripts/run_for_a_type.sh 7200000 0 800000 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 7200000 0 800000 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 7200000 0 800000 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8

# ./scripts/run_for_a_type.sh 6400000 0 1600000 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 6400000 0 1600000 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 6400000 0 1600000 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8

# ./scripts/run_for_a_type.sh 5600000 0 2400000 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 5600000 0 2400000 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 5600000 0 2400000 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8

# ./scripts/run_for_a_type.sh 4800000 0 3200000 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 4800000 0 3200000 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 4800000 0 3200000 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8

# ./scripts/run_for_a_type.sh 4000000 0 4000000 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 4000000 0 4000000 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 4000000 0 4000000 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 8

# run multiple times
# ./scripts/run_for_a_type.sh 8000000 0 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 16
# ./scripts/run_for_a_type.sh 8000000 0 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 16
# ./scripts/run_for_a_type.sh 8000000 0 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 16

# ./scripts/run_for_a_type.sh 7200000 800000 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 16
# ./scripts/run_for_a_type.sh 7200000 800000 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 16
# ./scripts/run_for_a_type.sh 7200000 800000 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 16

# ./scripts/run_for_a_type.sh 6400000 1600000 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 16
# ./scripts/run_for_a_type.sh 6400000 1600000 0 result_multiple_times_delete 800 1 mnt/roocksdb/ experiment 16
# ./scripts/run_for_a_type.sh 6400000 1600000 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 16

# ./scripts/run_for_a_type.sh 5600000 2400000 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 16
# ./scripts/run_for_a_type.sh 5600000 2400000 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 16
# ./scripts/run_for_a_type.sh 5600000 2400000 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 16

# ./scripts/run_for_a_type.sh 4800000 3200000 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 16
# ./scripts/run_for_a_type.sh 4800000 3200000 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 16
# ./scripts/run_for_a_type.sh 4800000 3200000 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 16

# ./scripts/run_for_a_type.sh 4000000 4000000 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 16
# ./scripts/run_for_a_type.sh 4000000 4000000 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 16
# ./scripts/run_for_a_type.sh 4000000 4000000 0 result_multiple_times_delete 800 1 mnt/rocksdb/ experiment 16

# output_dir=tmp/select_last_similar_for_different_workload/third
# mkdir -p $output_dir
# mkdir -p $output_dir/8000000_8_100_0_0
# mkdir -p $output_dir/8000000_8_90_10_0
# mkdir -p $output_dir/8000000_8_80_20_0
# mkdir -p $output_dir/8000000_8_70_30_0
# mkdir -p $output_dir/8000000_8_60_40_0
# mkdir -p $output_dir/8000000_8_50_50_0

# for i in {1..10}
# do
#     echo $i
#     experiment_name=experiment$i
#     ./scripts/run_multiple_strategy.sh 8000000 0 0 mnt/rocksdb $experiment_name 8 0 0
#     mv $experiment_name $output_dir/8000000_8_100_0_0/
#     ./scripts/run_multiple_strategy.sh 7200000 800000 0 mnt/rocksdb $experiment_name 8 0 0
#     mv $experiment_name $output_dir/8000000_8_90_10_0/
#     ./scripts/run_multiple_strategy.sh 6400000 1600000 0 mnt/rocksdb $experiment_name 8 0 0
#     mv $experiment_name $output_dir/8000000_8_80_20_0/
#     ./scripts/run_multiple_strategy.sh 5600000 2400000 0 mnt/rocksdb $experiment_name 8 0 0
#     mv $experiment_name $output_dir/8000000_8_70_30_0/
#     ./scripts/run_multiple_strategy.sh 4800000 3200000 0 mnt/rocksdb $experiment_name 8 0 0
#     mv $experiment_name $output_dir/8000000_8_60_40_0/
#     ./scripts/run_multiple_strategy.sh 4000000 4000000 0 mnt/rocksdb $experiment_name 8 0 0
#     mv $experiment_name $output_dir/8000000_8_50_50_0/
# done

# mkdir -p $output_dir/6000000_32_100_0_0
# mkdir -p $output_dir/6000000_32_90_10_0
# mkdir -p $output_dir/6000000_32_80_20_0
# mkdir -p $output_dir/6000000_32_70_30_0
# mkdir -p $output_dir/6000000_32_60_40_0
# mkdir -p $output_dir/6000000_32_50_50_0

# for j in {1..10}
# do
#     echo $j
#     experiment_name=experiment$j
#     ./scripts/run_multiple_strategy.sh 6000000 0 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/6000000_32_100_0_0/
#     ./scripts/run_multiple_strategy.sh 5400000 600000 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/6000000_32_90_10_0/
#     ./scripts/run_multiple_strategy.sh 4800000 1200000 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/6000000_32_80_20_0/
#     ./scripts/run_multiple_strategy.sh 4200000 1800000 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/6000000_32_70_30_0/
#     ./scripts/run_multiple_strategy.sh 3600000 2400000 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/6000000_32_60_40_0/
#     ./scripts/run_multiple_strategy.sh 3000000 3000000 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/6000000_32_50_50_0/
# done

# mkdir -p $output_dir/1000000_256_100_0_0
# mkdir -p $output_dir/1000000_256_90_10_0
# mkdir -p $output_dir/1000000_256_80_20_0
# mkdir -p $output_dir/1000000_256_70_30_0
# mkdir -p $output_dir/1000000_256_60_40_0
# mkdir -p $output_dir/1000000_256_50_50_0

# for k in {1..10}
# do
#     echo $k
#     experiment_name=experiment$k
#     ./scripts/run_multiple_strategy.sh 1000000 0 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1000000_256_100_0_0/
#     ./scripts/run_multiple_strategy.sh 900000 100000 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1000000_256_90_10_0/
#     ./scripts/run_multiple_strategy.sh 800000 200000 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1000000_256_80_20_0/
#     ./scripts/run_multiple_strategy.sh 700000 300000 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1000000_256_70_30_0/
#     ./scripts/run_multiple_strategy.sh 600000 400000 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1000000_256_60_40_0/
#     ./scripts/run_multiple_strategy.sh 500000 500000 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1000000_256_50_50_0/
# done

# output_dir=tmp/select_last_similar_for_different_workload/third
# mkdir -p $output_dir
# mkdir -p $output_dir/8000000_8_40_60_0
# mkdir -p $output_dir/8000000_8_30_70_0
# mkdir -p $output_dir/8000000_8_20_80_0
# mkdir -p $output_dir/8000000_8_10_90_0

# for i in {1..10}
# do
#     echo $i
#     experiment_name=experiment$i
#     ./scripts/run_multiple_strategy.sh 3200000 4800000 0 mnt/rocksdb $experiment_name 8 0 0
#     mv $experiment_name $output_dir/8000000_8_40_60_0/
#     ./scripts/run_multiple_strategy.sh 2400000 5600000 0 mnt/rocksdb $experiment_name 8 0 0
#     mv $experiment_name $output_dir/8000000_8_30_70_0/
#     ./scripts/run_multiple_strategy.sh 1600000 6400000 0 mnt/rocksdb $experiment_name 8 0 0
#     mv $experiment_name $output_dir/8000000_8_20_80_0/
#     ./scripts/run_multiple_strategy.sh 800000 7200000 0 mnt/rocksdb $experiment_name 8 0 0
#     mv $experiment_name $output_dir/8000000_8_10_90_0/
# done

# mkdir -p $output_dir/6000000_32_40_60_0
# mkdir -p $output_dir/6000000_32_30_70_0
# mkdir -p $output_dir/6000000_32_20_80_0
# mkdir -p $output_dir/6000000_32_10_90_0

# for j in {1..10}
# do
#     echo $j
#     experiment_name=experiment$j
#     ./scripts/run_multiple_strategy.sh 2400000 3600000 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/6000000_32_40_60_0/
#     ./scripts/run_multiple_strategy.sh 1800000 4200000 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/6000000_32_30_70_0/
#     ./scripts/run_multiple_strategy.sh 1200000 4800000 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/6000000_32_20_80_0/
#     ./scripts/run_multiple_strategy.sh 600000 5400000 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/6000000_32_10_90_0/
# done

# mkdir -p $output_dir/1000000_256_40_60_0
# mkdir -p $output_dir/1000000_256_30_70_0
# mkdir -p $output_dir/1000000_256_20_80_0
# mkdir -p $output_dir/1000000_256_10_90_0

# for k in {1..10}
# do
#     echo $k
#     experiment_name=experiment$k
#     ./scripts/run_multiple_strategy.sh 400000 600000 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1000000_256_40_60_0/
#     ./scripts/run_multiple_strategy.sh 300000 700000 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1000000_256_30_70_0/
#     ./scripts/run_multiple_strategy.sh 200000 800000 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1000000_256_20_80_0/
#     ./scripts/run_multiple_strategy.sh 100000 900000 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1000000_256_10_90_0/
# done

# # larger workload down to level 3
# output_dir=tmp/select_last_similar_for_different_workload/level3
# mkdir -p $output_dir/8000000_32_100_0_0
# mkdir -p $output_dir/8000000_32_90_10_0
# mkdir -p $output_dir/8000000_32_80_20_0
# mkdir -p $output_dir/8000000_32_70_30_0
# mkdir -p $output_dir/8000000_32_60_40_0
# mkdir -p $output_dir/8000000_32_50_50_0
# mkdir -p $output_dir/8000000_32_40_60_0
# mkdir -p $output_dir/8000000_32_30_70_0
# mkdir -p $output_dir/8000000_32_20_80_0
# mkdir -p $output_dir/8000000_32_10_90_0

# for i in {1..10}
# do
#     echo $i
#     experiment_name=experiment$i
#     ./scripts/run_multiple_strategy.sh 8000000 0 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/8000000_32_100_0_0/
#     ./scripts/run_multiple_strategy.sh 7200000 800000 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/8000000_32_90_10_0/
#     ./scripts/run_multiple_strategy.sh 6400000 1600000 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/8000000_32_80_20_0/
#     ./scripts/run_multiple_strategy.sh 5600000 2400000 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/8000000_32_70_30_0/
#     ./scripts/run_multiple_strategy.sh 4800000 3200000 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/8000000_32_60_40_0/
#     ./scripts/run_multiple_strategy.sh 4000000 4000000 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/8000000_32_50_50_0/
#     ./scripts/run_multiple_strategy.sh 3200000 4800000 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/8000000_32_40_60_0/
#     ./scripts/run_multiple_strategy.sh 2400000 5600000 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/8000000_32_30_70_0/
#     ./scripts/run_multiple_strategy.sh 1600000 6400000 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/8000000_32_20_80_0/
#     ./scripts/run_multiple_strategy.sh 800000 7200000 0 mnt/rocksdb $experiment_name 32 0 0
#     mv $experiment_name $output_dir/8000000_32_10_90_0/
# done

# mkdir -p $output_dir/1200000_256_100_0_0
# mkdir -p $output_dir/1200000_256_90_10_0
# mkdir -p $output_dir/1200000_256_80_20_0
# mkdir -p $output_dir/1200000_256_70_30_0
# mkdir -p $output_dir/1200000_256_60_40_0
# mkdir -p $output_dir/1200000_256_50_50_0
# mkdir -p $output_dir/1200000_256_40_60_0
# mkdir -p $output_dir/1200000_256_30_70_0
# mkdir -p $output_dir/1200000_256_20_80_0
# mkdir -p $output_dir/1200000_256_10_90_0

# for j in {1..10}
# do
#     echo $j
#     experiment_name=experiment$j
#     ./scripts/run_multiple_strategy.sh 1200000 0 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1200000_256_100_0_0/
#     ./scripts/run_multiple_strategy.sh 1080000 120000 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1200000_256_90_10_0/
#     ./scripts/run_multiple_strategy.sh 960000 240000 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1200000_256_80_20_0/
#     ./scripts/run_multiple_strategy.sh 840000 360000 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1200000_256_70_30_0/
#     ./scripts/run_multiple_strategy.sh 720000 480000 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1200000_256_60_40_0/
#     ./scripts/run_multiple_strategy.sh 600000 600000 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1200000_256_50_50_0/
#     ./scripts/run_multiple_strategy.sh 480000 720000 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1200000_256_40_60_0/
#     ./scripts/run_multiple_strategy.sh 360000 840000 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1200000_256_30_70_0/
#     ./scripts/run_multiple_strategy.sh 240000 960000 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1200000_256_20_80_0/
#     ./scripts/run_multiple_strategy.sh 120000 1080000 0 mnt/rocksdb $experiment_name 256 0 0
#     mv $experiment_name $output_dir/1200000_256_10_90_0/
# done

# different update distribution

# normal default
# output_dir=tmp/select_last_similar_for_different_workload/dif_distribution
# mkdir -p $output_dir

# mkdir -p $output_dir/8000000_8_100_0_0_normal_default
# mkdir -p $output_dir/8000000_8_90_10_0_normal_default
# mkdir -p $output_dir/8000000_8_80_20_0_normal_default
# mkdir -p $output_dir/8000000_8_70_30_0_normal_default
# mkdir -p $output_dir/8000000_8_60_40_0_normal_default
# mkdir -p $output_dir/8000000_8_50_50_0_normal_default
# mkdir -p $output_dir/8000000_8_40_60_0_normal_default
# mkdir -p $output_dir/8000000_8_30_70_0_normal_default
# mkdir -p $output_dir/8000000_8_20_80_0_normal_default
# mkdir -p $output_dir/8000000_8_10_90_0_normal_default

# for i in {1..10}
# do
#     echo $i
#     experiment_name=experiment$i
#     ./scripts/run_multiple_strategy.sh 8000000 0 0 mnt/rocksdb $experiment_name 8 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_8_100_0_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 7200000 800000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_8_90_10_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 6400000 1600000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_8_80_20_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 5600000 2400000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_8_70_30_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 4800000 3200000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_8_60_40_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 4000000 4000000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_8_50_50_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 3200000 4800000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_8_40_60_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 2400000 5600000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_8_30_70_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 1600000 6400000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_8_20_80_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 800000 7200000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_8_10_90_0_normal_default/
# done

# mkdir -p $output_dir/8000000_32_100_0_0_normal_default
# mkdir -p $output_dir/8000000_32_90_10_0_normal_default
# mkdir -p $output_dir/8000000_32_80_20_0_normal_default
# mkdir -p $output_dir/8000000_32_70_30_0_normal_default
# mkdir -p $output_dir/8000000_32_60_40_0_normal_default
# mkdir -p $output_dir/8000000_32_50_50_0_normal_default
# mkdir -p $output_dir/8000000_32_40_60_0_normal_default
# mkdir -p $output_dir/8000000_32_30_70_0_normal_default
# mkdir -p $output_dir/8000000_32_20_80_0_normal_default
# mkdir -p $output_dir/8000000_32_10_90_0_normal_default

# for j in {1..10}
# do
#     echo $j
#     experiment_name=experiment$j
#     ./scripts/run_multiple_strategy.sh 8000000 0 0 mnt/rocksdb $experiment_name 32 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_32_100_0_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 7200000 800000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_32_90_10_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 6400000 1600000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_32_80_20_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 5600000 2400000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_32_70_30_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 4800000 3200000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_32_60_40_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 4000000 4000000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_32_50_50_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 3200000 4800000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_32_40_60_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 2400000 5600000 0 mnt/roocksdb $experiment_name 32 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_32_30_70_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 1600000 6400000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_32_20_80_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 800000 7200000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 1
#     mv $experiment_name $output_dir/8000000_32_10_90_0_normal_default/
# done

# mkdir -p $output_dir/1200000_256_100_0_0_normal_default
# mkdir -p $output_dir/1200000_256_90_10_0_normal_default
# mkdir -p $output_dir/1200000_256_80_20_0_normal_default
# mkdir -p $output_dir/1200000_256_70_30_0_normal_default
# mkdir -p $output_dir/1200000_256_60_40_0_normal_default
# mkdir -p $output_dir/1200000_256_50_50_0_normal_default
# mkdir -p $output_dir/1200000_256_40_60_0_normal_default
# mkdir -p $output_dir/1200000_256_30_70_0_normal_default
# mkdir -p $output_dir/1200000_256_20_80_0_normal_default
# mkdir -p $output_dir/1200000_256_10_90_0_normal_default

# for k in {1..10}
# do
#     echo $k
#     experiment_name=experiment$k
#     ./scripts/run_multiple_strategy.sh 1200000 0 0 mnt/rocksdb $experiment_name 256 1 --UD\ 1
#     mv $experiment_name $output_dir/1200000_256_100_0_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 1080000 120000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 1
#     mv $experiment_name $output_dir/1200000_256_90_10_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 960000 240000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 1
#     mv $experiment_name $output_dir/1200000_256_80_20_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 840000 360000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 1
#     mv $experiment_name $output_dir/1200000_256_70_30_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 720000 480000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 1
#     mv $experiment_name $output_dir/1200000_256_60_40_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 600000 600000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 1
#     mv $experiment_name $output_dir/1200000_256_50_50_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 480000 720000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 1
#     mv $experiment_name $output_dir/1200000_256_40_60_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 360000 840000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 1
#     mv $experiment_name $output_dir/1200000_256_30_70_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 240000 960000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 1
#     mv $experiment_name $output_dir/1200000_256_20_80_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 120000 1080000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 1
#     mv $experiment_name $output_dir/1200000_256_10_90_0_normal_default/
# done

# # beta default

# mkdir -p $output_dir/8000000_8_100_0_0_beta_default
# mkdir -p $output_dir/8000000_8_90_10_0_beta_default
# mkdir -p $output_dir/8000000_8_80_20_0_beta_default
# mkdir -p $output_dir/8000000_8_70_30_0_beta_default
# mkdir -p $output_dir/8000000_8_60_40_0_beta_default
# mkdir -p $output_dir/8000000_8_50_50_0_beta_default
# mkdir -p $output_dir/8000000_8_40_60_0_beta_default
# mkdir -p $output_dir/8000000_8_30_70_0_beta_default
# mkdir -p $output_dir/8000000_8_20_80_0_beta_default
# mkdir -p $output_dir/8000000_8_10_90_0_beta_default

# for i in {1..10}
# do
#     echo $i
#     experiment_name=experiment$i
#     ./scripts/run_multiple_strategy.sh 8000000 0 0 mnt/rocksdb $experiment_name 8 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_8_100_0_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 7200000 800000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_8_90_10_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 6400000 1600000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_8_80_20_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 5600000 2400000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_8_70_30_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 4800000 3200000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_8_60_40_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 4000000 4000000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_8_50_50_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 3200000 4800000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_8_40_60_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 2400000 5600000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_8_30_70_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 1600000 6400000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_8_20_80_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 800000 7200000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_8_10_90_0_beta_default/
# done

# mkdir -p $output_dir/8000000_32_100_0_0_beta_default
# mkdir -p $output_dir/8000000_32_90_10_0_beta_default
# mkdir -p $output_dir/8000000_32_80_20_0_beta_default
# mkdir -p $output_dir/8000000_32_70_30_0_beta_default
# mkdir -p $output_dir/8000000_32_60_40_0_beta_default
# mkdir -p $output_dir/8000000_32_50_50_0_beta_default
# mkdir -p $output_dir/8000000_32_40_60_0_beta_default
# mkdir -p $output_dir/8000000_32_30_70_0_beta_default
# mkdir -p $output_dir/8000000_32_20_80_0_beta_default
# mkdir -p $output_dir/8000000_32_10_90_0_beta_default

# for j in {1..10}
# do
#     echo $j
#     experiment_name=experiment$j
#     ./scripts/run_multiple_strategy.sh 8000000 0 0 mnt/rocksdb $experiment_name 32 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_32_100_0_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 7200000 800000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_32_90_10_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 6400000 1600000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_32_80_20_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 5600000 2400000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_32_70_30_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 4800000 3200000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_32_60_40_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 4000000 4000000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_32_50_50_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 3200000 4800000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_32_40_60_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 2400000 5600000 0 mnt/roocksdb $experiment_name 32 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_32_30_70_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 1600000 6400000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_32_20_80_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 800000 7200000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 2
#     mv $experiment_name $output_dir/8000000_32_10_90_0_beta_default/
# done

# mkdir -p $output_dir/1200000_256_100_0_0_beta_default
# mkdir -p $output_dir/1200000_256_90_10_0_beta_default
# mkdir -p $output_dir/1200000_256_80_20_0_beta_default
# mkdir -p $output_dir/1200000_256_70_30_0_beta_default
# mkdir -p $output_dir/1200000_256_60_40_0_beta_default
# mkdir -p $output_dir/1200000_256_50_50_0_beta_default
# mkdir -p $output_dir/1200000_256_40_60_0_beta_default
# mkdir -p $output_dir/1200000_256_30_70_0_beta_default
# mkdir -p $output_dir/1200000_256_20_80_0_beta_default
# mkdir -p $output_dir/1200000_256_10_90_0_beta_default

# for k in {1..10}
# do
#     echo $k
#     experiment_name=experiment$k
#     ./scripts/run_multiple_strategy.sh 1200000 0 0 mnt/rocksdb $experiment_name 256 1 --UD\ 2
#     mv $experiment_name $output_dir/1200000_256_100_0_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 1080000 120000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 2
#     mv $experiment_name $output_dir/1200000_256_90_10_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 960000 240000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 2
#     mv $experiment_name $output_dir/1200000_256_80_20_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 840000 360000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 2
#     mv $experiment_name $output_dir/1200000_256_70_30_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 720000 480000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 2
#     mv $experiment_name $output_dir/1200000_256_60_40_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 600000 600000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 2
#     mv $experiment_name $output_dir/1200000_256_50_50_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 480000 720000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 2
#     mv $experiment_name $output_dir/1200000_256_40_60_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 360000 840000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 2
#     mv $experiment_name $output_dir/1200000_256_30_70_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 240000 960000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 2
#     mv $experiment_name $output_dir/1200000_256_20_80_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 120000 1080000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 2
#     mv $experiment_name $output_dir/1200000_256_10_90_0_beta_default/
# done

# zipf default
# output_dir=tmp/select_last_similar_for_different_workload/dif_distribution

# mkdir -p $output_dir/8000000_8_100_0_0_zipf_default
# mkdir -p $output_dir/8000000_8_90_10_0_zipf_default
# mkdir -p $output_dir/8000000_8_80_20_0_zipf_default
# mkdir -p $output_dir/8000000_8_70_30_0_zipf_default
# mkdir -p $output_dir/8000000_8_60_40_0_zipf_default
# mkdir -p $output_dir/8000000_8_50_50_0_zipf_default
# mkdir -p $output_dir/8000000_8_40_60_0_zipf_default
# mkdir -p $output_dir/8000000_8_30_70_0_zipf_default
# mkdir -p $output_dir/8000000_8_20_80_0_zipf_default
# mkdir -p $output_dir/8000000_8_10_90_0_zipf_default

# for i in {1..10}
# do
#     echo $i
#     experiment_name=experiment$i
#     ./scripts/run_multiple_strategy.sh 8000000 0 0 mnt/rocksdb $experiment_name 8 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_8_100_0_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 7200000 800000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_8_90_10_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 6400000 1600000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_8_80_20_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 5600000 2400000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_8_70_30_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 4800000 3200000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_8_60_40_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 4000000 4000000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_8_50_50_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 3200000 4800000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_8_40_60_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 2400000 5600000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_8_30_70_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 1600000 6400000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_8_20_80_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 800000 7200000 0 mnt/rocksdb $experiment_name 8 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_8_10_90_0_zipf_default/
# done

# mkdir -p $output_dir/8000000_32_100_0_0_zipf_default
# mkdir -p $output_dir/8000000_32_90_10_0_zipf_default
# mkdir -p $output_dir/8000000_32_80_20_0_zipf_default
# mkdir -p $output_dir/8000000_32_70_30_0_zipf_default
# mkdir -p $output_dir/8000000_32_60_40_0_zipf_default
# mkdir -p $output_dir/8000000_32_50_50_0_zipf_default
# mkdir -p $output_dir/8000000_32_40_60_0_zipf_default
# mkdir -p $output_dir/8000000_32_30_70_0_zipf_default
# mkdir -p $output_dir/8000000_32_20_80_0_zipf_default
# mkdir -p $output_dir/8000000_32_10_90_0_zipf_default

# for j in {1..10}
# do
#     echo $j
#     experiment_name=experiment$j
#     ./scripts/run_multiple_strategy.sh 8000000 0 0 mnt/rocksdb $experiment_name 32 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_32_100_0_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 7200000 800000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_32_90_10_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 6400000 1600000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_32_80_20_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 5600000 2400000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_32_70_30_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 4800000 3200000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_32_60_40_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 4000000 4000000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_32_50_50_0_zipf_default/
#     rm -rf $experiment_name/workload.txt
#     ./scripts/run_multiple_strategy.sh 3200000 4800000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_32_40_60_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 2400000 5600000 0 mnt/roocksdb $experiment_name 32 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_32_30_70_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 1600000 6400000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_32_20_80_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 800000 7200000 0 mnt/rocksdb $experiment_name 32 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/8000000_32_10_90_0_zipf_default/
# done

# mkdir -p $output_dir/1200000_256_100_0_0_zipf_default
# mkdir -p $output_dir/1200000_256_90_10_0_zipf_default
# mkdir -p $output_dir/1200000_256_80_20_0_zipf_default
# mkdir -p $output_dir/1200000_256_70_30_0_zipf_default
# mkdir -p $output_dir/1200000_256_60_40_0_zipf_default
# mkdir -p $output_dir/1200000_256_50_50_0_zipf_default
# mkdir -p $output_dir/1200000_256_40_60_0_zipf_default
# mkdir -p $output_dir/1200000_256_30_70_0_zipf_default
# mkdir -p $output_dir/1200000_256_20_80_0_zipf_default
# mkdir -p $output_dir/1200000_256_10_90_0_zipf_default

# for k in {1..10}
# do
#     echo $k
#     experiment_name=experiment$k
#     ./scripts/run_multiple_strategy.sh 1200000 0 0 mnt/rocksdb $experiment_name 256 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1200000_256_100_0_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 1080000 120000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1200000_256_90_10_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 960000 240000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1200000_256_80_20_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 840000 360000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1200000_256_70_30_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 720000 480000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1200000_256_60_40_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 600000 600000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1200000_256_50_50_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 480000 720000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1200000_256_40_60_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 360000 840000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1200000_256_30_70_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 240000 960000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1200000_256_20_80_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 120000 1080000 0 mnt/rocksdb $experiment_name 256 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1200000_256_10_90_0_zipf_default/
# done

# level4
# output_dir=tmp/select_last_similar_for_different_workload/level4

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
#     ./scripts/run_multiple_strategy.sh 1500000 0 0 mnt/rocksdb $experiment_name 512 0 0
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_100_0_0/
#     ./scripts/run_multiple_strategy.sh 1350000 150000 0 mnt/rocksdb $experiment_name 512 0 0
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_90_10_0/
#     ./scripts/run_multiple_strategy.sh 1200000 300000 0 mnt/rocksdb $experiment_name 512 0 0
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_80_20_0/
#     ./scripts/run_multiple_strategy.sh 1050000 450000 0 mnt/rocksdb $experiment_name 512 0 0
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_70_30_0/
#     ./scripts/run_multiple_strategy.sh 900000 600000 0 mnt/rocksdb $experiment_name 512 0 0
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_60_40_0/
#     ./scripts/run_multiple_strategy.sh 750000 750000 0 mnt/rocksdb $experiment_name 512 0 0
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_50_50_0/
#     ./scripts/run_multiple_strategy.sh 600000 900000 0 mnt/rocksdb $experiment_name 512 0 0
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_40_60_0/
#     ./scripts/run_multiple_strategy.sh 450000 1050000 0 mnt/rocksdb $experiment_name 512 0 0
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_30_70_0/
#     ./scripts/run_multiple_strategy.sh 300000 1200000 0 mnt/rocksdb $experiment_name 512 0 0
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_20_80_0/
#     ./scripts/run_multiple_strategy.sh 150000 1350000 0 mnt/rocksdb $experiment_name 512 0 0
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_10_90_0/
# done

# output_dir=tmp/select_last_similar_for_different_workload/dif_distribution

# mkdir -p $output_dir/1500000_512_100_0_0_normal_default
# mkdir -p $output_dir/1500000_512_90_10_0_normal_default
# mkdir -p $output_dir/1500000_512_80_20_0_normal_default
# mkdir -p $output_dir/1500000_512_70_30_0_normal_default
# mkdir -p $output_dir/1500000_512_60_40_0_normal_default
# mkdir -p $output_dir/1500000_512_50_50_0_normal_default
# mkdir -p $output_dir/1500000_512_40_60_0_normal_default
# mkdir -p $output_dir/1500000_512_30_70_0_normal_default
# mkdir -p $output_dir/1500000_512_20_80_0_normal_default
# mkdir -p $output_dir/1500000_512_10_90_0_normal_default

# for k in {1..10}
# do
#     echo $k
#     experiment_name=experiment$k
#     ./scripts/run_multiple_strategy.sh 1500000 0 0 mnt/rocksdb $experiment_name 512 1 --UD\ 1
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_100_0_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 1350000 150000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 1
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_90_10_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 1200000 300000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 1
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_80_20_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 1050000 450000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 1
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_70_30_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 900000 600000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 1
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_60_40_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 750000 750000 0 mnt/roocksdb $experiment_name 512 1 --UD\ 1
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_50_50_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 600000 900000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 1
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_40_60_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 450000 1050000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 1
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_30_70_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 300000 1200000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 1
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_20_80_0_normal_default/
#     ./scripts/run_multiple_strategy.sh 150000 1350000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 1
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_10_90_0_normal_default/
# done

# mkdir -p $output_dir/1500000_512_100_0_0_beta_default
# mkdir -p $output_dir/1500000_512_90_10_0_beta_default
# mkdir -p $output_dir/1500000_512_80_20_0_beta_default
# mkdir -p $output_dir/1500000_512_70_30_0_beta_default
# mkdir -p $output_dir/1500000_512_60_40_0_beta_default
# mkdir -p $output_dir/1500000_512_50_50_0_beta_default
# mkdir -p $output_dir/1500000_512_40_60_0_beta_default
# mkdir -p $output_dir/1500000_512_30_70_0_beta_default
# mkdir -p $output_dir/1500000_512_20_80_0_beta_default
# mkdir -p $output_dir/1500000_512_10_90_0_beta_default

# for k in {1..10}
# do
#     echo $k
#     experiment_name=experiment$k
#     ./scripts/run_multiple_strategy.sh 1500000 0 0 mnt/rocksdb $experiment_name 512 1 --UD\ 2
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_100_0_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 1350000 150000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 2
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_90_10_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 1200000 300000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 2
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_80_20_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 1050000 450000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 2
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_70_30_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 900000 600000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 2
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_60_40_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 750000 750000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 2
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_50_50_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 600000 900000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 2
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_40_60_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 450000 1050000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 2
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_30_70_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 300000 1200000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 2
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_20_80_0_beta_default/
#     ./scripts/run_multiple_strategy.sh 150000 1350000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 2
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_10_90_0_beta_default/
# done

# mkdir -p $output_dir/1500000_512_100_0_0_zipf_default
# mkdir -p $output_dir/1500000_512_90_10_0_zipf_default
# mkdir -p $output_dir/1500000_512_80_20_0_zipf_default
# mkdir -p $output_dir/1500000_512_70_30_0_zipf_default
# mkdir -p $output_dir/1500000_512_60_40_0_zipf_default
# mkdir -p $output_dir/1500000_512_50_50_0_zipf_default
# mkdir -p $output_dir/1500000_512_40_60_0_zipf_default
# mkdir -p $output_dir/1500000_512_30_70_0_zipf_default
# mkdir -p $output_dir/1500000_512_20_80_0_zipf_default
# mkdir -p $output_dir/1500000_512_10_90_0_zipf_default

# for k in {1..10}
# do
#     echo $k
#     experiment_name=experiment$k
#     ./scripts/run_multiple_strategy.sh 1500000 0 0 mnt/rocksdb $experiment_name 512 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_100_0_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 1350000 150000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_90_10_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 1200000 300000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_80_20_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 1050000 450000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_70_30_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 900000 600000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_60_40_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 750000 750000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_50_50_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 600000 900000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_40_60_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 450000 1050000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_30_70_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 300000 1200000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_20_80_0_zipf_default/
#     ./scripts/run_multiple_strategy.sh 150000 1350000 0 mnt/rocksdb $experiment_name 512 1 --UD\ 3
#     rm -rf $experiment_name/workload.txt
#     mv $experiment_name $output_dir/1500000_512_10_90_0_zipf_default/
# done

output_dir=tmp/select_last_similar_for_different_workload/level3
mkdir -p $output_dir/1200000_256_10_90_0

for j in {1..10}
do
    echo $j
    experiment_name=experiment$j
    ./scripts/run_multiple_strategy.sh 120000 1080000 0 mnt/rocksdb $experiment_name 256 0 0
    rm -rf $experiment_name/workload.txt
    mv $experiment_name $output_dir/1200000_256_10_90_0/
done
