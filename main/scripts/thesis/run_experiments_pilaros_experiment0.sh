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
workspace_dir_non_skip=workspace/compare_optimal_policies/$dir_name/non_skip
workspace_dir_skip=workspace/compare_optimal_policies/$dir_name/skip
workspace_dir_optimal=workspace/compare_optimal_policies/$dir_name/optimal
mkdir -p $workload_dir
mkdir -p $workspace_dir_non_skip
mkdir -p $workspace_dir_skip
mkdir -p $workspace_dir_optimal

./load_gen --output_path $workload_dir/1.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8
./load_gen --output_path $workload_dir/2.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8
./load_gen --output_path $workload_dir/3.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8
./load_gen --output_path $workload_dir/4.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8
./load_gen --output_path $workload_dir/5.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8
./load_gen --output_path $workload_dir/6.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8
./load_gen --output_path $workload_dir/7.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8
./load_gen --output_path $workload_dir/8.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8
./load_gen --output_path $workload_dir/9.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8
./load_gen --output_path $workload_dir/10.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8
