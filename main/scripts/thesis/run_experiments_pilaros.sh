# # test speed of nvm and memory by running run_once
source ./scripts/run_workload.sh
# workload_dir=workloads/test/2000000_0_0_64_0125
# mkdir -p $workload_dir
# ./load_gen --output_path $workload_dir/1.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
# ./load_gen --output_path $workload_dir/2.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
# ./load_gen --output_path $workload_dir/3.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
# ./load_gen --output_path $workload_dir/4.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
# total_bytes=128000000

# echo 'memory test'
# time ./scripts/run_once_existing.sh /mnt/ramd/ranw/rocksdb/ experiment_memory kMinOverlappingRatio $total_bytes $workload_dir/1.txt
# echo 'nvm1 test'
# time ./scripts/run_once_existing.sh /scratchNVM1/ranw/rocksdb/ experiment_nvm kMinOverlappingRatio $total_bytes $workload_dir/1.txt
# echo 'nvm0 test'
# time ./scripts/run_once_existing.sh /scratchNVM0/ranw/rocksdb/ experiment_nvm0 kMinOverlappingRatio $total_bytes $workload_dir/1.txt
# echo 'hdd test'
# time ./scripts/run_once_existing.sh mnt/rocksdb/ experiment_nvm kMinOverlappingRatio $total_bytes $workload_dir/1.txt

# test result
# memory: 6.869s
# nvm1: 6.472s
# hdd: 9.863s

# test concurrent runs' consistency in memory
# workload_dir=workloads/test/2000000_0_0_64_0125
# mkdir -p $workload_dir
# ./load_gen --output_path $workload_dir/1.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
# total_bytes=$((2000000 * 64))

# workspace_dir=workspace/test/2000000_0_0_64_0125
# mkdir -p $workspace_dir

# ./scripts/run_once_existing.sh /mnt/ramd/ranw/rocksdb1/ $workspace_dir/experiment1 kMinOverlappingRatio $total_bytes $workload_dir/1.txt &
# ./scripts/run_once_existing.sh /mnt/ramd/ranw/rocksdb2/ $workspace_dir/experiment2 kMinOverlappingRatio $total_bytes $workload_dir/1.txt &
# ./scripts/run_once_existing.sh /mnt/ramd/ranw/rocksdb3/ $workspace_dir/experiment3 kMinOverlappingRatio $total_bytes $workload_dir/1.txt &
# ./scripts/run_once_existing.sh /mnt/ramd/ranw/rocksdb4/ $workspace_dir/experiment4 kMinOverlappingRatio $total_bytes $workload_dir/1.txt

# test concurrent enumeration runs' consistency in memory
# workload_dir=workloads/test/2000000_0_0_64_8
# mkdir -p $workload_dir
# ./load_gen --output_path $workload_dir/1.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
# total_bytes=$((2000000 * 64))

# workspace_dir=workspace/test/2000000_0_0_64_8
# mkdir -p $workspace_dir

# for i in {1..5}
# do
#     ./scripts/run_for_a_type.sh 360 /mnt/ramd/ranw/rocksdb$i/ $workspace_dir/experiment$i $workload_dir/1.txt $total_bytes &
# done

# echo 'Running 5 experiments in parallel'

# workload_dir=workloads/stability_checking/2000000_0_0_64_8_nvm0
# mkdir -p $workload_dir
# ./load_gen --output_path $workload_dir/1.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
# total_bytes=$((2000000 * 64))

# workspace_dir=workspace/stability_checking/2000000_0_0_64_8_nvm0
# mkdir -p $workspace_dir

# for i in {1..5}
# do
#     ./scripts/run_for_a_type.sh 360 /scratchNVM0/ranw/rocksdb$i/ $workspace_dir/experiment$i $workload_dir/1.txt $total_bytes &
# done

# echo 'Running 5 experiments in parallel'

