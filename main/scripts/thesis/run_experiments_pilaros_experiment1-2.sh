# Experiment on 4 baseline policies and the optimal policy
# workloads settings: 8 bytes key size, 64 bytes entry size, 2500000 operations
# workload 1: 100% insert, 0% update
# workload 2: 90% insert, 10% update
# workload 3: 80% insert, 20% update
# workload 4: 70% insert, 30% update
# workload 5: 60% insert, 40% update
# workload 6: 50% insert, 50% update
# For each type of workload, we run 10 times.
# There will be 6 plots, each plot contains 5 lines, each line represents a policy
# Each line contains the min, max, mean, and median, 25% and 75% quantile of the 10 runs

# Expected result:
# 1. optimal policy is the best
# 2. kRoundRobin are stable and good
# 3. kMinOverlappingRatio are not stable, but generally good
# 4. kOldestLargestSeqFirst and kOldestSmallestSeqFirst are neither stable nor good

source ./scripts/run_workload.sh

run_multiple_times_for_a_type() {
    if ! [ $# -eq 4 ]; then
        echo 'in this shell script, there will be three parameters, which are:'
        echo '1. percentage_insert'
        echo '2. percentage_update'
        echo '3. percentage_delete'
        echo '4. the number of workloads'
        exit 1
    fi

    write_buffer_size=$((8 * 1024 * 1024))
    target_file_size_base=$((8 * 1024 * 1024))
    target_file_number=4

    percentage_insert=$1
    percentage_update=$2
    percentage_delete=$3
    n_workloads=$4
    
    entry_size=64
    num_operation=2500000
    num_insert=$((num_operation * percentage_insert / 100))
    num_update=$((num_operation * percentage_update / 100))
    num_delete=$((num_operation * percentage_delete / 100))
    workload_size=$(((num_insert + num_update) * entry_size))
    experiment_root_name=compare_optimal_with_baselines
    experiment_name=${num_operation}_${entry_size}_8_memory/first_run/${percentage_insert}_${percentage_update}_${percentage_delete}
    dir_name=$experiment_root_name/$experiment_name
    workload_dir=workloads/$dir_name
    workspace_dir=workspace/$dir_name
    mkdir -p $workload_dir
    mkdir -p $workspace_dir
    
    rocksdb_dir=/mnt/ramd/ranw/$dir_name
    mkdir -p $rocksdb_dir

    enumeration_runs=15000

    for i in $(seq 2 $n_workloads)
    do  
        ./load_gen --output_path $workload_dir/${i}.txt -I $num_insert -U $num_update -D $num_delete -E $entry_size -K 8

        ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb$i/ $workspace_dir/run$i $workload_dir/${i}.txt $workload_size 1 0 $write_buffer_size $target_file_size_base $target_file_number
    done

    rm -rf $rocksdb_dir
}

num_workloads=10

run_multiple_times_for_a_type 80 10 10 $num_workloads &
run_multiple_times_for_a_type 80 12 8  $num_workloads &
run_multiple_times_for_a_type 80 14 6  $num_workloads &
run_multiple_times_for_a_type 80 16 4  $num_workloads &
run_multiple_times_for_a_type 80 18 2  $num_workloads &
run_multiple_times_for_a_type 80 20 0  $num_workloads  

