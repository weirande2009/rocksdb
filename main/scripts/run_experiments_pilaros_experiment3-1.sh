# Experiment on 2 good baseline policies with different update distribution
# workloads settings: 8 bytes key size, 64 bytes entry size, 2000000 operations
# update proportion: 10%, 20%, 30%, 40%, 50%
# update distribution: zipfian(0.8), zipfian(1.0), zipfian(1.2), normal(0.5, 1), normal(0.5, 0.5), normal(0.5, 2)
# For each type of workload, we run 10 times.
# There will be 6 plots, each plot contains 5 lines, each line represents 
# Each line contains the min, max, mean, and median, 25% and 75% quantile of the 10 runs

source ./scripts/run_workload.sh

run_multiple_times_for_baseline() {
    if ! [ $# -eq 6 ]; then
        echo 'get the number of parameters:' $#
        echo 'in this shell script, there will be three parameters, which are:'
        echo '1. percentage_insert'
        echo '2. percentage_update'
        echo '3. the number of workloads'
        echo '4. rocksdb_root_dir'
        echo '5. update distribution'
        echo '6. experiment name'
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
    dir_name=compare_update_distribution/5gb/first_run/$6/${percentage_insert}_${percentage_update}
    workload_dir=workloads/$dir_name
    workspace_dir=workspace/$dir_name
    mkdir -p $workload_dir
    mkdir -p $workspace_dir
    
    rocksdb_dir=$4/${percentage_insert}_${percentage_update}
    mkdir -p $rocksdb_dir

    for i in $(seq 1 $n_workloads)
    do  
        if [ $i -ne 1 ]; then
            ./load_gen --output_path $workload_dir/${i}.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8 $5 
        fi
        # initialize_workspace $workspace_dir/run$i
        run_once $workload_size $rocksdb_dir $workspace_dir/run$i kSelectLastSimilar $workload_dir/${i}.txt $write_buffer_size $target_file_size_base $target_file_number
        if [ $i -ne 1 ]; then
            rm $workload_dir/${i}.txt
        fi
    done

    rm -rf $rocksdb_dir
}

num_workloads=10

# run experiments on zipfian(0.8)
rocksdb_root_dir=/scratchNVM1/ranw/zipfian1
run_multiple_times_for_baseline 100 0 $num_workloads $rocksdb_root_dir --UD\ 3\ --UD_ZALPHA\ 0.8 zipfian1 & # workload 1: 100% insert, 0% update
sleep 60
run_multiple_times_for_baseline 90 10 $num_workloads $rocksdb_root_dir --UD\ 3\ --UD_ZALPHA\ 0.8 zipfian1 & # workload 2: 90% insert, 10% update
sleep 60
run_multiple_times_for_baseline 80 20 $num_workloads $rocksdb_root_dir --UD\ 3\ --UD_ZALPHA\ 0.8 zipfian1 & # workload 3: 80% insert, 20% update
sleep 60
run_multiple_times_for_baseline 70 30 $num_workloads $rocksdb_root_dir --UD\ 3\ --UD_ZALPHA\ 0.8 zipfian1 & # workload 4: 70% insert, 30% update
sleep 60
run_multiple_times_for_baseline 60 40 $num_workloads $rocksdb_root_dir --UD\ 3\ --UD_ZALPHA\ 0.8 zipfian1 & # workload 5: 60% insert, 40% update
sleep 60
run_multiple_times_for_baseline 50 50 $num_workloads $rocksdb_root_dir --UD\ 3\ --UD_ZALPHA\ 0.8 zipfian1   # workload 6: 50% insert, 50% update

# # run experiments on zipfian(1)
rocksdb_root_dir=/scratchNVM1/ranw/zipfian2
run_multiple_times_for_baseline 100 0 $num_workloads $rocksdb_root_dir --UD\ 3\ --UD_ZALPHA\ 1 zipfian2 & # workload 1: 100% insert, 0% update
sleep 60
run_multiple_times_for_baseline 90 10 $num_workloads $rocksdb_root_dir --UD\ 3\ --UD_ZALPHA\ 1 zipfian2 & # workload 2: 90% insert, 10% update
sleep 60
run_multiple_times_for_baseline 80 20 $num_workloads $rocksdb_root_dir --UD\ 3\ --UD_ZALPHA\ 1 zipfian2 & # workload 3: 80% insert, 20% update
sleep 60
run_multiple_times_for_baseline 70 30 $num_workloads $rocksdb_root_dir --UD\ 3\ --UD_ZALPHA\ 1 zipfian2 & # workload 4: 70% insert, 30% update
sleep 60
run_multiple_times_for_baseline 60 40 $num_workloads $rocksdb_root_dir --UD\ 3\ --UD_ZALPHA\ 1 zipfian2 & # workload 5: 60% insert, 40% update
sleep 60
run_multiple_times_for_baseline 50 50 $num_workloads $rocksdb_root_dir --UD\ 3\ --UD_ZALPHA\ 1 zipfian2   # workload 6: 50% insert, 50% update

# # run experiments on zipfian(1.2)
rocksdb_root_dir=/scratchNVM1/ranw/zipfian3
run_multiple_times_for_baseline 100 0 $num_workloads $rocksdb_root_dir --UD\ 3\ --UD_ZALPHA\ 1.2 zipfian3 & # workload 1: 100% insert, 0% update
sleep 60
run_multiple_times_for_baseline 90 10 $num_workloads $rocksdb_root_dir --UD\ 3\ --UD_ZALPHA\ 1.2 zipfian3 & # workload 2: 90% insert, 10% update
sleep 60
run_multiple_times_for_baseline 80 20 $num_workloads $rocksdb_root_dir --UD\ 3\ --UD_ZALPHA\ 1.2 zipfian3 & # workload 3: 80% insert, 20% update
sleep 60
run_multiple_times_for_baseline 70 30 $num_workloads $rocksdb_root_dir --UD\ 3\ --UD_ZALPHA\ 1.2 zipfian3 & # workload 4: 70% insert, 30% update
sleep 60
run_multiple_times_for_baseline 60 40 $num_workloads $rocksdb_root_dir --UD\ 3\ --UD_ZALPHA\ 1.2 zipfian3 & # workload 5: 60% insert, 40% update
sleep 60
run_multiple_times_for_baseline 50 50 $num_workloads $rocksdb_root_dir --UD\ 3\ --UD_ZALPHA\ 1.2 zipfian3   # workload 6: 50% insert, 50% update

# run experiments on normal(0.5, 0.5)
rocksdb_root_dir=/scratchNVM1/ranw/normal1
run_multiple_times_for_baseline 100 0 $num_workloads $rocksdb_root_dir --UD\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.5 normal1 & # workload 1: 100% insert, 0% update
sleep 60
run_multiple_times_for_baseline 90 10 $num_workloads $rocksdb_root_dir --UD\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.5 normal1 & # workload 2: 90% insert, 10% update
sleep 60
run_multiple_times_for_baseline 80 20 $num_workloads $rocksdb_root_dir --UD\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.5 normal1 & # workload 3: 80% insert, 20% update
sleep 60
run_multiple_times_for_baseline 70 30 $num_workloads $rocksdb_root_dir --UD\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.5 normal1 & # workload 4: 70% insert, 30% update
sleep 60
run_multiple_times_for_baseline 60 40 $num_workloads $rocksdb_root_dir --UD\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.5 normal1 & # workload 5: 60% insert, 40% update
sleep 60
run_multiple_times_for_baseline 50 50 $num_workloads $rocksdb_root_dir --UD\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.5 normal1   # workload 6: 50% insert, 50% update

# # run experiments on normal(0.5, 1)
rocksdb_root_dir=/scratchNVM1/ranw/normal2
run_multiple_times_for_baseline 100 0 $num_workloads $rocksdb_root_dir --UD\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 1 normal2 & # workload 1: 100% insert, 0% update
sleep 60
run_multiple_times_for_baseline 90 10 $num_workloads $rocksdb_root_dir --UD\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 1 normal2 & # workload 2: 90% insert, 10% update
sleep 60
run_multiple_times_for_baseline 80 20 $num_workloads $rocksdb_root_dir --UD\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 1 normal2 & # workload 3: 80% insert, 20% update
sleep 60
run_multiple_times_for_baseline 70 30 $num_workloads $rocksdb_root_dir --UD\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 1 normal2 & # workload 4: 70% insert, 30% update
sleep 60
run_multiple_times_for_baseline 60 40 $num_workloads $rocksdb_root_dir --UD\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 1 normal2 & # workload 5: 60% insert, 40% update
sleep 60
run_multiple_times_for_baseline 50 50 $num_workloads $rocksdb_root_dir --UD\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 1 normal2   # workload 6: 50% insert, 50% update

# # run experiments on normal(0.5, 2)
rocksdb_root_dir=/scratchNVM1/ranw/normal3
run_multiple_times_for_baseline 100 0 $num_workloads $rocksdb_root_dir --UD\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 2 normal3 & # workload 1: 100% insert, 0% update
sleep 60
run_multiple_times_for_baseline 90 10 $num_workloads $rocksdb_root_dir --UD\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 2 normal3 & # workload 2: 90% insert, 10% update
sleep 60
run_multiple_times_for_baseline 80 20 $num_workloads $rocksdb_root_dir --UD\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 2 normal3 & # workload 3: 80% insert, 20% update
sleep 60
run_multiple_times_for_baseline 70 30 $num_workloads $rocksdb_root_dir --UD\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 2 normal3 & # workload 4: 70% insert, 30% update
sleep 60
run_multiple_times_for_baseline 60 40 $num_workloads $rocksdb_root_dir --UD\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 2 normal3 & # workload 5: 60% insert, 40% update
sleep 60
run_multiple_times_for_baseline 50 50 $num_workloads $rocksdb_root_dir --UD\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 2 normal3   # workload 6: 50% insert, 50% update
