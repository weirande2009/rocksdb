workload_dir=workloads/test/2000000_0_0_64_0125
./load_gen --output_path $workload_dir/1.txt -I 2000000 -U 0 -D 0 -E 64 -L 0.125
./load_gen --output_path $workload_dir/2.txt -I 2000000 -U 0 -D 0 -E 64 -L 0.125
./load_gen --output_path $workload_dir/3.txt -I 2000000 -U 0 -D 0 -E 64 -L 0.125
./load_gen --output_path $workload_dir/4.txt -I 2000000 -U 0 -D 0 -E 64 -L 0.125
total_bytes=128000000

# test speed of nvm0 and memory by running run_once
echo 'memory test'
time ./scripts/run_once_existing.sh mnt/rocksdb/ experiment_memory kMinOverlappingRatio $total_bytes $workload_dir/1.txt
echo 'nvm test'
time ./scripts/run_once_existing.sh mnt/rocksdb/ experiment_nvm kMinOverlappingRatio $total_bytes $workload_dir/1.txt

# test concurrent runs' consistency in memory
# ./run_once_existing.sh mnt/rocksdb/ experiment1 kMinOverlappingRatio $total_bytes workloads/1.txt &
# ./run_once_existing.sh mnt/rocksdb/ experiment2 kMinOverlappingRatio $total_bytes workloads/1.txt &
# ./run_once_existing.sh mnt/rocksdb/ experiment3 kMinOverlappingRatio $total_bytes workloads/1.txt &
# ./run_once_existing.sh mnt/rocksdb/ experiment3 kMinOverlappingRatio $total_bytes workloads/1.txt

