# db_path=/scratchNVM1/ranw/duration
db_path=mnt/rocksdb
mkdir -p $db_path
echo '--------------------------------5GB----------------------------------'
entry_size=1024
num_operation=$((5 * 1024 * 1024))
workload_size=$((num_operation * entry_size))
percentage_insert=50
percentage_update=50
percentage_delete=0
num_insert=$((num_operation * percentage_insert / 100))
num_update=$((num_operation * percentage_update / 100))
total_bytes=$((num_operation * entry_size))
write_buffer_size=$((64 * 1024 * 1024))
target_file_size_base=$((64 * 1024 * 1024))
target_file_number=4

echo 'generate workload'
time ./load_gen --output_path workloads/1.txt -I $num_insert -U $num_update -D $percentage_delete -E $entry_size -K 8
echo 'run workload'
time ./scripts/run_once_existing.sh mnt/rocksdb/ experiment_duration kMinOverlappingRatio $total_bytes workloads/1.txt $write_buffer_size $target_file_size_base $target_file_number
rm -rf workloads/1.txt
rm -rf experiment_duration

echo '--------------------------------5M2K----------------------------------'
entry_size=$((1024 * 2))
num_operation=$((5 * 1024 * 1024))
workload_size=$((num_operation * entry_size))
percentage_insert=50
percentage_update=50
percentage_delete=0
num_insert=$((num_operation * percentage_insert / 100))
num_update=$((num_operation * percentage_update / 100))
total_bytes=$((num_operation * entry_size))
write_buffer_size=$((64 * 1024 * 1024))
target_file_size_base=$((64 * 1024 * 1024))
target_file_number=4

echo 'generate workload'
time ./load_gen --output_path workloads/1.txt -I $num_insert -U $num_update -D $percentage_delete -E $entry_size -K 8
echo 'run workload'
time ./scripts/run_once_existing.sh mnt/rocksdb/ experiment_duration kMinOverlappingRatio $total_bytes workloads/1.txt $write_buffer_size $target_file_size_base $target_file_number
rm -rf workloads/1.txt

echo '--------------------------------5M4K----------------------------------'
entry_size=$((1024 * 4))
num_operation=$((5 * 1024 * 1024))
workload_size=$((num_operation * entry_size))
percentage_insert=50
percentage_update=50
percentage_delete=0
num_insert=$((num_operation * percentage_insert / 100))
num_update=$((num_operation * percentage_update / 100))
total_bytes=$((num_operation * entry_size))
write_buffer_size=$((64 * 1024 * 1024))
target_file_size_base=$((64 * 1024 * 1024))
target_file_number=4

echo 'generate workload'
time ./load_gen --output_path workloads/1.txt -I $num_insert -U $num_update -D $percentage_delete -E $entry_size -K 8
echo 'run workload'
time ./scripts/run_once_existing.sh mnt/rocksdb/ experiment_duration kMinOverlappingRatio $total_bytes workloads/1.txt $write_buffer_size $target_file_size_base $target_file_number
rm -rf workloads/1.txt

echo '--------------------------------5M8K----------------------------------'
entry_size=$((1024 * 8))
num_operation=$((5 * 1024 * 1024))
workload_size=$((num_operation * entry_size))
percentage_insert=50
percentage_update=50
percentage_delete=0
num_insert=$((num_operation * percentage_insert / 100))
num_update=$((num_operation * percentage_update / 100))
total_bytes=$((num_operation * entry_size))
write_buffer_size=$((64 * 1024 * 1024))
target_file_size_base=$((64 * 1024 * 1024))
target_file_number=4

echo 'generate workload'
time ./load_gen --output_path workloads/1.txt -I $num_insert -U $num_update -D $percentage_delete -E $entry_size -K 8
echo 'run workload'
time ./scripts/run_once_existing.sh mnt/rocksdb/ experiment_duration kMinOverlappingRatio $total_bytes workloads/1.txt $write_buffer_size $target_file_size_base $target_file_number
rm -rf workloads/1.txt

echo '--------------------------------10M1K----------------------------------'
entry_size=$((1024))
num_operation=$((10 * 1024 * 1024))
workload_size=$((num_operation * entry_size))
percentage_insert=50
percentage_update=50
percentage_delete=0
num_insert=$((num_operation * percentage_insert / 100))
num_update=$((num_operation * percentage_update / 100))
total_bytes=$((num_operation * entry_size))
write_buffer_size=$((64 * 1024 * 1024))
target_file_size_base=$((64 * 1024 * 1024))
target_file_number=4

echo 'generate workload'
time ./load_gen --output_path workloads/1.txt -I $num_insert -U $num_update -D $percentage_delete -E $entry_size -K 8
echo 'run workload'
time ./scripts/run_once_existing.sh mnt/rocksdb/ experiment_duration kMinOverlappingRatio $total_bytes workloads/1.txt $write_buffer_size $target_file_size_base $target_file_number
rm -rf workloads/1.txt

echo '--------------------------------20M1K----------------------------------'
entry_size=$((1024))
num_operation=$((20 * 1024 * 1024))
workload_size=$((num_operation * entry_size))
percentage_insert=50
percentage_update=50
percentage_delete=0
num_insert=$((num_operation * percentage_insert / 100))
num_update=$((num_operation * percentage_update / 100))
total_bytes=$((num_operation * entry_size))
write_buffer_size=$((64 * 1024 * 1024))
target_file_size_base=$((64 * 1024 * 1024))
target_file_number=4

echo 'generate workload'
time ./load_gen --output_path workloads/1.txt -I $num_insert -U $num_update -D $percentage_delete -E $entry_size -K 8
echo 'run workload'
time ./scripts/run_once_existing.sh mnt/rocksdb/ experiment_duration kMinOverlappingRatio $total_bytes workloads/1.txt $write_buffer_size $target_file_size_base $target_file_number
rm -rf workloads/1.txt

echo '--------------------------------40M1K----------------------------------'
entry_size=$((1024))
num_operation=$((40 * 1024 * 1024))
workload_size=$((num_operation * entry_size))
percentage_insert=50
percentage_update=50
percentage_delete=0
num_insert=$((num_operation * percentage_insert / 100))
num_update=$((num_operation * percentage_update / 100))
total_bytes=$((num_operation * entry_size))
write_buffer_size=$((64 * 1024 * 1024))
target_file_size_base=$((64 * 1024 * 1024))
target_file_number=4

echo 'generate workload'
time ./load_gen --output_path workloads/1.txt -I $num_insert -U $num_update -D $percentage_delete -E $entry_size -K 8
echo 'run workload'
time ./scripts/run_once_existing.sh mnt/rocksdb/ experiment_duration kMinOverlappingRatio $total_bytes workloads/1.txt $write_buffer_size $target_file_size_base $target_file_number
rm -rf workloads/1.txt
