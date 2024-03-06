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

output_dir=tmp/select_last_similar_for_different_workload/second
mkdir -p $output_dir
mkdir -p $output_dir/8000000_8_100_0_0
mkdir -p $output_dir/8000000_8_90_10_0
mkdir -p $output_dir/8000000_8_80_20_0
mkdir -p $output_dir/8000000_8_70_30_0
mkdir -p $output_dir/8000000_8_60_40_0
mkdir -p $output_dir/8000000_8_50_50_0
for i in {1..10}
do
    echo $i
    ./scripts/run_multiple_strategy.sh 8000000 0 0 mnt/rocksdb experiment$i 8 0 0
    mv experiment $output_dir/8000000_8_100_0_0/
    ./scripts/run_multiple_strategy.sh 7200000 800000 0 mnt/rocksdb experiment$i 8 0 0
    mv experiment $output_dir/8000000_8_90_10_0/
    ./scripts/run_multiple_strategy.sh 6400000 1600000 0 mnt/rocksdb experiment$i 8 0 0
    mv experiment $output_dir/8000000_8_80_20_0/
    ./scripts/run_multiple_strategy.sh 5600000 2400000 0 mnt/rocksdb experiment$i 8 0 0
    mv experiment $output_dir/8000000_8_70_30_0/
    ./scripts/run_multiple_strategy.sh 4800000 3200000 0 mnt/rocksdb experiment$i 8 0 0
    mv experiment $output_dir/8000000_8_60_40_0/
    ./scripts/run_multiple_strategy.sh 4000000 4000000 0 mnt/rocksdb experiment$i 8 0 0
    mv experiment $output_dir/8000000_8_50_50_0/
done

mkdir -p $output_dir/6000000_32_100_0_0
mkdir -p $output_dir/6000000_32_90_10_0
mkdir -p $output_dir/6000000_32_80_20_0
mkdir -p $output_dir/6000000_32_70_30_0
mkdir -p $output_dir/6000000_32_60_40_0
mkdir -p $output_dir/6000000_32_50_50_0
for j in {1..10}
do
    echo $j
    ./scripts/run_multiple_strategy.sh 6000000 0 0 mnt/rocksdb experiment$j 32 0 0
    mv experiment $output_dir/6000000_32_100_0_0/
    ./scripts/run_multiple_strategy.sh 5400000 600000 0 mnt/rocksdb experiment$j 32 0 0
    mv experiment $output_dir/6000000_32_90_10_0/
    ./scripts/run_multiple_strategy.sh 4800000 1200000 0 mnt/rocksdb experiment$j 32 0 0
    mv experiment $output_dir/6000000_32_80_20_0/
    ./scripts/run_multiple_strategy.sh 4200000 1800000 0 mnt/rocksdb experiment$j 32 0 0
    mv experiment $output_dir/6000000_32_70_30_0/
    ./scripts/run_multiple_strategy.sh 3600000 2400000 0 mnt/rocksdb experiment$j 32 0 0
    mv experiment $output_dir/6000000_32_60_40_0/
    ./scripts/run_multiple_strategy.sh 3000000 3000000 0 mnt/rocksdb experiment$j 32 0 0
    mv experiment $output_dir/6000000_32_50_50_0/
done

mkdir -p $output_dir/1000000_256_100_0_0
mkdir -p $output_dir/1000000_256_90_10_0
mkdir -p $output_dir/1000000_256_80_20_0
mkdir -p $output_dir/1000000_256_70_30_0
mkdir -p $output_dir/1000000_256_60_40_0
mkdir -p $output_dir/1000000_256_50_50_0
for k in {1..10}
do
    echo $k
    ./scripts/run_multiple_strategy.sh 1000000 0 0 mnt/rocksdb experimentk 256 0 0
    mv experiment $output_dir/1000000_256_100_0_0/
    ./scripts/run_multiple_strategy.sh 900000 100000 0 mnt/rocksdb experimentk 256 0 0
    mv experiment $output_dir/1000000_256_90_10_0/
    ./scripts/run_multiple_strategy.sh 800000 200000 0 mnt/rocksdb experimentk 256 0 0
    mv experiment $output_dir/1000000_256_80_20_0/
    ./scripts/run_multiple_strategy.sh 700000 300000 0 mnt/rocksdb experimentk 256 0 0
    mv experiment $output_dir/1000000_256_70_30_0/
    ./scripts/run_multiple_strategy.sh 600000 400000 0 mnt/rocksdb experimentk 256 0 0
    mv experiment $output_dir/1000000_256_60_40_0/
    ./scripts/run_multiple_strategy.sh 500000 500000 0 mnt/rocksdb experimentk 256 0 0
    mv experiment $output_dir/1000000_256_50_50_0/
done
