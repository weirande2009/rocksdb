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
        exit 1
    fi

    write_buffer_size=$((8 * 1024 * 1024))
    target_file_size_base=$((8 * 1024 * 1024))
    target_file_number=4

    percentage_insert=$1
    percentage_update=$2
    n_workloads=$3
    entry_size=8
    num_operation=8000000
    workload_size=$((entry_size * num_operation))

    num_insert=$((num_operation * percentage_insert / 100))
    num_update=$((num_operation * percentage_update / 100))
    dir_name=case_study/first_run/${percentage_insert}_${percentage_update}
    workload_dir=workloads/$dir_name
    workspace_dir=workspace/$dir_name/
    mkdir -p $workload_dir
    mkdir -p $workspace_dir
    
    rocksdb_dir=mnt/${percentage_insert}_${percentage_update}
    mkdir -p $rocksdb_dir

    for i in $(seq 1 $n_workloads)
    do  
        ./load_gen --output_path $workload_dir/${i}.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8

        initialize_workspace $workspace_dir/run$i
        run_all_baselines $workload_size $rocksdb_dir $workspace_dir/run$i $workload_dir/${i}.txt $write_buffer_size $target_file_size_base $target_file_number
        run_once $workload_size $rocksdb_dir $workspace_dir/run$i kSelectLastSimilar $workload_dir/${i}.txt $write_buffer_size $target_file_size_base $target_file_number

        # if this is not the first run, remove the workload file
        rm $workload_dir/${i}.txt
    done

    rm -rf $rocksdb_dir
}

num_workloads=10

# run experiments on SSD & NVMe
run_multiple_times_for_baseline 100 0 $num_workloads
