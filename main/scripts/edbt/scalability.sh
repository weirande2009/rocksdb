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

source ./scripts/run_workload.sh

run_multiple_times_for_baseline() {
    if ! [ $# -eq 7 ]; then
        echo 'get the number of parameters:' $#
        echo 'in this shell script, there will be three parameters, which are:'
        echo '1. percentage_insert'
        echo '2. percentage_update'
        echo '3. the number of workloads'
        echo '4. rocksdb_root_dir'
        echo '5. num_operation'
        echo '6. entry_size'
        echo '7. experiment name'
        exit 1
    fi

    write_buffer_size=$((64 * 1024 * 1024))
    target_file_size_base=$((64 * 1024 * 1024))
    target_file_number=4

    percentage_insert=$1
    percentage_update=$2
    n_workloads=$3
    num_operation=$5
    entry_size=$6
    workload_size=$((num_operation * entry_size))

    num_insert=$((num_operation * percentage_insert / 100))
    num_update=$((num_operation * percentage_update / 100))
    dir_name=compare_workload_size/first_run/$7/${percentage_insert}_${percentage_update}
    workload_dir=workloads/edbt/$dir_name
    workspace_dir=workspace/edbt/$dir_name
    mkdir -p $workload_dir
    mkdir -p $workspace_dir
    
    rocksdb_dir=$4/${percentage_insert}_${percentage_update}
    mkdir -p $rocksdb_dir

    for i in $(seq 1 $n_workloads)
    do  
        ./load_gen --output_path $workload_dir/${i}.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8
        initialize_workspace $workspace_dir/run$i
        run_all_baselines $workload_size $rocksdb_dir $workspace_dir/run$i $workload_dir/${i}.txt $write_buffer_size $target_file_size_base $target_file_number
        rm $workload_dir/${i}.txt
    done

    rm -rf $rocksdb_dir
}

num_workloads=10

# run experiments on 10m operations, 1024 bytes entry size
rocksdb_root_dir=/scratchNVM1/ranw/10_1024_size
num_operation=$((10 * 1024 * 1024))
entry_size=1024
run_multiple_times_for_baseline 100 0 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_10_1024 & # workload 1: 100% insert, 0% update
run_multiple_times_for_baseline 75 25 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_10_1024 & # workload 2: 75% insert, 25% update
run_multiple_times_for_baseline 50 50 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_10_1024 & # workload 3: 50% insert, 50% update

wait $(jobs -p)

# run experiments on 20m operations, 1024 bytes entry size
rocksdb_root_dir=/scratchNVM1/ranw/20_1024_size
num_operation=$((20 * 1024 * 1024))
entry_size=1024
run_multiple_times_for_baseline 100 0 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_20_1024 & # workload 1: 100% insert, 0% update
run_multiple_times_for_baseline 75 25 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_20_1024 & # workload 2: 75% insert, 25% update
run_multiple_times_for_baseline 50 50 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_20_1024 & # workload 3: 50% insert, 50% update

wait $(jobs -p)

# run experiments on 40m operations, 1024 bytes entry size
rocksdb_root_dir=/scratchNVM1/ranw/40_1024_size
num_operation=$((40 * 1024 * 1024))
entry_size=1024
run_multiple_times_for_baseline 100 0 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_40_1024 & # workload 1: 100% insert, 0% update
run_multiple_times_for_baseline 75 25 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_40_1024 & # workload 2: 75% insert, 25% update
run_multiple_times_for_baseline 50 50 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_40_1024 & # workload 3: 50% insert, 50% update

wait $(jobs -p)

# run experiments on 5m operations, 2048 bytes entry size
rocksdb_root_dir=/scratchNVM1/ranw/5_2048_size
num_operation=$((5 * 1024 * 1024))
entry_size=2048
run_multiple_times_for_baseline 100 0 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_5_2048 & # workload 1: 100% insert, 0% update
run_multiple_times_for_baseline 75 25 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_5_2048 & # workload 2: 75% insert, 25% update
run_multiple_times_for_baseline 50 50 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_5_2048 & # workload 3: 50% insert, 50% update

wait $(jobs -p)

# run experiments on 5m operations, 4096 bytes entry size
rocksdb_root_dir=/scratchNVM1/ranw/5_4096_size
num_operation=$((5 * 1024 * 1024))
entry_size=4096
run_multiple_times_for_baseline 100 0 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_5_4096 & # workload 1: 100% insert, 0% update
run_multiple_times_for_baseline 75 25 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_5_4096 & # workload 2: 75% insert, 25% update
run_multiple_times_for_baseline 50 50 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_5_4096 & # workload 3: 50% insert, 50% update

wait $(jobs -p)

# run experiments on 5m operations, 8192 bytes entry size
rocksdb_root_dir=/scratchNVM1/ranw/5_8192_size
num_operation=$((5 * 1024 * 1024))
entry_size=8192
run_multiple_times_for_baseline 100 0 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_5_8192 & # workload 1: 100% insert, 0% update
run_multiple_times_for_baseline 75 25 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_5_8192 & # workload 2: 75% insert, 25% update
run_multiple_times_for_baseline 50 50 $num_workloads $rocksdb_root_dir $num_operation $entry_size size_5_8192 & # workload 3: 50% insert, 50% update

wait $(jobs -p)
