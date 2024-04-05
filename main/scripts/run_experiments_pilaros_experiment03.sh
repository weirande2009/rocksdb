# Experiment on the optimal policy with skip, non-skip, optimal to select a proper policy
# workloads settings: 8 bytes key size, 64 bytes entry size, 4000000 operations with 50%insert and 50%update
# For each type of workload, we run 10 times.

# We compare the time cost and the performance of three policies
# There will be one plot, each plot contains 3 lines, each line represents a policy
# Each line contains the min, max, mean, and median, 25% and 75% quantile of the 10 runs

# Expected result:
# 1. select a proper policy between skip and non-skip

workload_dir=workloads/compare_optimal_policies/2000000_2000000_0_64_8_memory/first_run
workspace_dir_non_skip=workspace/compare_optimal_policies/2000000_2000000_0_64_8_memory/first_run/non_skip
workspace_dir_skip=workspace/compare_optimal_policies/2000000_2000000_0_64_8_memory/first_run/skip
workspace_dir_optimal=workspace/compare_optimal_policies/2000000_2000000_0_64_8_memory/first_run/optimal
total_bytes=$((4000000 * 64))

enumeration_runs=15000
rocksdb_dir=/mnt/ramd/ranw/optimal
mkdir -p $rocksdb_dir

write_buffer_size=$((8 * 1024 * 1024))
target_file_size_base=$((8 * 1024 * 1024))
target_file_number=4

./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb1/ $workspace_dir_optimal/run1 $workload_dir/1.txt $total_bytes 0 1 $write_buffer_size $target_file_size_base $target_file_number &
./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb2/ $workspace_dir_optimal/run2 $workload_dir/2.txt $total_bytes 0 1 $write_buffer_size $target_file_size_base $target_file_number
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb3/ $workspace_dir_optimal/run3 $workload_dir/3.txt $total_bytes 0 1 $write_buffer_size $target_file_size_base $target_file_number &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb4/ $workspace_dir_optimal/run4 $workload_dir/4.txt $total_bytes 0 1 $write_buffer_size $target_file_size_base $target_file_number
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb5/ $workspace_dir_optimal/run5 $workload_dir/5.txt $total_bytes 0 1 $write_buffer_size $target_file_size_base $target_file_number &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb6/ $workspace_dir_optimal/run6 $workload_dir/6.txt $total_bytes 0 1 $write_buffer_size $target_file_size_base $target_file_number
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb7/ $workspace_dir_optimal/run7 $workload_dir/7.txt $total_bytes 0 1 $write_buffer_size $target_file_size_base $target_file_number &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb8/ $workspace_dir_optimal/run8 $workload_dir/8.txt $total_bytes 0 1 $write_buffer_size $target_file_size_base $target_file_number
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb9/ $workspace_dir_optimal/run9 $workload_dir/9.txt $total_bytes 0 1 $write_buffer_size $target_file_size_base $target_file_number &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb10/ $workspace_dir_optimal/run10 $workload_dir/10.txt $total_bytes 0 1 $write_buffer_size $target_file_size_base $target_file_number
