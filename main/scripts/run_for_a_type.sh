#!/bin/bash

source ./scripts/run_workload.sh

if ! [ $# -eq 12 ]; then
    echo $#
    echo $1
    echo $2
    echo $3
    echo $4
    echo $6
    echo $7
    echo $8
    echo $9
    echo ${10}
    echo ${11}
    echo ${12}
    echo ${13}
    echo 'in this shell script, there will be six parameters, which are: got'
    echo '1. the number of times to run kEnumerate for each workload'
    echo '2. the path of rocksdb'
    echo '3. the path of the experiment workspace'
    echo '4. the workload path'
    echo '5. the number of all inserted bytes'
    echo '6. whether to skip trivial move'
    echo '7. whether to skip extend non-l0 trivial move'
    echo '8. write buffer size'
    echo '9. target file size base'
    echo '10. max bytes for level base' 
    echo '11. write buffer data structure'
    echo '12. max bytes for level multiplier'
    exit 1
fi

# check whether workload.txt exists
if [ ! -e $4 ]; then
    echo "workload does not exist"
    exit -1
fi

# initialize the workspace
initialize_workspace $3

run_all_baselines $5 $2 $3 $4 $8 $9 ${10} ${11} ${12}

time run_enumerate $1 $5 $2 $3 $4 $6 $7 $8 $9 ${10} ${11} ${12} > $3/out.txt
