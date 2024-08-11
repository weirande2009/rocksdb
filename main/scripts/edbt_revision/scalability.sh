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
    max_bytes_for_level_base=$((target_file_size_base * target_file_number))
    write_buffer_data_structure=Vector
    max_bytes_for_level_multiplier=4

    percentage_insert=$1
    percentage_update=$2
    n_workloads=$3
    num_operation=$5
    entry_size=$6
    workload_size=$((num_operation * entry_size))

    num_insert=$((num_operation * percentage_insert / 100))
    num_update=$((num_operation * percentage_update / 100))
    dir_name=compare_workload_size/first_run/$7/${percentage_insert}_${percentage_update}
    workload_dir=workloads/edbt_revision/$dir_name
    workspace_dir=workspace/edbt_revision/$dir_name
    mkdir -p $workload_dir
    mkdir -p $workspace_dir
    
    rocksdb_dir=$4/${percentage_insert}_${percentage_update}
    mkdir -p $rocksdb_dir

    for i in $(seq 1 $n_workloads)
    do  
        ./load_gen --output_path $workload_dir/${i}.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8
        initialize_workspace $workspace_dir/run$i
        run_all_baselines_with_refined_mor $workload_size $rocksdb_dir $workspace_dir/run$i $workload_dir/${i}.txt $write_buffer_size $target_file_size_base $max_bytes_for_level_base $write_buffer_data_structure $max_bytes_for_level_multiplier
        rm $workload_dir/${i}.txt
    done

    rm -rf $rocksdb_dir
}

num_workloads=20

experiment_name=20_512_size
rocksdb_root_dir=/scratchNVM1/ranw/$experiment_name
num_operation=$((20 * 1024 * 1024))
entry_size=512
run_multiple_times_for_baseline 100 0 $num_workloads $rocksdb_root_dir $num_operation $entry_size $experiment_name
run_multiple_times_for_baseline 75 25 $num_workloads $rocksdb_root_dir $num_operation $entry_size $experiment_name
run_multiple_times_for_baseline 50 50 $num_workloads $rocksdb_root_dir $num_operation $entry_size $experiment_name

experiment_name=40_512_size
rocksdb_root_dir=/scratchNVM1/ranw/$experiment_name
num_operation=$((40 * 1024 * 1024))
entry_size=512
run_multiple_times_for_baseline 100 0 $num_workloads $rocksdb_root_dir $num_operation $entry_size $experiment_name
run_multiple_times_for_baseline 75 25 $num_workloads $rocksdb_root_dir $num_operation $entry_size $experiment_name
run_multiple_times_for_baseline 50 50 $num_workloads $rocksdb_root_dir $num_operation $entry_size $experiment_name

experiment_name=80_512_size
rocksdb_root_dir=/scratchNVM1/ranw/$experiment_name
num_operation=$((80 * 1024 * 1024))
entry_size=512
run_multiple_times_for_baseline 100 0 $num_workloads $rocksdb_root_dir $num_operation $entry_size $experiment_name
run_multiple_times_for_baseline 75 25 $num_workloads $rocksdb_root_dir $num_operation $entry_size $experiment_name
run_multiple_times_for_baseline 50 50 $num_workloads $rocksdb_root_dir $num_operation $entry_size $experiment_name

experiment_name=10_1024_size
rocksdb_root_dir=/scratchNVM1/ranw/$experiment_name
num_operation=$((10 * 1024 * 1024))
entry_size=1024
run_multiple_times_for_baseline 100 0 $num_workloads $rocksdb_root_dir $num_operation $entry_size $experiment_name
run_multiple_times_for_baseline 75 25 $num_workloads $rocksdb_root_dir $num_operation $entry_size $experiment_name
run_multiple_times_for_baseline 50 50 $num_workloads $rocksdb_root_dir $num_operation $entry_size $experiment_name

experiment_name=20_1024_size
rocksdb_root_dir=/scratchNVM1/ranw/$experiment_name
num_operation=$((20 * 1024 * 1024))
entry_size=1024
run_multiple_times_for_baseline 100 0 $num_workloads $rocksdb_root_dir $num_operation $entry_size $experiment_name
run_multiple_times_for_baseline 75 25 $num_workloads $rocksdb_root_dir $num_operation $entry_size $experiment_name
run_multiple_times_for_baseline 50 50 $num_workloads $rocksdb_root_dir $num_operation $entry_size $experiment_name

experiment_name=40_1024_size
rocksdb_root_dir=/scratchNVM1/ranw/$experiment_name
num_operation=$((40 * 1024 * 1024))
entry_size=1024
run_multiple_times_for_baseline 100 0 $num_workloads $rocksdb_root_dir $num_operation $entry_size $experiment_name
run_multiple_times_for_baseline 75 25 $num_workloads $rocksdb_root_dir $num_operation $entry_size $experiment_name
run_multiple_times_for_baseline 50 50 $num_workloads $rocksdb_root_dir $num_operation $entry_size $experiment_name
