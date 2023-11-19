#!/bin/bash

source ./scripts/tools.sh
source ./scripts/run_workload.sh

if ! [ $# -eq 8 ]; then
    echo 'in this shell script, there will be seven parameters, which are:'
    echo '1. the number of inserts in the workload'
    echo '2. the number of updates in the workload'
    echo '3. the number of deletes in the workload'
    echo '4. the path to save the experiments result'
    echo '5. the number of times to run kEnumerate for each workload'
    echo '6. the number of processes'
    echo '7. the default path of rocksdb'
    echo '8. the default path of the experiment workspace'
    exit 1
fi

default_rocksdb_path=$7
default_experiment_log_path=$8

# make directories and workloads first
for i in $(seq 1 $6)
do
    mkdir $default_experiment_log_path$i
    ./load_gen -I $1 -U $2 -D $3 --DIR $default_experiment_log_path$i > $default_experiment_log_path$i/out.txt
done

# make a directory according to the workload pattern + time
new_dir_path=`date +"%Y-%m-%d-%H:%M:%S"`+$1I+$2U+$3D
if [ ! -d $4 ]; then
    mkdir $4
fi
mkdir $4/$new_dir_path

for i in $(seq 1 $6)
do
    # enumerate workload
    enumerate_a_workload $1 $2 $3 $4/$new_dir_path $5 $default_rocksdb_path$i $default_experiment_log_path$i > $default_experiment_log_path$i/out.txt &
done

