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
workload_dir=workloads/test/2000000_0_0_64_0125
mkdir -p $workload_dir
./load_gen --output_path $workload_dir/1.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
total_bytes=128000000

./run_once_existing.sh /scratchNVM1/ranw/rocksdb1/ experiment1 kMinOverlappingRatio $total_bytes workloads/1.txt &
./run_once_existing.sh /scratchNVM1/ranw/rocksdb2/ experiment2 kMinOverlappingRatio $total_bytes workloads/1.txt &
./run_once_existing.sh /scratchNVM1/ranw/rocksdb3/ experiment3 kMinOverlappingRatio $total_bytes workloads/1.txt &
./run_once_existing.sh /scratchNVM1/ranw/rocksdb4/ experiment3 kMinOverlappingRatio $total_bytes workloads/1.txt

