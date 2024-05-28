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
    if ! [ $# -eq 7 ]; then
        echo 'in this shell script, there will be three parameters, which are:'
        echo '1. percentage_insert'
        echo '2. percentage_update'
        echo '3. the number of workloads'
        echo '4. entry size'
        echo '5. number of operations'
        echo '6. type'
        echo '7. param'
        exit 1
    fi

    write_buffer_size=$((8 * 1024 * 1024))
    target_file_size_base=$((8 * 1024 * 1024))
    target_file_number=4

    percentage_insert=$1
    percentage_update=$2
    n_workloads=$3
    
    entry_size=$4
    num_operation=$5
    workload_size=$((num_operation * entry_size))

    type=$6
    param=$7

    num_insert=$((num_operation * percentage_insert / 100))
    num_update=$((num_operation * percentage_update / 100))
    experiment_root_name=edbt/compare_optimal_policies
    experiment_name=${num_operation}_${entry_size}_8_memory/first_run/${percentage_insert}_${percentage_update}
    dir_name=$experiment_root_name/$experiment_name

    workload_dir=workloads/$dir_name/$type
    mkdir -p $workload_dir

    workspace_dir=workspace/$dir_name/$type
    mkdir -p $workspace_dir
    
    rocksdb_dir=/mnt/ramd/ranw/$dir_name/$type
    mkdir -p $rocksdb_dir

    enumeration_runs=10000

    for i in $(seq 1 $n_workloads)
    do  
        ./load_gen --output_path $workload_dir/${i}.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8
        ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb$i/ $workspace_dir/run$i $workload_dir/${i}.txt $workload_size 0 0 $write_buffer_size $target_file_size_base $target_file_number &
    done

    wait $(jobs -p) 

    rm -rf $rocksdb_dir
}

num_workloads=10
entry_size=64
num_operation=2000000

run_multiple_times_for_a_type 100 0 $num_workloads $entry_size $num_operation skip 1\ 0 &
run_multiple_times_for_a_type 80 20 $num_workloads $entry_size $num_operation skip 1\ 0 &
run_multiple_times_for_a_type 60 40 $num_workloads $entry_size $num_operation skip 1\ 0 &

wait $(jobs -p)

run_multiple_times_for_a_type 100 0 $num_workloads $entry_size $num_operation non_skip 0\ 0 &
run_multiple_times_for_a_type 80 20 $num_workloads $entry_size $num_operation non_skip 0\ 0 &
run_multiple_times_for_a_type 60 40 $num_workloads $entry_size $num_operation non_skip 0\ 0 &

wait $(jobs -p)

run_multiple_times_for_a_type 100 0 $num_workloads $entry_size $num_operation optimal 1\ 1 &
run_multiple_times_for_a_type 80 20 $num_workloads $entry_size $num_operation optimal 1\ 1 &
run_multiple_times_for_a_type 60 40 $num_workloads $entry_size $num_operation optimal 1\ 1 &

wait $(jobs -p)

# entry_size=64
# num_operation=2500000
# run_multiple_times_for_a_type 50 50 $num_workloads $entry_size $num_operation &

# wait $(jobs -p)
