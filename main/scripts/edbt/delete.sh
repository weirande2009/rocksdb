# Experiment on 4 baseline policies and the optimal policy, but with delete
# workloads settings: 8 bytes key size, 64 bytes entry size, 2000000 operations
# workload 1: 80% insert, 10% update, 10% delete
# workload 2: 80% insert, 12% update, 8% delete
# workload 3: 80% insert, 14% update, 6% delete
# workload 4: 80% insert, 16% update, 4% delete
# workload 5: 80% insert, 18% update, 2% delete
# workload 6: 80% insert, 20% update, 0% delete
# For each type of workload, we run 10 times.
# There will be 5 plots, each plot contains 5 lines, each line represents a policy
# Each line contains the min, max, mean, and median, 25% and 75% quantile of the 10 runs

source ./scripts/run_workload.sh

run_multiple_times_for_baseline() {
    if ! [ $# -eq 5 ]; then
        echo 'get the number of parameters:' $#
        echo 'in this shell script, there will be three parameters, which are:'
        echo '1. percentage_insert'
        echo '2. percentage_update'
        echo '3. percentage_delete'
        echo '4. the number of workloads'
        echo '5. rocksdb_root_dir'
        exit 1
    fi

    write_buffer_size=$((64 * 1024 * 1024))
    target_file_size_base=$((64 * 1024 * 1024))
    target_file_number=4

    percentage_insert=$1
    percentage_update=$2
    percentage_delete=$3
    n_workloads=$4
    entry_size=1024
    num_operation=$((5 * 1024 * 1024))

    num_insert=$((num_operation * percentage_insert / 100))
    num_update=$((num_operation * percentage_update / 100))
    num_delete=$((num_operation * percentage_delete / 100))
    total_operation=$((num_insert + num_update + num_delete))
    workload_size=$(((num_insert + num_update) * entry_size))
    dir_name=compare_delete/5gb/first_run/${num_operation}/${percentage_insert}_${percentage_update}_${percentage_delete}
    workload_dir=workloads/edbt/$dir_name
    workspace_dir=workspace/edbt/$dir_name
    mkdir -p $workload_dir
    mkdir -p $workspace_dir
    
    rocksdb_dir=$5/${percentage_insert}_${percentage_update}_${percentage_delete}
    mkdir -p $rocksdb_dir

    for i in $(seq 1 $n_workloads)
    do  
        ./load_gen --output_path $workload_dir/${i}.txt -I $num_insert -U $num_update -D $num_delete -E $entry_size -K 8
        initialize_workspace $workspace_dir/run$i
        run_all_baselines $workload_size $rocksdb_dir $workspace_dir/run$i $workload_dir/${i}.txt $write_buffer_size $target_file_size_base $target_file_number
        rm $workload_dir/${i}.txt
    done

    rm -rf $rocksdb_dir
}

num_workloads=10

# run experiments on normal(0.5, 0.01)
rocksdb_root_dir=/scratchNVM1/ranw/delete
# run_multiple_times_for_baseline 100 0 5 $num_workloads $rocksdb_root_dir &
# run_multiple_times_for_baseline 100 0 10 $num_workloads $rocksdb_root_dir &
# run_multiple_times_for_baseline 100 0 15 $num_workloads $rocksdb_root_dir &
# run_multiple_times_for_baseline 100 0 20 $num_workloads $rocksdb_root_dir &
# run_multiple_times_for_baseline 100 0 25 $num_workloads $rocksdb_root_dir &

# wait $(jobs -p)

# run_multiple_times_for_baseline 100 0 30 $num_workloads $rocksdb_root_dir &
# run_multiple_times_for_baseline 100 0 35 $num_workloads $rocksdb_root_dir &
# run_multiple_times_for_baseline 100 0 40 $num_workloads $rocksdb_root_dir &
# run_multiple_times_for_baseline 100 0 45 $num_workloads $rocksdb_root_dir &
# run_multiple_times_for_baseline 100 0 50 $num_workloads $rocksdb_root_dir &

# wait $(jobs -p)

while ps -p 3317694 > /dev/null; do
    sleep 1
done

run_multiple_times_for_baseline 50 50 5 $num_workloads $rocksdb_root_dir &
run_multiple_times_for_baseline 50 50 10 $num_workloads $rocksdb_root_dir &
run_multiple_times_for_baseline 50 50 15 $num_workloads $rocksdb_root_dir &
run_multiple_times_for_baseline 50 50 20 $num_workloads $rocksdb_root_dir &
run_multiple_times_for_baseline 50 50 25 $num_workloads $rocksdb_root_dir &
run_multiple_times_for_baseline 50 50 30 $num_workloads $rocksdb_root_dir &

wait $(jobs -p)
