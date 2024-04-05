# Experiment on 4 baseline policies on both SSD and NVMe
# workloads settings: 5GB workload
# workload 1: 100% insert, 0% update
# workload 2: 90% insert, 10% update
# workload 3: 80% insert, 20% update
# workload 4: 70% insert, 30% update
# workload 5: 60% insert, 40% update
# workload 6: 50% insert, 50% update
# For each type of workload, we run 10 times.

source ./scripts/run_workload.sh

run_multiple_times_for_baseline() {
    if ! [ $# -eq 3 ]; then
        echo 'in this shell script, there will be three parameters, which are:'
        echo '1. percentage_insert'
        echo '2. percentage_update'
        echo '3. the number of workloads'
        echo '4. rocksdb_root_dir'
        exit 1
    fi

    write_buffer_size=$((64 * 1024 * 1024))
    target_file_size_base=$((64 * 1024 * 1024))
    target_file_number=4

    percentage_insert=$1
    percentage_update=$2
    n_workloads=$3
    workload_size=$((5 * 1024 * 1024 * 1024))
    entry_size=1024
    num_operation=$((workload_size / entry_size))

    num_insert=$((num_operation * percentage_insert / 100))
    num_update=$((num_operation * percentage_update / 100))
    dir_name=compare_devices/5gb/first_run/${percentage_insert}_${percentage_update}
    workload_dir=workloads/$dir_name
    workspace_dir=workspace/$dir_name
    mkdir -p $workload_dir
    mkdir -p $workspace_dir
    
    rocksdb_dir=$4/${percentage_insert}_${percentage_update}
    # rocksdb_dir=mnt/${percentage_insert}_${percentage_update}
    mkdir -p $rocksdb_dir

    for i in $(seq 1 $n_workloads)
    do  
        ./load_gen --output_path $workload_dir/${i}.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8
        initialize_workspace $workspace_dir/run$i
        run_all_baselines $workload_size $rocksdb_dir $workspace_dir/run$i $workload_dir/${i}.txt $write_buffer_size $target_file_size_base $target_file_number
        # if this is not the first run, remove the workload file
        if [ $i -ne 1 ]; then
            rm $workload_dir/${i}.txt
        fi
    done

    rm -rf $rocksdb_dir
}

num_workloads=10

# run experiments on SSD
ssd_path=/scratchSSD/ranw/ssd
run_multiple_times_for_baseline 100 0 $num_workloads $ssd_path & # workload 1: 100% insert, 0% update
run_multiple_times_for_baseline 90 10 $num_workloads $ssd_path & # workload 2: 90% insert, 10% update
run_multiple_times_for_baseline 80 20 $num_workloads $ssd_path & # workload 3: 80% insert, 20% update
run_multiple_times_for_baseline 70 30 $num_workloads $ssd_path & # workload 4: 70% insert, 30% update
run_multiple_times_for_baseline 60 40 $num_workloads $ssd_path & # workload 5: 60% insert, 40% update
run_multiple_times_for_baseline 50 50 $num_workloads $ssd_path   # workload 6: 50% insert, 50% update

# run experiments on NVMe1
nvme1_path=/scratchNVM1/ranw/nvme1
run_multiple_times_for_baseline 100 0 $num_workloads $nvme1_path & # workload 1: 100% insert, 0% update
run_multiple_times_for_baseline 90 10 $num_workloads $nvme1_path & # workload 2: 90% insert, 10% update
run_multiple_times_for_baseline 80 20 $num_workloads $nvme1_path & # workload 3: 80% insert, 20% update
run_multiple_times_for_baseline 70 30 $num_workloads $nvme1_path & # workload 4: 70% insert, 30% update
run_multiple_times_for_baseline 60 40 $num_workloads $nvme1_path & # workload 5: 60% insert, 40% update
run_multiple_times_for_baseline 50 50 $num_workloads $nvme1_path   # workload 6: 50% insert, 50% update
