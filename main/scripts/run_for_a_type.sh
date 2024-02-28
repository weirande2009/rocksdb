#!/bin/bash

source ./scripts/tools.sh
source ./scripts/run_workload.sh

if ! [ $# -eq 11 ]; then
    echo 'in this shell script, there will be eleven parameters, which are:'
    echo '1. the number of inserts in the workload'
    echo '2. the number of updates in the workload'
    echo '3. the number of deletes in the workload'
    echo '4. the path to save the experiments result'
    echo '5. the number of times to run kEnumerate for each workload'
    echo '6. the number of different workloads'
    echo '7. the path of rocksdb'
    echo '8. the path of the experiment workspace'
    echo '9. the workload entry size'
    echo '10. whether to use the extra parameter for workload generation'
    echo '11. the extra parameter for workload generation'
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
    # if to use the extra parameter for workload generation
    if [ ${10} -eq 1 ]; then
        echo 'workload' $i 'generating'
        if [ ! -d $8$i ]; then
            mkdir $8$i
        fi
        ./load_gen -E $9 -I $1 -U $2 -D $3 --DIR $8$i ${11} > $8$i/out.txt
    fi
    echo 'workload' $i 'generated'
    enumerate_a_workload $1 $2 $3 $4/$new_dir_path $5 $7 $8$i $9
done
