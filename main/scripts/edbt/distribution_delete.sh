# Experiment on 2 good baseline policies with different update distribution
# workloads settings: 8 bytes key size, 64 bytes entry size, 2000000 operations
# update proportion: 10%, 20%, 30%, 40%, 50%
# update distribution: zipfian(0.8), zipfian(1.0), zipfian(1.2), normal(0.5, 1), normal(0.5, 0.5), normal(0.5, 2)
# For each type of workload, we run 10 times.
# There will be 6 plots, each plot contains 5 lines, each line represents 
# Each line contains the min, max, mean, and median, 25% and 75% quantile of the 10 runs

source ./scripts/run_workload.sh

run_multiple_times_for_baseline() {
    if ! [ $# -eq 7 ]; then
        echo 'get the number of parameters:' $#
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

    percentage_insert=$1
    percentage_update=$2
    percentage_delete=$3
    n_workloads=$4
    rocksdb_root_dir=$5
    distribution=$6
    experiment_name=compare_distribution/5gb/first_run/$7
    workspace_root_dir=workspace/edbt
    workload_root_dir=workloads/edbt

    write_buffer_size=$((64 * 1024 * 1024))
    target_file_size_base=$((64 * 1024 * 1024))
    target_file_number=4

    entry_size=1024
    num_operation=$((5 * 1024 * 1024))

    num_insert=$((num_operation * percentage_insert / 100))
    num_update=$((num_operation * percentage_update / 100))
    num_delete=$((num_operation * percentage_delete / 100))
    workload_size=$(((num_insert + num_update) * entry_size))
    dir_name=$experiment_name/${percentage_insert}_${percentage_update}_${percentage_delete}
    workload_dir=$workload_root_dir/$dir_name
    workspace_dir=$workspace_root_dir/$dir_name
    mkdir -p $workload_dir
    mkdir -p $workspace_dir
    
    rocksdb_dir=$rocksdb_root_dir/${percentage_insert}_${percentage_update}_${percentage_delete}
    mkdir -p $rocksdb_dir

    for i in $(seq 1 $n_workloads)
    do  
        ./load_gen --output_path $workload_dir/${i}.txt -I $num_insert -U $num_update -D $num_delete -E $entry_size -K 8 $distribution
        initialize_workspace $workspace_dir/run$i
        run_all_baselines $workload_size $rocksdb_dir $workspace_dir/run$i $workload_dir/${i}.txt $write_buffer_size $target_file_size_base $target_file_number
        rm $workload_dir/${i}.txt
    done

    rm -rf $rocksdb_dir
}

insert_distribution() {
    num_workloads=10

    # run experiments on normal(0.5, 0.5)
    rocksdb_root_dir=/scratchNVM1/ranw/insert/normal1
    run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.5 insert_normal1 &
    run_multiple_times_for_baseline 80 14 6 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.5 insert_normal1 &
    run_multiple_times_for_baseline 80 18 2 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.5 insert_normal1 &
    run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.5 insert_normal1 &

    # # run experiments on normal(0.5, 1)
    rocksdb_root_dir=/scratchNVM1/ranw/insert/normal2
    run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 1 insert_normal2 &
    run_multiple_times_for_baseline 80 14 6 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 1 insert_normal2 & 
    run_multiple_times_for_baseline 80 18 2 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 1 insert_normal2 
    run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 1 insert_normal2 &

    # # run experiments on normal(0.5, 2)
    rocksdb_root_dir=/scratchNVM1/ranw/insert/normal3
    run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 2 insert_normal3 &
    run_multiple_times_for_baseline 80 14 6 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 2 insert_normal3 & 
    run_multiple_times_for_baseline 80 18 2 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 2 insert_normal3 &
    run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 2 insert_normal3 &

    # run experiments on normal(0.5, 0.01)
    rocksdb_root_dir=/scratchNVM1/ranw/insert/normal4
    run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.01 insert_normal4 &
    run_multiple_times_for_baseline 80 14 6 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.01 insert_normal4 & 
    run_multiple_times_for_baseline 80 18 2 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.01 insert_normal4 
    run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.01 insert_normal4 &

    # # run experiments on normal(0.5, 0.05)
    rocksdb_root_dir=/scratchNVM1/ranw/insert/normal5
    run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.05 insert_normal5 &
    run_multiple_times_for_baseline 80 14 6 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.05 insert_normal5 & 
    run_multiple_times_for_baseline 80 18 2 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.05 insert_normal5 &
    run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.05 insert_normal5 &

    wait $(jobs -p)

    # # run experiments on normal(0.5, 0.1)
    rocksdb_root_dir=/scratchNVM1/ranw/insert/normal6
    run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.1 insert_normal6 &
    run_multiple_times_for_baseline 80 14 6 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.1 insert_normal6 & 
    run_multiple_times_for_baseline 80 18 2 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.1 insert_normal6 
    run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir --ID\ 1\ --ID_NMP\ 0.5\ --ID_NDEV\ 0.1 insert_normal6 &
}

update_distribution() {
    num_workloads=10

    # run experiments on normal(0.5, 0.5)
    rocksdb_root_dir=/scratchNVM1/ranw/update/normal1
    run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 0.5 update_normal1 &
    run_multiple_times_for_baseline 80 14 6 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 0.5 update_normal1 &
    run_multiple_times_for_baseline 80 18 2 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 0.5 update_normal1 &
    run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 0.5 update_normal1 &

    # # run experiments on normal(0.5, 1)
    rocksdb_root_dir=/scratchNVM1/ranw/update/normal2
    run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 1 update_normal2 &
    run_multiple_times_for_baseline 80 14 6 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 1 update_normal2 & 
    run_multiple_times_for_baseline 80 18 2 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 1 update_normal2   
    run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 1 update_normal2 &

    # # run experiments on normal(0.5, 2)
    rocksdb_root_dir=/scratchNVM1/ranw/update/normal3
    run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 2 update_normal3 &
    run_multiple_times_for_baseline 80 14 6 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 2 update_normal3 & 
    run_multiple_times_for_baseline 80 18 2 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 2 update_normal3 &
    run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 2 update_normal3 &

    # run experiments on normal(0.5, 0.01)
    rocksdb_root_dir=/scratchNVM1/ranw/update/normal4
    run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 0.01 update_normal4 &
    run_multiple_times_for_baseline 80 14 6 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 0.01 update_normal4 & 
    run_multiple_times_for_baseline 80 18 2 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 0.01 update_normal4   
    run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 0.01 update_normal4 &

    # run experiments on normal(0.5, 0.05)
    rocksdb_root_dir=/scratchNVM1/ranw/update/normal5
    run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 0.05 update_normal5 &
    run_multiple_times_for_baseline 80 14 6 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 0.05 update_normal5 & 
    run_multiple_times_for_baseline 80 18 2 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 0.05 update_normal5 &
    run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 0.05 update_normal5 &

    wait $(jobs -p)

    # run experiments on normal(0.5, 0.1)
    rocksdb_root_dir=/scratchNVM1/ranw/update/normal6
    run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 0.1 update_normal6 &
    run_multiple_times_for_baseline 80 14 6 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 0.1 update_normal6 & 
    run_multiple_times_for_baseline 80 18 2 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 0.1 update_normal6   
    run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir --UD\ 1\ --UD_NMP\ 0.5\ --UD_NDEV\ 0.1 update_normal6 &
}

both_distribution() {
    num_workloads=10

    rocksdb_root_dir=/scratchNVM1/ranw/uniform
    run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir --ID\ 0 uniform &
    run_multiple_times_for_baseline 80 14 6 $num_workloads $rocksdb_root_dir --ID\ 0 uniform &
    run_multiple_times_for_baseline 80 18 2 $num_workloads $rocksdb_root_dir --ID\ 0 uniform 
    run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir --ID\ 0 uniform &

    rocksdb_root_dir=/scratchNVM1/ranw/both/normal
    run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir --ID\ 1\ --UD\ 1 both_normal &
    run_multiple_times_for_baseline 80 14 6 $num_workloads $rocksdb_root_dir --ID\ 1\ --UD\ 1 both_normal &
    run_multiple_times_for_baseline 80 18 2 $num_workloads $rocksdb_root_dir --ID\ 1\ --UD\ 1 both_normal &
    run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir --ID\ 1\ --UD\ 1 both_normal &

    rocksdb_root_dir=/scratchNVM1/ranw/both/beta
    run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir --ID\ 2\ --UD\ 2 both_beta &
    run_multiple_times_for_baseline 80 14 6 $num_workloads $rocksdb_root_dir --ID\ 2\ --UD\ 2 both_beta &
    run_multiple_times_for_baseline 80 18 2 $num_workloads $rocksdb_root_dir --ID\ 2\ --UD\ 2 both_beta  
    run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir --ID\ 2\ --UD\ 2 both_beta &
}

different_insert_update_delete_proportion() {
    num_workloads=10

    rocksdb_root_dir=/scratchNVM1/ranw/proportion
    experiment_name=proportion
    run_multiple_times_for_baseline 100 0 0 $num_workloads $rocksdb_root_dir --ID\ 0 $experiment_name &
    run_multiple_times_for_baseline 90 10 0 $num_workloads $rocksdb_root_dir --ID\ 0 $experiment_name &
    run_multiple_times_for_baseline 80 20 0 $num_workloads $rocksdb_root_dir --ID\ 0 $experiment_name &
    run_multiple_times_for_baseline 70 30 0 $num_workloads $rocksdb_root_dir --ID\ 0 $experiment_name &
    run_multiple_times_for_baseline 60 40 0 $num_workloads $rocksdb_root_dir --ID\ 0 $experiment_name &

    wait $(jobs -p)

    run_multiple_times_for_baseline 50 50 0 $num_workloads $rocksdb_root_dir --ID\ 0 $experiment_name &
    run_multiple_times_for_baseline 40 60 0 $num_workloads $rocksdb_root_dir --ID\ 0 $experiment_name &
    run_multiple_times_for_baseline 30 70 0 $num_workloads $rocksdb_root_dir --ID\ 0 $experiment_name &
    run_multiple_times_for_baseline 20 80 0 $num_workloads $rocksdb_root_dir --ID\ 0 $experiment_name &
    run_multiple_times_for_baseline 10 90 0 $num_workloads $rocksdb_root_dir --ID\ 0 $experiment_name &

    wait $(jobs -p)

    run_multiple_times_for_baseline 80 10 10 $num_workloads $rocksdb_root_dir --ID\ 0 $experiment_name &
    run_multiple_times_for_baseline 80 12 8 $num_workloads $rocksdb_root_dir --ID\ 0 $experiment_name &
    run_multiple_times_for_baseline 80 14 6 $num_workloads $rocksdb_root_dir --ID\ 0 $experiment_name &
    run_multiple_times_for_baseline 80 16 4 $num_workloads $rocksdb_root_dir --ID\ 0 $experiment_name &
    run_multiple_times_for_baseline 80 18 2 $num_workloads $rocksdb_root_dir --ID\ 0 $experiment_name &

    wait $(jobs -p)
}

# different_insert_update_delete_proportion
insert_distribution
update_distribution
both_distribution
