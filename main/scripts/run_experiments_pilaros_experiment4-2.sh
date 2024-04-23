# Experiment with different workloads
# workloads settings: 8 bytes key size fixed
# operation number: 10m, 20m, 40m (1024 bytes entry size)
# entry size: 2048 bytes, 4096 bytes, 8192 bytes (5m operations)
# workload distribution: 
# 1. 100% insert
# 2. 75% insert, 75% update
# 3. 50% insert, 50% update
# For each type of workload, we run 10 times.
# Each line contains the min, max, mean, and median, 25% and 75% quantile of the 10 runs

source ./scripts/run_workload_backup.sh

run_multiple_times_for_baseline() {
    if ! [ $# -eq 7 ]; then
        echo 'get the number of parameters:' $#
        echo 'in this shell script, there will be three parameters, which are:'
        echo '1. percentage_insert'
        echo '2. percentage_update'
        echo '3. percentage_delete'
        echo '4. the number of workloads'
        echo '5. rocksdb_root_dir'
        echo '6. num_operation'
        echo '7. entry_size'
        echo '8. experiment name'
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
    workload_size=$(((num_insert + num_update) * entry_size))
    dir_name=compare_workload_size/first_run/$8/${percentage_insert}_${percentage_update}_${percentage_delete}
    workload_dir=workloads/$dir_name
    workspace_dir=workspace/$dir_name
    mkdir -p $workload_dir
    mkdir -p $workspace_dir
    
    rocksdb_dir=$5/${percentage_insert}_${percentage_update}_${percentage_delete}
    mkdir -p $rocksdb_dir

    for i in $(seq 1 $n_workloads)
    do  
        ./load_gen --output_path $workload_dir/${i}.txt -I $num_insert -U $num_update -D $num_delete -E $entry_size -K 8
        initialize_workspace $workspace_dir/run$i
        run_all_baselines $workload_size $rocksdb_dir $workspace_dir/run$i $workload_dir/${i}.txt $write_buffer_size $target_file_size_base $target_file_number
        run_once $workload_size $rocksdb_dir $workspace_dir/run$i kSelectLastSimilar $workload_dir/${i}.txt $write_buffer_size $target_file_size_base $target_file_number
        if [ $i -ne 1 ]; then
            rm $workload_dir/${i}.txt
        fi
    done

    rm -rf $rocksdb_dir
}

num_workloads=10

# run experiments on 10m operations, 1024 bytes entry size
rocksdb_root_dir=/scratchNVM1/ranw/10_1024_size
num_operation=$((10 * 1024 * 1024))
entry_size=1024
run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_10_1024 & # workload 1: 100% insert, 0% update
run_multiple_times_for_baseline 80 15 5 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_10_1024 & # workload 2: 75% insert, 25% update
run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_10_1024   # workload 3: 50% insert, 50% update

# run experiments on 20m operations, 1024 bytes entry size
rocksdb_root_dir=/scratchNVM1/ranw/20_1024_size
num_operation=$((20 * 1024 * 1024))
entry_size=1024
run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_20_1024 & # workload 1: 100% insert, 0% update
run_multiple_times_for_baseline 80 15 5 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_20_1024 & # workload 2: 75% insert, 25% update
run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_20_1024   # workload 3: 50% insert, 50% update

# run experiments on 40m operations, 1024 bytes entry size
rocksdb_root_dir=/scratchNVM1/ranw/40_1024_size
num_operation=$((40 * 1024 * 1024))
entry_size=1024
run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_40_1024 & # workload 1: 100% insert, 0% update
run_multiple_times_for_baseline 80 15 5 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_40_1024 & # workload 2: 75% insert, 25% update
run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_40_1024   # workload 3: 50% insert, 50% update

# run experiments on 5m operations, 2048 bytes entry size
rocksdb_root_dir=/scratchNVM1/ranw/5_2048_size
num_operation=$((5 * 1024 * 1024))
entry_size=2048
run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_5_2048 & # workload 1: 100% insert, 0% update
run_multiple_times_for_baseline 80 15 5 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_5_2048 & # workload 2: 75% insert, 25% update
run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_5_2048   # workload 3: 50% insert, 50% update

# run experiments on 5m operations, 4096 bytes entry size
rocksdb_root_dir=/scratchNVM1/ranw/5_4096_size
num_operation=$((5 * 1024 * 1024))
entry_size=4096
run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_5_4096 & # workload 1: 100% insert, 0% update
run_multiple_times_for_baseline 80 15 5 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_5_4096 & # workload 2: 75% insert, 25% update
run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_5_4096   # workload 3: 50% insert, 50% update

# run experiments on 5m operations, 8192 bytes entry size
rocksdb_root_dir=/scratchNVM1/ranw/5_8192_size
num_operation=$((5 * 1024 * 1024))
entry_size=8192
run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_5_8192 & # workload 1: 100% insert, 0% update
run_multiple_times_for_baseline 80 15 5 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_5_8192 & # workload 2: 75% insert, 25% update
run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_5_8192   # workload 3: 50% insert, 50% update
