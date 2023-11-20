#!/bin/bash

run_once() {
    if ! [ $# -eq 4 ]; then
        echo 'in this function, there will be three parameters, which are:'
        echo '1. the number of all inserted bytes'
        echo '2. the path of the rocksdb'
        echo '3. the path of the experiment'
        echo '4. the running method (kRoundRobin, kMinOverlappingRatio, kEnumerateAll, kManual)'
        exit 1
    fi
    find $2 -mindepth 1 -delete
    ./simple_example $4 $1 $2 $3
}

run_baseline() {
    if ! [ $# -eq 3 ]; then
        echo 'in this shell script, there will be three parameters, which are:'
        echo '1. the number of all inserted bytes'
        echo '2. the path of the rocksdb'
        echo '3. the path of the experiment log'
        exit 1
    fi
    find $2 -mindepth 1 -delete
    ./simple_example kRoundRobin $1 $2 $3

    find $2 -mindepth 1 -delete
    ./simple_example kMinOverlappingRatio $1 $2 $3
}

run_enumerate() {
    if ! [ $# -eq 4 ]; then
        echo 'in this shell script, there will be four parameters, which are:'
        echo '1. the number of runs'
        echo '2. the number of all inserted bytes'
        echo '3. the path of the rocksdb'
        echo '4. the path of the experiment log'
        exit 1
    fi
    for i in $(seq 1 $1)
    do
        echo 'run' $i
        find $3 -mindepth 1 -delete
        ./simple_example kEnumerateAll $2 $3 $4

        # check whether to stop
        ./check_finish_enumeration $4

        # check whether over exists
        if [ -e $4/over ]; then
            echo 'Stop enumerating'
            rm $4/over
            break
        fi
    done

    echo 'Finish all runs'
}

initialize_workspace() {
    if ! [ $# -eq 4 ]; then
        echo 'in this shell script, there will be seven parameters, which are:'
        echo '1. the number of inserted in the workload'
        echo '2. the number of updates in the workload'
        echo '3. the number of deletes in the workload'
        echo '4. the path of the experiment workspace'
        exit 1
    fi

    if [ ! -d $4 ]; then
        mkdir $4
    fi
    if [ ! -d $4/history ]; then
        mkdir $4/history
        echo -e 'Number of nodes\n0' > $4/history/picking_history_level0
        echo -e 'Number of nodes\n0' > $4/history/picking_history_level1
    fi

    if [ ! -d $4/minimum.txt ]; then
        echo '18446744073709551615 0' > $4/minimum.txt
    fi

    if [ ! -d $4/log.txt ]; then
        touch $4/log.txt
    fi

    if [ ! -d $4/version_info.txt ]; then
        touch $4/version_info.txt
    fi

    if [ ! -d $4/out.txt ]; then
        touch $4/out.txt
    fi

    # generate workload, if there is already a workload, don't generate a new one
    if [ ! -e $4/workload.txt ]; then
        ./load_gen -I $1 -U $2 -D $3 --DIR $4 > $4/out.txt
    fi

    # check whether workload.txt exists
    if [ ! -e $4/workload.txt ]; then
        echo "workload.txt does not exist"
        exit -1
    fi
}

enumerate_a_workload() {
    if ! [ $# -eq 7 ]; then
        echo 'in this shell script, there will be seven parameters, which are:'
        echo '1. the number of inserted in the workload'
        echo '2. the number of updates in the workload'
        echo '3. the number of deletes in the workload'
        echo '4. the path to save the experiments result'
        echo '5. the number of times to run kEnumerate'
        echo '6. the path of rocksdb'
        echo '7. the path of the experiment workspace'
        exit 1
    fi

    # initialize the workspace
    initialize_workspace $1 $2 $3 $7

    # Run count_workload to compute the number of bytes that will be inserted to database
    # and write the result into file "workload_count.txt"
    ./count_workload $7 > $7/out.txt

    # The file contains one lines: "total_written_bytes=xxx". After reading, there will be a 
    # variable $total_written_bytes
    # Read the file line by line
    while IFS='=' read -r key value; do
      # Set the variable based on the key-value pair
      eval "$key=$value"
    done < $7/"workload_count.txt" 

    # run baseline
    run_baseline $total_written_bytes $6 $7

    # run enumeration
    run_enumerate $5 $total_written_bytes $6 $7

    # copy the experiment result to a given folder
    if [ ! -d $4 ]; then
        mkdir $4
    fi
    mv $7 $4
}


