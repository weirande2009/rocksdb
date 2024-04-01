workload_dir=workloads/stability_checking/2000000_0_0_64_8_nvm1/concurrent_6
mkdir -p $workload_dir
# ./load_gen --output_path $workload_dir/1.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
total_bytes=$((2000000 * 64))

workspace_dir=workspace/stability_checking/2000000_0_0_64_8_nvm1/concurrent_6
mkdir -p $workspace_dir

# for i in {1..5}
# do
#     ./scripts/run_for_a_type.sh 500 /scratchNVM1/ranw/rocksdb$i/ $workspace_dir/run$i $workload_dir/1.txt $total_bytes 0 &
# done
./scripts/run_for_a_type.sh 10 /scratchNVM1/ranw/rocksdb6/ $workspace_dir/run7 $workload_dir/1.txt $total_bytes 0

echo 'Finished running 6 experiments in parallel'

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
