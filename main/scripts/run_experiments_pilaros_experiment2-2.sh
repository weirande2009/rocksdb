# Experiment on 4 baseline policies on both SSD and NVMe
# workloads settings: 5GB workload
# workload 1: 80% insert, 10% update, 10% delete
# workload 2: 80% insert, 12% update, 8% delete
# workload 3: 80% insert, 14% update, 6% delete
# workload 4: 80% insert, 16% update, 4% delete
# workload 5: 80% insert, 18% update, 2% delete
# workload 6: 80% insert, 20% update, 0% delete
# For each type of workload, we run 10 times.

source ./scripts/run_workload.sh

run_multiple_times_for_baseline() {
    if ! [ $# -eq 3 ]; then
        echo 'in this shell script, there will be three parameters, which are:'
        echo '1. percentage_insert'
        echo '2. percentage_update'
        echo '3. percentage_delete'
        echo '4. the number of workloads'
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
    dir_name=compare_devices/5gb/first_run/${percentage_insert}_${percentage_update}_${percentage_delete}
    workload_dir=workloads/$dir_name
    workspace_dir_nvme1=workspace/$dir_name/nvme1
    workspace_dir_ssd=workspace/$dir_name/ssd
    mkdir -p $workload_dir
    mkdir -p $workspace_dir_nvme1
    mkdir -p $workspace_dir_ssd
    
    rocksdb_dir_nvme1=/scratchNVM1/ranw/nvme1/${percentage_insert}_${percentage_update}_${percentage_delete}
    rocksdb_dir_ssd=/scratchSSD/ranw/ssd/${percentage_insert}_${percentage_update}_${percentage_delete}
    # rocksdb_dir=mnt/${percentage_insert}_${percentage_update}
    mkdir -p $rocksdb_dir_nvme1
    mkdir -p $rocksdb_dir_ssd

    for i in $(seq 1 $n_workloads)
    do  
        ./load_gen --output_path $workload_dir/${i}.txt -I $num_insert -U $num_update -D $ -E $entry_size -K 8

        initialize_workspace $workspace_dir_nvme1/run$i
        run_all_baselines $workload_size $rocksdb_dir_nvme1 $workspace_dir_nvme1/run$i $workload_dir/${i}.txt $write_buffer_size $target_file_size_base $target_file_number
        run_once $workload_size $rocksdb_dir $workspace_dir/run$i kSelectLastSimilar $workload_dir/${i}.txt $write_buffer_size $target_file_size_base $target_file_number

        initialize_workspace $workspace_dir_ssd/run$i
        run_all_baselines $workload_size $rocksdb_dir_ssd $workspace_dir_ssd/run$i $workload_dir/${i}.txt $write_buffer_size $target_file_size_base $target_file_number
        run_once $workload_size $rocksdb_dir $workspace_dir/run$i kSelectLastSimilar $workload_dir/${i}.txt $write_buffer_size $target_file_size_base $target_file_number
        
        # if this is not the first run, remove the workload file
        if [ $i -ne 1 ]; then
            rm $workload_dir/${i}.txt
        fi
    done

    rm -rf $rocksdb_dir_nvme1
    rm -rf $rocksdb_dir_ssd
}

num_workloads=10

# run experiments on SSD & NVMe
run_multiple_times_for_baseline 80 10 10 $num_workloads &
run_multiple_times_for_baseline 80 12 8 $num_workloads &
run_multiple_times_for_baseline 80 14 6 $num_workloads &
run_multiple_times_for_baseline 80 16 4 $num_workloads &
run_multiple_times_for_baseline 80 18 2 $num_workloads &
run_multiple_times_for_baseline 80 20 0 $num_workloads
