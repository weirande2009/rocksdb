source ./scripts/run_workload.sh

entry_size=64
num_operation=2500000
workload_size=$((num_operation * entry_size))
percentage_insert=100
percentage_update=0
num_insert=$((num_operation * percentage_insert / 100))
num_update=$((num_operation * percentage_update / 100))
total_bytes=$((num_operation * entry_size))
write_buffer_size=$((8 * 1024 * 1024))
target_file_size_base=$((8 * 1024 * 1024))
target_file_number=4
write_buffer_data_structure=Vector
max_bytes_for_level_base_multiplier=4

# time ./load_gen --output_path workloads/1.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8

# time ./scripts/run_once_existing.sh mnt/rocksdb6/ experiment kRoundRobin $total_bytes workloads/1.txt $write_buffer_size $target_file_size_base $target_file_number $write_buffer_data_structure $max_bytes_for_level_base_multiplier

for k in {1..1}
do
    # echo $k
    # ./load_gen --output_path workloads/$k.txt -I $num_insert -U $num_update -D 0 -E $entry_size -K 8
    ./scripts/run_once_existing.sh mnt/rocksdb/ experiment/tmp kRoundRobin $total_bytes workloads/$k.txt $write_buffer_size $target_file_size_base $target_file_number $write_buffer_data_structure $max_bytes_for_level_base_multiplier
    # ./scripts/run_once_existing.sh mnt/rocksdb/ experiment/kRoundRobin/$k kRoundRobin $total_bytes workloads/$k.txt $write_buffer_size $target_file_size_base $target_file_number $write_buffer_data_structure $max_bytes_for_level_base_multiplier
    # ./scripts/run_once_existing.sh mnt/rocksdb/ experiment/kMinOverlappingRatio/$k kMinOverlappingRatio $total_bytes workloads/$k.txt $write_buffer_size $target_file_size_base $target_file_number $write_buffer_data_structure $max_bytes_for_level_base_multiplier
    # ./scripts/run_once_existing.sh mnt/rocksdb/ experiment/kOldestLargestSeqFirst/$k kOldestLargestSeqFirst $total_bytes workloads/$k.txt $write_buffer_size $target_file_size_base $target_file_number $write_buffer_data_structure $max_bytes_for_level_base_multiplier
    # ./scripts/run_once_existing.sh mnt/rocksdb/ experiment/kOldestSmallestSeqFirst/$k kOldestSmallestSeqFirst $total_bytes workloads/$k.txt $write_buffer_size $target_file_size_base $target_file_number $write_buffer_data_structure $max_bytes_for_level_base_multiplier
done