# workload_dir=workloads/stability_checking/2500000_0_0_64_8_memory
# mkdir -p $workload_dir
# ./load_gen --output_path $workload_dir/1.txt -I 2500000 -U 0 -D 0 -E 64 -K 8
# total_bytes=$((2500000 * 64))

# workspace_dir=workspace/stability_checking/2500000_0_0_64_8_memory/concurrent_6
# mkdir -p $workspace_dir

# for i in {1..5}
# do
#     ./scripts/run_for_a_type.sh 360 /mnt/ramd/ranw/rocksdb$i/ $workspace_dir/run$i $workload_dir/1.txt $total_bytes &
# done
# ./scripts/run_for_a_type.sh 360 /mnt/ramd/ranw/rocksdb6/ $workspace_dir/run6 $workload_dir/1.txt $total_bytes

# echo 'Finished running 6 experiments in parallel'

# workspace_dir=workspace/stability_checking/2500000_0_0_64_8_memory/concurrent_5
# mkdir -p $workspace_dir

# for i in {1..4}
# do
#     ./scripts/run_for_a_type.sh 360 /mnt/ramd/ranw/rocksdb$i/ $workspace_dir/run$i $workload_dir/1.txt $total_bytes &
# done
# ./scripts/run_for_a_type.sh 360 /mnt/ramd/ranw/rocksdb5/ $workspace_dir/run5 $workload_dir/1.txt $total_bytes

# echo 'Finished running 5 experiments in parallel'

# workspace_dir=workspace/stability_checking/2500000_0_0_64_8_memory/concurrent_4
# mkdir -p $workspace_dir

# for i in {1..3}
# do
#     ./scripts/run_for_a_type.sh 360 /mnt/ramd/ranw/rocksdb$i/ $workspace_dir/run$i $workload_dir/1.txt $total_bytes &
# done
# ./scripts/run_for_a_type.sh 360 /mnt/ramd/ranw/rocksdb4/ $workspace_dir/run4 $workload_dir/1.txt $total_bytes

# echo 'Finished running 4 experiments in parallel'

# workspace_dir=workspace/stability_checking/2500000_0_0_64_8_memory/concurrent_3
# mkdir -p $workspace_dir

# for i in {1..2}
# do
#     ./scripts/run_for_a_type.sh 360 /mnt/ramd/ranw/rocksdb$i/ $workspace_dir/run$i $workload_dir/1.txt $total_bytes &
# done
# ./scripts/run_for_a_type.sh 360 /mnt/ramd/ranw/rocksdb3/ $workspace_dir/run3 $workload_dir/1.txt $total_bytes

# echo 'Finished running 3 experiments in parallel'

# workspace_dir=workspace/stability_checking/2500000_0_0_64_8_memory/concurrent_2
# mkdir -p $workspace_dir

# ./scripts/run_for_a_type.sh 360 /mnt/ramd/ranw/rocksdb1/ $workspace_dir/run1 $workload_dir/1.txt $total_bytes &
# ./scripts/run_for_a_type.sh 360 /mnt/ramd/ranw/rocksdb2/ $workspace_dir/run2 $workload_dir/1.txt $total_bytes

# echo 'Finished running 2 experiments in parallel'

# workload_dir=workloads/stability_checking/2500000_0_0_64_8_memory/series_3
# mkdir -p $workload_dir
# ./load_gen --output_path $workload_dir/1.txt -I 2500000 -U 0 -D 0 -E 64 -K 8
# total_bytes=$((2500000 * 64))

# workspace_dir=workspace/stability_checking/2500000_0_0_64_8_memory/series_3
# mkdir -p $workspace_dir

# for i in {1..3}
# do
#     ./scripts/run_for_a_type.sh 360 /mnt/ramd/ranw/rocksdb$i/ $workspace_dir/run$i $workload_dir/1.txt $total_bytes
# done

# echo 'Finished running 3 experiments in series'

