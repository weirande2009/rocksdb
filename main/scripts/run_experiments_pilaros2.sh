workload_dir=workloads/stability_checking/2000000_0_0_64_8_nvm1/concurrent_6
mkdir -p $workload_dir
./load_gen --output_path $workload_dir/1.txt -I 2000000 -U 0 -D 0 -E 64 -K 8
total_bytes=$((2000000 * 64))

workspace_dir=workspace/stability_checking/2000000_0_0_64_8_nvm1/concurrent_6
mkdir -p $workspace_dir

for i in {1..5}
do
    ./scripts/run_for_a_type.sh 500 /scratchNVM1/ranw/rocksdb$i/ $workspace_dir/run$i $workload_dir/1.txt $total_bytes &
done
./scripts/run_for_a_type.sh 500 /scratchNVM1/ranw/rocksdb6/ $workspace_dir/run6 $workload_dir/1.txt $total_bytes

echo 'Finished running 6 experiments in parallel'
