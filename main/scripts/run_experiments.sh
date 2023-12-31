# 16 entry size and 4000000 operations
# various insert and update
./scripts/run_for_a_type.sh 4000000 0 0 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 3600000 400000 0 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 3200000 800000 0 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 2800000 1200000 0 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 2400000 1600000 0 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 2000000 2000000 0 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 1600000 2400000 0 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 1200000 2800000 0 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 800000 3200000 0 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 400000 3600000 0 tmp 800 1 mnt/rocksdb/ experiment 16
# various insert and delete
./scripts/run_for_a_type.sh 3600000 0 400000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 3200000 0 800000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 2800000 0 1200000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 2400000 0 1600000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 2000000 0 2000000 tmp 800 1 mnt/rocksdb/ experiment 16
# various insert, update and delete(400000)
./scripts/run_for_a_type.sh 3200000 400000 400000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 2800000 800000 400000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 2400000 1200000 400000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 2000000 1600000 400000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 1600000 2000000 400000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 1200000 2400000 400000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 800000 2800000 400000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 400000 3200000 400000 tmp 800 1 mnt/rocksdb/ experiment 16
# various insert, update and delete(800000)
./scripts/run_for_a_type.sh 2800000 400000 800000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 2400000 800000 800000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 2000000 1200000 800000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 1600000 1600000 800000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 1200000 2000000 800000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 800000 2400000 800000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 400000 2800000 800000 tmp 800 1 mnt/rocksdb/ experiment 16
# various insert, update and delete(1200000)
./scripts/run_for_a_type.sh 2400000 400000 1200000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 2000000 800000 1200000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 1600000 1200000 1200000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 1200000 1600000 1200000 tmp 800 1 mnt/rocksdb/ experiment 16
# various insert, update and delete(1600000)
./scripts/run_for_a_type.sh 2000000 400000 1600000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 1600000 800000 1600000 tmp 800 1 mnt/rocksdb/ experiment 16

# 16 entry size and 8000000 operations
# various insert and update
./scripts/run_for_a_type.sh 8000000 0 0 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 7200000 800000 0 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 6400000 1600000 0 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 5600000 2400000 0 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 4800000 3200000 0 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 4000000 4000000 0 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 3200000 4800000 0 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 2400000 5600000 0 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 1600000 6400000 0 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 800000 7200000 0 tmp 800 1 mnt/rocksdb/ experiment 16
# various insert and delete
./scripts/run_for_a_type.sh 7200000 0 800000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 6400000 0 1600000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 5600000 0 2400000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 4800000 0 3200000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 4000000 0 4000000 tmp 800 1 mnt/rocksdb/ experiment 16
# various insert, update and delete(800000)
./scripts/run_for_a_type.sh 6400000 800000 800000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 5600000 1600000 800000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 4800000 2400000 800000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 4000000 3200000 800000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 3200000 4000000 800000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 2400000 4800000 800000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 1600000 5600000 800000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 800000 6400000 800000 tmp 800 1 mnt/rocksdb/ experiment 16
# various insert, update and delete(1600000)
./scripts/run_for_a_type.sh 5600000 800000 1600000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 4800000 1600000 1600000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 4000000 2400000 1600000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 3200000 3200000 1600000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 2400000 4000000 1600000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 1600000 4800000 1600000 tmp 800 1 mnt/rocksdb/ experiment 16
# various insert, update and delete(2400000)
./scripts/run_for_a_type.sh 4800000 800000 2400000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 4000000 1600000 2400000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 3200000 2400000 2400000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 2400000 3200000 2400000 tmp 800 1 mnt/rocksdb/ experiment 16
# various insert, update and delete(3200000)
./scripts/run_for_a_type.sh 4000000 800000 3200000 tmp 800 1 mnt/rocksdb/ experiment 16
./scripts/run_for_a_type.sh 3200000 1600000 3200000 tmp 800 1 mnt/rocksdb/ experiment 16
