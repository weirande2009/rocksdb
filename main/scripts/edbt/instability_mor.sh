# Experiment on 2 good baseline policies with different update distribution
# workloads settings: 8 bytes key size, 64 bytes entry size, 2000000 operations
# update proportion: 10%, 20%, 30%, 40%, 50%
# update distribution: zipfian(0.8), zipfian(1.0), zipfian(1.2), normal(0.5, 1), normal(0.5, 0.5), normal(0.5, 2)
# For each type of workload, we run 10 times.
# There will be 6 plots, each plot contains 5 lines, each line represents 
# Each line contains the min, max, mean, and median, 25% and 75% quantile of the 10 runs

source ./scripts/run_workload.sh

run_multiple_times_for_baseline() {
    if ! [ $# -eq 10 ]; then
        echo 'get the number of parameters:' $#
        echo 'in this shell script, there will be three parameters, which are:'
        echo '1. percentage_insert'
        echo '2. percentage_update'
        echo '3. percentage_delete'
        echo '4. the number of workloads'
        echo '5. rocksdb_root_dir'
        echo '6. update distribution'
        echo '7. experiment name'
        echo '8. buffer size'
        echo '9. operation number'
        echo '10. entry size'
        exit 1
    fi

    write_buffer_size=$8
    target_file_size_base=$8
    target_file_number=4

    percentage_insert=$1
    percentage_update=$2
    percentage_delete=$3
    n_workloads=$4
    num_operation=$9
    entry_size=${10}

    num_insert=$((num_operation * percentage_insert / 100))
    num_update=$((num_operation * percentage_update / 100))
    num_delete=$((num_operation * percentage_delete / 100))
    workload_size=$(((num_insert + num_update) * entry_size))
    dir_name=instability_mor/$7/${num_operation}_${entry_size}/${percentage_insert}_${percentage_update}_${percentage_delete}
    workload_dir=workloads/edbt/$dir_name
    workspace_dir=workspace/edbt/$dir_name
    mkdir -p $workload_dir
    mkdir -p $workspace_dir
    
    rocksdb_dir=$5/${percentage_insert}_${percentage_update}_${percentage_delete}
    mkdir -p $rocksdb_dir

    ./load_gen --output_path $workload_dir/1.txt -I $num_insert -U $num_update -D $num_delete -E $entry_size -K 8 $6
    for i in $(seq 1 $n_workloads)
    do  
        initialize_workspace $workspace_dir/run$i
        run_all_baselines $workload_size $rocksdb_dir $workspace_dir/run$i $workload_dir/1.txt $write_buffer_size $target_file_size_base $target_file_number
    done
    rm $workload_dir/1.txt

    rm -rf $rocksdb_dir
}

update_distribution() {
    num_workloads=10

    rocksdb_root_dir=/scratchNVM1/ranw/instability_mor/uniform
    experiment_name=uniform
    buffer_size=$((8 * 1024 * 1024))
    num_operation=2500000
    entry_size=64
    run_multiple_times_for_baseline 100 0 0 $num_workloads $rocksdb_root_dir --UD\ 0 $experiment_name $buffer_size $num_operation $entry_size
    run_multiple_times_for_baseline 75 25 0 $num_workloads $rocksdb_root_dir --UD\ 0 $experiment_name $buffer_size $num_operation $entry_size
    run_multiple_times_for_baseline 50 50 0 $num_workloads $rocksdb_root_dir --UD\ 0 $experiment_name $buffer_size $num_operation $entry_size

    rocksdb_root_dir=/scratchNVM1/ranw/instability_mor/uniform
    experiment_name=uniform
    buffer_size=$((8 * 1024 * 1024))
    num_operation=1000000
    entry_size=64
    run_multiple_times_for_baseline 100 0 0 $num_workloads $rocksdb_root_dir --UD\ 0 $experiment_name $buffer_size $num_operation $entry_size
    run_multiple_times_for_baseline 75 25 0 $num_workloads $rocksdb_root_dir --UD\ 0 $experiment_name $buffer_size $num_operation $entry_size
    run_multiple_times_for_baseline 50 50 0 $num_workloads $rocksdb_root_dir --UD\ 0 $experiment_name $buffer_size $num_operation $entry_size

    # normal distribution
    rocksdb_root_dir=/scratchNVM1/ranw/instability_mor/normal
    experiment_name=normal
    buffer_size=$((64 * 1024 * 1024))
    num_operation=$((5 * 1024 * 1024))
    entry_size=1024
    run_multiple_times_for_baseline 100 0 0 $num_workloads $rocksdb_root_dir --UD\ 1 $experiment_name $buffer_size $num_operation $entry_size
    run_multiple_times_for_baseline 75 25 0 $num_workloads $rocksdb_root_dir --UD\ 1 $experiment_name $buffer_size $num_operation $entry_size
    run_multiple_times_for_baseline 50 50 0 $num_workloads $rocksdb_root_dir --UD\ 1 $experiment_name $buffer_size $num_operation $entry_size

    # zipfian distribution
    rocksdb_root_dir=/scratchNVM1/ranw/instability_mor/zipfian
    experiment_name=zipfian
    buffer_size=$((64 * 1024 * 1024))
    num_operation=$((5 * 1024 * 1024))
    entry_size=1024
    run_multiple_times_for_baseline 100 0 0 $num_workloads $rocksdb_root_dir --UD\ 3 $experiment_name $buffer_size $num_operation $entry_size
    run_multiple_times_for_baseline 75 25 0 $num_workloads $rocksdb_root_dir --UD\ 3 $experiment_name $buffer_size $num_operation $entry_size
    run_multiple_times_for_baseline 50 50 0 $num_workloads $rocksdb_root_dir --UD\ 3 $experiment_name $buffer_size $num_operation $entry_size
}

update_distribution
