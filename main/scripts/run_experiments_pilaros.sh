# # test speed of nvm0 and memory by running run_once

# workload_dir=workloads/test/2000000_0_0_64_0125
# mkdir -p $workload_dir
# ./load_gen --output_path $workload_dir/1.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
# ./load_gen --output_path $workload_dir/2.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
# ./load_gen --output_path $workload_dir/3.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
# ./load_gen --output_path $workload_dir/4.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
# total_bytes=128000000

# echo 'memory test'
# time ./scripts/run_once_existing.sh /mnt/ramd/ranw/rocksdb/ experiment_memory kMinOverlappingRatio $total_bytes $workload_dir/1.txt
# echo 'nvm test'
# time ./scripts/run_once_existing.sh /scratchNVM1/ranw/rocksdb/ experiment_nvm kMinOverlappingRatio $total_bytes $workload_dir/1.txt
# echo 'hdd test'
# time ./scripts/run_once_existing.sh mnt/rocksdb/ experiment_nvm kMinOverlappingRatio $total_bytes $workload_dir/1.txt

# test result
# memory: 6.869s
# nvm: 6.472s
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

workload_dir=workloads/stability_checking/2000000_0_0_64_8_nvm0
mkdir -p $workload_dir
./load_gen --output_path $workload_dir/1.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
total_bytes=$((2000000 * 64))

workspace_dir=workspace/stability_checking/2000000_0_0_64_8_nvm0
mkdir -p $workspace_dir

for i in {1..5}
do
    ./scripts/run_for_a_type.sh 360 /scratchNVM0/ranw/rocksdb$i/ $workspace_dir/experiment$i $workload_dir/1.txt $total_bytes &
done

echo 'Running 5 experiments in parallel'
