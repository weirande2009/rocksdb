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
        echo '3. percentage_delete'
        echo '4. the number of workloads'
        echo '5. rocksdb_root_dir'
        echo '6. update distribution'
        echo '7. experiment name'
        exit 1
    fi

    write_buffer_size=$((1 * 1024 * 1024))
    target_file_size_base=$((1 * 1024 * 1024))
    target_file_number=4

    percentage_insert=$1
    percentage_update=$2
    percentage_delete=$3
    n_workloads=$4
    
    entry_size=64
    num_operation=$((300 * 1024))
    num_insert=$((num_operation * percentage_insert / 100))
    num_update=$((num_operation * percentage_update / 100))
    num_delete=$((num_operation * percentage_delete / 100))
    workload_size=$(((num_insert + num_update) * entry_size))
    experiment_root_name=compare_optimal_with_baselines
    experiment_name=${num_operation}_${entry_size}_8_memory/first_run/$7/${percentage_insert}_${percentage_update}_${percentage_delete}
    dir_name=$experiment_root_name/$experiment_name
    workload_dir=workloads/$dir_name
    workspace_dir=workspace/$dir_name
    mkdir -p $workload_dir
    mkdir -p $workspace_dir
    
    rocksdb_dir=$5/$dir_name
    mkdir -p $rocksdb_dir

    enumeration_runs=30000

    for i in $(seq 1 $n_workloads)
    do  
        ./load_gen --output_path $workload_dir/${i}.txt -I $num_insert -U $num_update -D $num_delete -E $entry_size -K 8 $6
        ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb$i/ $workspace_dir/run$i $workload_dir/${i}.txt $workload_size 1 0 $write_buffer_size $target_file_size_base $target_file_number
        rm $workload_dir/${i}.txt
    done

    # get half of n_workloads
    # n_workloads_half=$((n_workloads / 2))

    # for i in $(seq 1 $n_workloads_half)
    # do  
    #     ./load_gen --output_path $workload_dir/${i}.txt -I $num_insert -U $num_update -D $num_delete -E $entry_size -K 8 $6
    #     ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb$i/ $workspace_dir/run$i $workload_dir/${i}.txt $workload_size 1 0 $write_buffer_size $target_file_size_base $target_file_number &
    #     rm $workload_dir/${i}.txt
    # done

    # wait $(jobs -p)

    # # from n_workloads_half + 1 to n_workloads
    # for i in $(seq $((n_workloads_half + 1)) $n_workloads)
    # do  
    #     ./load_gen --output_path $workload_dir/${i}.txt -I $num_insert -U $num_update -D $num_delete -E $entry_size -K 8 $6
    #     ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb$i/ $workspace_dir/run$i $workload_dir/${i}.txt $workload_size 1 0 $write_buffer_size $target_file_size_base $target_file_number
    #     rm $workload_dir/${i}.txt
    # done

    # wait $(jobs -p)

    rm -rf $rocksdb_dir
}

num_workloads=1
rocksdb_root_dir=/mnt/ramd/ranw/
experiment_name=buffer_size_1MB

run_multiple_times_for_a_type 100 0 0 $num_workloads $rocksdb_root_dir --UD\ 1 $experiment_name &
run_multiple_times_for_a_type 90 10 0 $num_workloads $rocksdb_root_dir --UD\ 1 $experiment_name &
run_multiple_times_for_a_type 80 20 0 $num_workloads $rocksdb_root_dir --UD\ 1 $experiment_name &
run_multiple_times_for_a_type 70 30 0 $num_workloads $rocksdb_root_dir --UD\ 1 $experiment_name &
run_multiple_times_for_a_type 60 40 0 $num_workloads $rocksdb_root_dir --UD\ 1 $experiment_name &
run_multiple_times_for_a_type 50 50 0 $num_workloads $rocksdb_root_dir --UD\ 1 $experiment_name &

wait $(jobs -p)
