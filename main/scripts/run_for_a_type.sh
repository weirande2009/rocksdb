#!/bin/bash

source ./scripts/tools.sh
source ./scripts/run_workload.sh

if ! [ $# -eq 8 ]; then
    echo 'in this shell script, there will be nine parameters, which are:'
    echo '1. the number of inserts in the workload'
    echo '2. the number of updates in the workload'
    echo '3. the number of deletes in the workload'
    echo '4. the path to save the experiments result'
    echo '5. the number of times to run kEnumerate for each workload'
    echo '6. the number of different workloads'
    echo '7. the path of rocksdb'
    echo '8. the path of the experiment workspace'
    exit 1
fi

# check workload
if [ $1 -eq 0 ] && [ $2 -eq 0 ] && [ $3 -eq 0 ]; then
    echo "Insert, update and delete can\'t be all 0!"
    exit 1
fi

# make a directory according to the workload pattern + time
new_dir_path=`date +"%Y-%m-%d-%H:%M:%S"`+$1I+$2U+$3D
if [ ! -d $4 ]; then
    mkdir $4
fi
mkdir $4/$new_dir_path

# run different workload
for i in $(seq 1 $6)
do
    echo 'workload' $i
    enumerate_a_workload $1 $2 $3 $4/$new_dir_path $5 $7 $8$i
done