# workload_dir=workloads/stability_checking/2500000_0_0_64_8_memory/complete_test_concurrent_3
# mkdir -p $workload_dir
# ./load_gen --output_path $workload_dir/1.txt -I 2500000 -U 0 -D 0 -E 64 -K 8
# ./load_gen --output_path $workload_dir/2.txt -I 2500000 -U 0 -D 0 -E 64 -K 8
# ./load_gen --output_path $workload_dir/3.txt -I 2500000 -U 0 -D 0 -E 64 -K 8
# total_bytes=$((2500000 * 64))

# workspace_dir=workspace/stability_checking/2500000_0_0_64_8_memory/complete_test_concurrent_3
# mkdir -p $workspace_dir

# for i in {1..2}
# do
#     ./scripts/run_for_a_type.sh 6000 /mnt/ramd/ranw/rocksdb$i/ $workspace_dir/run$i $workload_dir/$i.txt $total_bytes &
# done
# ./scripts/run_for_a_type.sh 6000 /mnt/ramd/ranw/rocksdb3/ $workspace_dir/run3 $workload_dir/3.txt $total_bytes

# echo 'Finished running 3 experiments in series'

# workload_dir_test_skip=workloads/consistency_checking/2000000_0_0_64_8_nvm/complete_test_concurrent_3_test_skip_again2
# workspace_dir_non_skip=workspace/consistency_checking/2000000_0_0_64_8_nvm/complete_test_concurrent_3_test_skip_again2/non_skip
# workspace_dir_skip=workspace/consistency_checking/2000000_0_0_64_8_nvm/complete_test_concurrent_3_test_skip_again2/skip
# mkdir -p $workload_dir_test_skip
# mkdir -p $workspace_dir_non_skip
# mkdir -p $workspace_dir_skip
# ./load_gen --output_path $workload_dir_test_skip/type1.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
# ./load_gen --output_path $workload_dir_test_skip/type2.txt -I 1500000 -U 500000 -D 0 -E 64 -K 8
# ./load_gen --output_path $workload_dir_test_skip/type3.txt -I 1000000 -U 1000000 -D 0 -E 64 -K 8
# total_bytes=$((2000000 * 64))

# enumeration_runs=4500
# rocksdb_dir=/scratchNVM1/ranw
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb1/ $workspace_dir_non_skip/run1 $workload_dir_test_skip/type1.txt $total_bytes 0 &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb2/ $workspace_dir_non_skip/run2 $workload_dir_test_skip/type2.txt $total_bytes 0 &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb3/ $workspace_dir_non_skip/run3 $workload_dir_test_skip/type3.txt $total_bytes 0 &

# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb4/ $workspace_dir_skip/run1 $workload_dir_test_skip/type1.txt $total_bytes 1 &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb5/ $workspace_dir_skip/run2 $workload_dir_test_skip/type2.txt $total_bytes 1 &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb6/ $workspace_dir_skip/run3 $workload_dir_test_skip/type3.txt $total_bytes 1 &

# workload_dir_test_skip=workloads/consistency_checking/2000000_0_0_64_8_real_memory/complete_test_concurrent_3_test_skip
# workspace_dir_non_skip=workspace/consistency_checking/2000000_0_0_64_8_real_memory/complete_test_concurrent_3_test_skip/non_skip
# workspace_dir_skip=workspace/consistency_checking/2000000_0_0_64_8_real_memory/complete_test_concurrent_3_test_skip/skip
# mkdir -p $workload_dir_test_skip
# mkdir -p $workspace_dir_non_skip
# mkdir -p $workspace_dir_skip
# ./load_gen --output_path $workload_dir_test_skip/type1.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
# ./load_gen --output_path $workload_dir_test_skip/type2.txt -I 1500000 -U 500000 -D 0 -E 64 -K 8
# ./load_gen --output_path $workload_dir_test_skip/type3.txt -I 1000000 -U 1000000 -D 0 -E 64 -K 8
# total_bytes=$((2000000 * 64))

