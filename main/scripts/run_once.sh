#!/bin/bash

source ./scripts/run_workload.sh

if ! [ $# -eq 9 ]; then
    echo 'in this shell script, there will be eight parameters, which are:'
    echo '1. the number of inserts in the workload'
    echo '2. the number of updates in the workload'
    echo '3. the number of deletes in the workload'
    echo '4. the path of rocksdb'
    echo '5. the path of the experiment workspace'
    echo '6. running method (kRoundRobin, kMinOverlappingRatio, kEnumerateAll, kManual, kTwoStepsSearch, kSelectLastSimilar)'
    echo '7. the workload entry size'
    echo '8. whether to use the extra parameter for workload generation'
    echo '9. the extra parameter for workload generation'
    exit 1
fi

# create workspace
if [ ! -d $5 ]; then
    mkdir $5
fi

# if to use the extra parameter for workload generation
if [ $8 -eq 1 ]; then
    echo 'workload generating'
    ./load_gen -E $7 -I $1 -U $2 -D $3 --DIR $5 $9 > $5/out.txt
fi

# initialize the workspace
initialize_workspace $1 $2 $3 $5 $7

# Run count_workload to compute the number of bytes that will be inserted to database
# and write the result into file "workload_count.txt"
./count_workload $5 > $5/out.txt
# The file contains one lines: "total_written_bytes=xxx". After reading, there will be a 
# variable $total_written_bytes
# Read the file line by line
while IFS='=' read -r key value; do
  # Set the variable based on the key-value pair
  eval "$key=$value"
done < $5/"workload_count.txt" 

# run once
run_once $total_written_bytes $4 $5 $6
