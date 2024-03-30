#!/bin/bash

source ./scripts/tools.sh
source ./scripts/run_workload.sh

if ! [ $# -eq 6 ]; then
    echo 'in this shell script, there will be eleven parameters, which are:'
    echo '1. the path to save the experiments result'
    echo '2. the number of times to run kEnumerate for each workload'
    echo '3. the path of rocksdb'
    echo '4. the path of the experiment workspace'
    echo '5. the workload path'
    echo '6. the number of all inserted bytes'
    exit 1
fi

# check whether workload.txt exists
if [ ! -e $5 ]; then
    echo "workload does not exist"
    exit -1
fi

if [ ! -d $1 ]; then
    mkdir -p $1
fi

# initialize the workspace
initialize_workspace $4

run_all_baselines $6 $3 $4 $5

run_enumerate $2 $6 $3 $4 $5

# copy the experiment result to a given folder
mv $4 $1
