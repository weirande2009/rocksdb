#!/bin/bash

run_once() {
    if ! [ $# -eq 10 ]; then
        echo 'in this function, there will be three parameters, which are:'
        echo '1. the number of all inserted bytes'
        echo '2. the path of the rocksdb'
        echo '3. the path of the experiment'
        echo '4. the running method (kRoundRobin, kMinOverlappingRatio, kEnumerateAll)'
        echo '5. the workload path'
        echo '6. write buffer size'
        echo '7. target file size base'
        echo '8. max bytes for level base' 
        echo '9. write buffer data structure'
        echo '10. max bytes for level multiplier'
        exit 1
    fi
    find $2 -mindepth 1 -delete
    ./simple_example $4 $1 $2 $3 $5 0 0 $6 $7 $8 $9 ${10}
    cp $2/LOG $3/LOG_$4
    rocksdb_size=$(du -sk $2 | awk '{ printf "%dK\n", $1 }')
    echo "$4: $rocksdb_size" >> $3/rocksdb_size.txt
}

run_baseline() {
    if ! [ $# -eq 7 ]; then
        echo 'in this shell script, there will be three parameters, which are:'
        echo '1. the number of all inserted bytes'
        echo '2. the path of the rocksdb'
        echo '3. the path of the experiment log'
        echo '4. the workload path'
        echo '5. write buffer size'
        echo '6. target file size base'
        echo '7. target file number' 
        exit 1
    fi
    find $2 -mindepth 1 -delete
    ./simple_example kRoundRobin $1 $2 $3 $4 0 0 $5 $6 $7

    find $2 -mindepth 1 -delete
    ./simple_example kMinOverlappingRatio $1 $2 $3 $4 0 0 $5 $6 $7
}

run_all_baselines() {
    if ! [ $# -eq 7 ]; then
        echo 'in this shell script, there will be three parameters, which are:'
        echo '1. the number of all inserted bytes'
        echo '2. the path of the rocksdb'
        echo '3. the path of the experiment workspace'
        echo '4. the workload path'
        echo '5. write buffer size'
        echo '6. target file size base'
        echo '7. target file number' 
        exit 1
    fi
    find $2 -mindepth 1 -delete
    ./simple_example kRoundRobin $1 $2 $3 $4 0 0 $5 $6 $7
    cp $2/LOG $3/LOG_RR
    rocksdb_size=$(du -sk $2 | awk '{ printf "%dK\n", $1 }')
    echo "kRoundRobin: $rocksdb_size" >> $3/rocksdb_size.txt

    find $2 -mindepth 1 -delete
    ./simple_example kMinOverlappingRatio $1 $2 $3 $4 0 0 $5 $6 $7
    cp $2/LOG $3/LOG_MOR
    rocksdb_size=$(du -sk $2 | awk '{ printf "%dK\n", $1 }')
    echo "kMinOverlappingRatio: $rocksdb_size" >> $3/rocksdb_size.txt

    find $2 -mindepth 1 -delete
    ./simple_example kOldestLargestSeqFirst $1 $2 $3 $4 0 0 $5 $6 $7
    cp $2/LOG $3/LOG_OLSF
    rocksdb_size=$(du -sk $2 | awk '{ printf "%dK\n", $1 }')
    echo "kOldestLargestSeqFirst: $rocksdb_size" >> $3/rocksdb_size.txt

    find $2 -mindepth 1 -delete
    ./simple_example kOldestSmallestSeqFirst $1 $2 $3 $4 0 0 $5 $6 $7
    cp $2/LOG $3/LOG_OSSF
    rocksdb_size=$(du -sk $2 | awk '{ printf "%dK\n", $1 }')
    echo "kOldestSmallestSeqFirst: $rocksdb_size" >> $3/rocksdb_size.txt

    find $2 -mindepth 1 -delete
    ./simple_example kSelectLastSimilar $1 $2 $3 $4 0 0 $5 $6 $7
    cp $2/LOG $3/LOG_SLS
    rocksdb_size=$(du -sk $2 | awk '{ printf "%dK\n", $1 }')
    echo "kSelectLastSimilar: $rocksdb_size" >> $3/rocksdb_size.txt
}

run_all_baselines_2() {
    if ! [ $# -eq 8 ]; then
        echo 'in this shell script, there will be three parameters, which are:'
        echo '1. the number of all inserted bytes'
        echo '2. the path of the rocksdb'
        echo '3. the path of the experiment workspace'
        echo '4. the workload path'
        echo '5. write buffer size'
        echo '6. target file size base'
        echo '7. target file number' 
        echo '8. write buffer data structure'
        exit 1
    fi
    find $2 -mindepth 1 -delete
    ./simple_example kRoundRobin $1 $2 $3 $4 0 0 $5 $6 $7 $8
    cp $2/LOG $3/LOG_RR
    rocksdb_size=$(du -sk $2 | awk '{ printf "%dK\n", $1 }')
    echo "kRoundRobin: $rocksdb_size" >> $3/rocksdb_size.txt

    find $2 -mindepth 1 -delete
    ./simple_example kMinOverlappingRatio $1 $2 $3 $4 0 0 $5 $6 $7 $8
    cp $2/LOG $3/LOG_MOR
    rocksdb_size=$(du -sk $2 | awk '{ printf "%dK\n", $1 }')
    echo "kMinOverlappingRatio: $rocksdb_size" >> $3/rocksdb_size.txt

    find $2 -mindepth 1 -delete
    ./simple_example kOldestLargestSeqFirst $1 $2 $3 $4 0 0 $5 $6 $7 $8
    cp $2/LOG $3/LOG_OLSF
    rocksdb_size=$(du -sk $2 | awk '{ printf "%dK\n", $1 }')
    echo "kOldestLargestSeqFirst: $rocksdb_size" >> $3/rocksdb_size.txt

    find $2 -mindepth 1 -delete
    ./simple_example kOldestSmallestSeqFirst $1 $2 $3 $4 0 0 $5 $6 $7 $8
    cp $2/LOG $3/LOG_OSSF
    rocksdb_size=$(du -sk $2 | awk '{ printf "%dK\n", $1 }')
    echo "kOldestSmallestSeqFirst: $rocksdb_size" >> $3/rocksdb_size.txt

    find $2 -mindepth 1 -delete
    ./simple_example kSelectLastSimilar $1 $2 $3 $4 0 0 $5 $6 $7 $8
    cp $2/LOG $3/LOG_SLS
    rocksdb_size=$(du -sk $2 | awk '{ printf "%dK\n", $1 }')
    echo "kSelectLastSimilar: $rocksdb_size" >> $3/rocksdb_size.txt
}

run_all_baselines_3() {
    if ! [ $# -eq 9 ]; then
        echo 'in this shell script, there will be three parameters, which are:'
        echo '1. the number of all inserted bytes'
        echo '2. the path of the rocksdb'
        echo '3. the path of the experiment workspace'
        echo '4. the workload path'
        echo '5. write buffer size'
        echo '6. target file size base'
        echo '7. max bytes for level base' 
        echo '8. write buffer data structure'
        echo '9. max bytes for level multiplier'
        exit 1
    fi
    find $2 -mindepth 1 -delete
    ./simple_example kRoundRobin $1 $2 $3 $4 0 0 $5 $6 $7 $8 $9
    cp $2/LOG $3/LOG_RR
    rocksdb_size=$(du -sk $2 | awk '{ printf "%dK\n", $1 }')
    echo "kRoundRobin: $rocksdb_size" >> $3/rocksdb_size.txt

    find $2 -mindepth 1 -delete
    ./simple_example kMinOverlappingRatio $1 $2 $3 $4 0 0 $5 $6 $7 $8 $9
    cp $2/LOG $3/LOG_MOR
    rocksdb_size=$(du -sk $2 | awk '{ printf "%dK\n", $1 }')
    echo "kMinOverlappingRatio: $rocksdb_size" >> $3/rocksdb_size.txt

    find $2 -mindepth 1 -delete
    ./simple_example kOldestLargestSeqFirst $1 $2 $3 $4 0 0 $5 $6 $7 $8 $9
    cp $2/LOG $3/LOG_OLSF
    rocksdb_size=$(du -sk $2 | awk '{ printf "%dK\n", $1 }')
    echo "kOldestLargestSeqFirst: $rocksdb_size" >> $3/rocksdb_size.txt

    find $2 -mindepth 1 -delete
    ./simple_example kOldestSmallestSeqFirst $1 $2 $3 $4 0 0 $5 $6 $7 $8 $9
    cp $2/LOG $3/LOG_OSSF
    rocksdb_size=$(du -sk $2 | awk '{ printf "%dK\n", $1 }')
    echo "kOldestSmallestSeqFirst: $rocksdb_size" >> $3/rocksdb_size.txt
}

run_all_baselines_4() {
    if ! [ $# -eq 8 ]; then
        echo 'in this shell script, there will be three parameters, which are:'
        echo '1. the number of all inserted bytes'
        echo '2. the path of the rocksdb'
        echo '3. the path of the experiment workspace'
        echo '4. the workload path'
        echo '5. write buffer size'
        echo '6. target file size base'
        echo '7. target file number' 
        echo '8. write buffer data structure'
        echo '9. max bytes for level multiplier'
        exit 1
    fi
    find $2 -mindepth 1 -delete
    ./simple_example kMinOverlappingRatio $1 $2 $3 $4 0 0 $5 $6 $7 $8
    cp $2/LOG $3/LOG_MOR
    rocksdb_size=$(du -sk $2 | awk '{ printf "%dK\n", $1 }')
    echo "kMinOverlappingRatio: $rocksdb_size" >> $3/rocksdb_size.txt

    find $2 -mindepth 1 -delete
    ./simple_example kSelectLastSimilar $1 $2 $3 $4 0 0 $5 $6 $7 $8
    cp $2/LOG $3/LOG_SLS
    rocksdb_size=$(du -sk $2 | awk '{ printf "%dK\n", $1 }')
    echo "kSelectLastSimilar: $rocksdb_size" >> $3/rocksdb_size.txt
}

run_enumerate() {
    if ! [ $# -eq 10 ]; then
        echo 'in this shell script, there will be six parameters, which are:'
        echo '1. the number of runs'
        echo '2. the number of all inserted bytes'
        echo '3. the path of the rocksdb'
        echo '4. the path of the experiment workspace'
        echo '5. the workload path'
        echo '6. whether to skip trivial move'
        echo '7. whether to skip extend non-l0 trivial move'
        echo '8. write buffer size'
        echo '9. target file size base'
        echo '10. target file number' 
        exit 1
    fi
    for i in $(seq 1 $1)
    do
        echo 'run' $i
        find $3 -mindepth 1 -delete
        ./simple_example_backup kEnumerateAll $2 $3 $4 $5 $6 $7 $8 $9 ${10}

        # check whether to stop
        ./check_finish_enumeration $4

        # check whether over exists
        if [ -e $4/over ]; then
            echo 'Stop enumerating'
            rm $4/over
            break
        fi
        # sleep 0.1
    done

    echo 'Finish all runs'
}

initialize_workspace() {
    if ! [ $# -eq 1 ]; then
        echo 'in this shell script, there will be five parameters, which are:'
        echo '1. the path of the experiment workspace'
        exit 1
    fi

    if [ ! -d $1 ]; then
        mkdir $1
    fi
    if [ ! -d $1/history ]; then
        mkdir $1/history
        echo -e 'Number of nodes\n0' > $1/history/picking_history_level0
        echo -e 'Number of nodes\n0' > $1/history/picking_history_level1
    fi

    if [ ! -d $1/minimum.txt ]; then
        echo '18446744073709551615 0' > $1/minimum.txt
    fi

    if [ ! -d $1/log.txt ]; then
        touch $1/log.txt
    fi

    if [ ! -d $1/rocksdb_size.txt ]; then
        touch $1/rocksdb_size.txt
    fi

    if [ ! -d $1/version_info.txt ]; then
        touch $1/version_info.txt
    fi

    if [ ! -d $1/out.txt ]; then
        touch $1/out.txt
    fi
}