# enumeration_runs=4000
# rocksdb_dir=/mnt/ramd/ranw
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb1/ $workspace_dir_non_skip/run1 $workload_dir_test_skip/type1.txt $total_bytes 0 &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb2/ $workspace_dir_non_skip/run2 $workload_dir_test_skip/type2.txt $total_bytes 0 &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb3/ $workspace_dir_non_skip/run3 $workload_dir_test_skip/type3.txt $total_bytes 0 &

# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb4/ $workspace_dir_skip/run1 $workload_dir_test_skip/type1.txt $total_bytes 1 &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb5/ $workspace_dir_skip/run2 $workload_dir_test_skip/type2.txt $total_bytes 1 &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb6/ $workspace_dir_skip/run3 $workload_dir_test_skip/type3.txt $total_bytes 1 &

# workload_dir_test_skip=workloads/consistency_checking/2000000_0_0_64_8_nvm/complete_test_concurrent_3_test_skip_again2
# workspace_dir_non_skip=workspace/consistency_checking/2000000_0_0_64_8_nvm/complete_test_concurrent_3_test_skip_again2/non_skip
# workspace_dir_skip=workspace/consistency_checking/2000000_0_0_64_8_nvm/complete_test_concurrent_3_test_skip_again2/skip
# mkdir -p $workload_dir_test_skip
# mkdir -p $workspace_dir_non_skip
# mkdir -p $workspace_dir_skip
# ./load_gen --output_path $workload_dir_test_skip/type4.txt -I 1600000 -U 400000 -D 0 -E 64 -K 8
# ./load_gen --output_path $workload_dir_test_skip/type5.txt -I 1400000 -U 600000 -D 0 -E 64 -K 8
# ./load_gen --output_path $workload_dir_test_skip/type6.txt -I 1200000 -U 800000 -D 0 -E 64 -K 8
# total_bytes=$((2000000 * 64))

# enumeration_runs=4500
# rocksdb_dir=/scratchNVM1/ranw
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb1/ $workspace_dir_non_skip/run4 $workload_dir_test_skip/type1.txt $total_bytes 0 &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb2/ $workspace_dir_non_skip/run5 $workload_dir_test_skip/type2.txt $total_bytes 0 &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb3/ $workspace_dir_non_skip/run6 $workload_dir_test_skip/type3.txt $total_bytes 0 &

# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb4/ $workspace_dir_skip/run4 $workload_dir_test_skip/type1.txt $total_bytes 1 &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb5/ $workspace_dir_skip/run5 $workload_dir_test_skip/type2.txt $total_bytes 1 &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb6/ $workspace_dir_skip/run6 $workload_dir_test_skip/type3.txt $total_bytes 1 &
entry_size=64
num_operation=2500000
workload_size=$((num_operation * entry_size))
percentage_insert=90
percentage_update=10
num_insert=$((num_operation * percentage_insert / 100))
num_update=$((num_operation * percentage_update / 100))
total_bytes=$((num_operation * entry_size))
write_buffer_size=$((8 * 1024 * 1024))
target_file_size_base=$((8 * 1024 * 1024))
target_file_number=4
thread=30
enumeration_runs=20

workload_base_dir=workload/edbt/compare_optimal_policies/test

workspace_dir=workspace/edbt/compare_optimal_policies/test
mkdir -p $workspace_dir
rocksdb_dir=/mnt/ramd/ranw/test
mkdir -p $rocksdb_dir

time ./load_gen --output_path $workload_base_dir/1.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8

for i in $(seq 1 $thread)
do  
    workload_dir=workload_base_dir/$i
    mkdir -p $workload_dir

    cp $workload_base_dir/1.txt $workload_dir/1.txt
    ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb$i/ $workspace_dir/run$i $workload_dir/1.txt $workload_size 1 1 $write_buffer_size $target_file_size_base $target_file_number &
done

wait $(jobs -p)
