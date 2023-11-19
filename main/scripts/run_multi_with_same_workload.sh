#!/bin/bash

source ./scripts/tools.sh
source ./scripts/run_workload.sh

if ! [ $# -eq 6 ]; then
    echo 'in this shell script, there will be nine parameters, which are:'
    echo '1. the number of inserts in the workload'
    echo '2. the number of updates in the workload'
    echo '3. the number of deletes in the workload'
    echo '4. the path of rocksdb'
    echo '5. the path of the experiment workspace'
    echo '6. the number of times to run'
    exit 1
fi

source_dir=$5
if [ ! -d $source_dir ]; then
    mkdir $source_dir
fi
mkdir $source_dir/results

if [ ! -e $source_dir/workload.txt ]; then
    ./load_gen -I $1 -U $2 -D $3 --DIR $source_dir > $source_dir/out.txt
fi

for i in $(seq 1 $6)
do
    experiment_dir=$source_dir/tmp
    mkdir $experiment_dir
    cp $source_dir/workload.txt $experiment_dir/workload.txt

    ./scripts/run_once.sh $1 $2 $3 $4 $experiment_dir kMinOverlappingRatio

    cp $experiment_dir/minimum.txt $source_dir/results/minimum$i.txt
    cp $experiment_dir/log.txt $source_dir/results/log$i.txt
    rm -rf $experiment_dir
done
