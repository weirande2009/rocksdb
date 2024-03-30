#!/bin/bash

source ./scripts/tools.sh
source ./scripts/run_workload.sh

if ! [ $# -eq 5 ]; then
    echo 'in this shell script, there will be five parameters, which are:'
    echo '1. the path of rocksdb'
    echo '2. the path of the experiment workspace'
    echo '3. running method (kRoundRobin, kMinOverlappingRatio, kEnumerateAll, kManual, kTwoStepsSearch, kSelectLastSimilar)'
    echo '4. the number of all inserted bytes'
    echo '5. the workload path'
    exit 1
fi

# initialize the workspace
initialize_workspace $2

# run once
run_once $4 $1 $2 $3 $5
