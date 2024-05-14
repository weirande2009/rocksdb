# Experiment on the optimal policy with skip, non-skip, optimal to select a proper policy
# workloads settings: 8 bytes key size, 64 bytes entry size, 4000000 operations with 50%insert and 50%update
# For each type of workload, we run 10 times.

# We compare the time cost and the performance of three policies
# There will be one plot, each plot contains 3 lines, each line represents a policy
# Each line contains the min, max, mean, and median, 25% and 75% quantile of the 10 runs

# Expected result:
# 1. select a proper policy between skip and non-skip

entry_size=64
num_operation=2500000
workload_size=$((num_operation * entry_size))
percentage_insert=50
percentage_update=50
num_insert=$((num_operation * percentage_insert / 100))
num_update=$((num_operation * percentage_update / 100))
total_bytes=$((num_operation * entry_size))
write_buffer_size=$((8 * 1024 * 1024))
target_file_size_base=$((8 * 1024 * 1024))
target_file_number=4

dir_name=${num_insert}_${num_update}_0_${entry_size}_8_memory/first_run
workload_dir=workloads/compare_optimal_policies/$dir_name
workspace_dir=workspace/compare_optimal_policies/$dir_name/non_skip

enumeration_runs=15000
rocksdb_dir=/mnt/ramd/ranw/non_skip
mkdir -p $rocksdb_dir

./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb1/ $workspace_dir/run1 $workload_dir/1.txt $total_bytes 0 0 $write_buffer_size $target_file_size_base $target_file_number &
./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb2/ $workspace_dir/run2 $workload_dir/2.txt $total_bytes 0 0 $write_buffer_size $target_file_size_base $target_file_number
./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb3/ $workspace_dir/run3 $workload_dir/3.txt $total_bytes 0 0 $write_buffer_size $target_file_size_base $target_file_number &
./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb4/ $workspace_dir/run4 $workload_dir/4.txt $total_bytes 0 0 $write_buffer_size $target_file_size_base $target_file_number
./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb5/ $workspace_dir/run5 $workload_dir/5.txt $total_bytes 0 0 $write_buffer_size $target_file_size_base $target_file_number &
./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb6/ $workspace_dir/run6 $workload_dir/6.txt $total_bytes 0 0 $write_buffer_size $target_file_size_base $target_file_number
./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb7/ $workspace_dir/run7 $workload_dir/7.txt $total_bytes 0 0 $write_buffer_size $target_file_size_base $target_file_number &
./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb8/ $workspace_dir/run8 $workload_dir/8.txt $total_bytes 0 0 $write_buffer_size $target_file_size_base $target_file_number
./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb9/ $workspace_dir/run9 $workload_dir/9.txt $total_bytes 0 0 $write_buffer_size $target_file_size_base $target_file_number &
./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb10/ $workspace_dir/run10 $workload_dir/10.txt $total_bytes 0 0 $write_buffer_size $target_file_size_base $target_file_number
