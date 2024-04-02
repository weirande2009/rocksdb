# workload_dir=workloads/stability_checking/2000000_0_0_64_8_memory_nvm1/concurrent_12
# mkdir -p $workload_dir
# ./load_gen --output_path $workload_dir/1.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
# total_bytes=$((2000000 * 64))

# workspace_dir=workspace/stability_checking/2000000_0_0_64_8_memory_nvm1/concurrent_12
# mkdir -p $workspace_dir

# enumeration_runs=300
# rocksdb_dir=/mnt/ramd/ranw
# for i in {1..6}
# do
#     ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb$i/ $workspace_dir/run$i $workload_dir/1.txt $total_bytes 0 &
# done

# rocksdb_dir=/scratchNVM1/ranw
# for i in {7..11}
# do
#     ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb$i/ $workspace_dir/run$i $workload_dir/1.txt $total_bytes 0 &
# done
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb12/ $workspace_dir/run12 $workload_dir/1.txt $total_bytes 0

# echo 'Finished running 6 experiments in parallel'

# workload_dir=workloads/stability_checking/2000000_0_0_64_8_nvm1_memory
# mkdir -p $workload_dir
# ./load_gen --output_path $workload_dir/1.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
# total_bytes=$((2000000 * 64))

# workspace_dir_nvm1=workspace/stability_checking/2000000_0_0_64_8_nvm1_memory/memory/concurrent_3
# workspace_dir_memory=workspace/stability_checking/2000000_0_0_64_8_nvm1_memory/memory/concurrent_3
# mkdir -p $workspace_dir_nvm1
# mkdir -p $workspace_dir_memory

# enumeration_runs=300
# ./scripts/run_for_a_type.sh $enumeration_runs /scratchNVM1/ranw/rocksdb1/ $workspace_dir_nvm1/run1 $2000000_0_0_64_8_nvm1_memory/1.txt $total_bytes 0 &
# ./scripts/run_for_a_type.sh $enumeration_runs /scratchNVM1/ranw/rocksdb2/ $workspace_dir_nvm1/run2 $2000000_0_0_64_8_nvm1_memory/1.txt $total_bytes 0 &
# ./scripts/run_for_a_type.sh $enumeration_runs /scratchNVM1/ranw/rocksdb3/ $workspace_dir_nvm1/run3 $2000000_0_0_64_8_nvm1_memory/1.txt $total_bytes 0 &

# ./scripts/run_for_a_type.sh $enumeration_runs /mnt/ramd/ranw/rocksdb1/ $workspace_dir_memory/run1 $2000000_0_0_64_8_nvm1_memory/1.txt $total_bytes 0 &
# ./scripts/run_for_a_type.sh $enumeration_runs /mnt/ramd/ranw/rocksdb2/ $workspace_dir_memory/run2 $2000000_0_0_64_8_nvm1_memory/1.txt $total_bytes 0 &
# ./scripts/run_for_a_type.sh $enumeration_runs /mnt/ramd/ranw/rocksdb3/ $workspace_dir_memory/run3 $2000000_0_0_64_8_nvm1_memory/1.txt $total_bytes 0 &

# echo 'Finished running 6 experiments in parallel'

# workload_dir_test_skip=workloads/consistency_checking/2000000_0_0_64_8_memory/test_both_test_concurrent_3_test_skip
# workspace_dir_non_skip=workspace/consistency_checking/2000000_0_0_64_8_memory/test_both_test_concurrent_3_test_skip/non_skip
# workspace_dir_skip=workspace/consistency_checking/2000000_0_0_64_8_memory/test_both_test_concurrent_3_test_skip/skip
# mkdir -p $workload_dir_test_skip
# mkdir -p $workspace_dir_non_skip
# mkdir -p $workspace_dir_skip
# ./load_gen --output_path $workload_dir_test_skip/type1.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
# ./load_gen --output_path $workload_dir_test_skip/type2.txt -I 1500000 -U 500000 -D 0 -E 64 -K 8
# ./load_gen --output_path $workload_dir_test_skip/type3.txt -I 1000000 -U 1000000 -D 0 -E 64 -K 8
# total_bytes=$((2000000 * 64))

# enumeration_runs=100
# rocksdb_dir=/mnt/ramd/ranw
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb1/ $workspace_dir_non_skip/run1 $workload_dir_test_skip/type1.txt $total_bytes 0 &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb2/ $workspace_dir_non_skip/run2 $workload_dir_test_skip/type2.txt $total_bytes 0 &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb3/ $workspace_dir_non_skip/run3 $workload_dir_test_skip/type3.txt $total_bytes 0

# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb4/ $workspace_dir_skip/run1 $workload_dir_test_skip/type1.txt $total_bytes 1 &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb5/ $workspace_dir_skip/run2 $workload_dir_test_skip/type2.txt $total_bytes 1 &
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb6/ $workspace_dir_skip/run3 $workload_dir_test_skip/type3.txt $total_bytes 1 &

# workload_dir=workloads/stability_checking/2000000_0_0_64_8_memory_nvm1_test_speed/concurrent_12
# mkdir -p $workload_dir
# ./load_gen --output_path $workload_dir/1.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
# total_bytes=$((2000000 * 64))

# workspace_dir=workspace/stability_checking/2000000_0_0_64_8_memory_nvm1_test_speed/concurrent_12
# mkdir -p $workspace_dir

# enumeration_runs=300
# rocksdb_dir=/mnt/ramd/ranw
# for i in {1..6}
# do
#     ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb$i/ $workspace_dir/run$i $workload_dir/1.txt $total_bytes 0 &
# done

# rocksdb_dir=/scratchNVM1/ranw
# for i in {7..11}
# do
#     ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb$i/ $workspace_dir/run$i $workload_dir/1.txt $total_bytes 0 &
# done
# ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb12/ $workspace_dir/run12 $workload_dir/1.txt $total_bytes 0

# workload_dir=workloads/stability_checking/2000000_0_0_64_8_nvm1_test_enumeration/old/concurrent_6
# mkdir -p $workload_dir
# ./load_gen --output_path $workload_dir/1.txt -I 8000000 -U 0 -D 0 -E 8 -K 4
# total_bytes=$((8000000 * 8))

# workspace_dir=workspace/stability_checking/2000000_0_0_64_8_nvm1_test_enumeration/old/concurrent_6
# mkdir -p $workspace_dir

# enumeration_runs=800
# rocksdb_dir=/scratchNVM1/ranw
# for i in {1..3}
# do
#     ./scripts/run_for_a_type.sh $enumeration_runs $rocksdb_dir/rocksdb$i/ $workspace_dir/run$i $workload_dir/1.txt $total_bytes 0 &
# done

./load_gen --output_path workloads/1.txt -I 8000000 -U 0 -D 0 -E 8 -K 4
total_bytes=$((8000000 * 8))
./scripts/run_for_a_type.sh 800 /scratchNVM1/ranw/rocksdb/ experiment_non_skip workloads/1.txt $total_bytes 0
