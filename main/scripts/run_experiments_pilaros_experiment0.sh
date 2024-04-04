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
mkdir -p $workload_dir
mkdir -p $workspace_dir_non_skip
mkdir -p $workspace_dir_skip
mkdir -p $workspace_dir_optimal
./load_gen --output_path $workload_dir/1.txt -I 2000000 -U 2000000 -D 0 -E 64 -K 8
./load_gen --output_path $workload_dir/2.txt -I 2000000 -U 2000000 -D 0 -E 64 -K 8
./load_gen --output_path $workload_dir/3.txt -I 2000000 -U 2000000 -D 0 -E 64 -K 8
./load_gen --output_path $workload_dir/4.txt -I 2000000 -U 2000000 -D 0 -E 64 -K 8
./load_gen --output_path $workload_dir/5.txt -I 2000000 -U 2000000 -D 0 -E 64 -K 8
./load_gen --output_path $workload_dir/6.txt -I 2000000 -U 2000000 -D 0 -E 64 -K 8
./load_gen --output_path $workload_dir/7.txt -I 2000000 -U 2000000 -D 0 -E 64 -K 8
./load_gen --output_path $workload_dir/8.txt -I 2000000 -U 2000000 -D 0 -E 64 -K 8
./load_gen --output_path $workload_dir/9.txt -I 2000000 -U 2000000 -D 0 -E 64 -K 8
./load_gen --output_path $workload_dir/10.txt -I 2000000 -U 2000000 -D 0 -E 64 -K 8
