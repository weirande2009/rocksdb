#!/bin/bash

source ./scripts/tools.sh
source ./scripts/run_workload.sh

if ! [ $# -eq 4 ]; then
    echo 'in this shell script, there will be seven parameters, which are:'
    echo '1. the path to save the experiments result'
    echo '2. the number of times to run kEnumerate'
    echo '3. the path of rocksdb'
    echo '4. the path of the experiment workspace'
    exit 1
fi

# check whether the workload.txt files exists in the workspace
# if [ ! -d $4/workload.txt ]; then
#     echo $4/workload.txt 'does not exist'
#     exit -1
# fi

enumerate_a_workload 0 0 0 $1 $2 $3 $4
