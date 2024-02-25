# multiple times for a type
# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/multi_times_7200k_800k_0 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/multi_times_7200k_800k_0 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/multi_times_7200k_800k_0 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/multi_times_7200k_800k_0 800 1 mnt/rocksdb/ experiment 8
# ./scripts/run_for_a_type.sh 7200000 800000 0 tmp/multi_times_7200k_800k_0 800 1 mnt/rocksdb/ experiment 8

# run different update distribution
./scripts/run_for_a_type.sh 7200000 800000 0 tmp/update_normal_50_1 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 1
./scripts/run_for_a_type.sh 6400000 1600000 0 tmp/update_normal_50_1 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 1
./scripts/run_for_a_type.sh 5600000 2400000 0 tmp/update_normal_50_1 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 1
./scripts/run_for_a_type.sh 4800000 3200000 0 tmp/update_normal_50_1 800 1 mnt/roocksdb/ experiment 8 1 --UD\ 1
./scripts/run_for_a_type.sh 4000000 4000000 0 tmp/update_normal_50_1 800 1 mnt/rocksdb/ experiment 8 1 --UD\ 1
