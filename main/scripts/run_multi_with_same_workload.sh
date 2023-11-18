source_dir=$1
if [ ! -d $source_dir ]; then
    mkdir $source_dir
fi
mkdir $source_dir/results

for i in $(seq 1 10)
do
    experiment_dir=$source_dir/tmp

    if [ ! -d $experiment_dir ]; then
        mkdir $experiment_dir
    fi
    if [ ! -d $experiment_dir/history ]; then
        mkdir $experiment_dir/history
    fi
    echo '18446744073709551615 0' > $experiment_dir/minimum.txt
    touch $experiment_dir/log.txt
    touch $experiment_dir/version_info.txt
    touch $experiment_dir/out.txt
    echo -e 'Number of nodes\n0' > $experiment_dir/history/picking_history_level0
    echo -e 'Number of nodes\n0' > $experiment_dir/history/picking_history_level1

    cp $source_dir/workload.txt $experiment_dir

    # check whether workload.txt exists
    if [ ! -e $experiment_dir/workload.txt ]; then
        echo "workload.txt does not exist"
        exit -1
    fi

    # Run count_workload to compute the number of bytes that will be inserted to database
    # and write the result into file "workload_count.txt"
    ./count_workload $experiment_dir > $experiment_dir/out.txt

    # The file contains one lines: "total_written_bytes=xxx". After reading, there will be a 
    # variable $total_written_bytes
    # Read the file line by line
    while IFS='=' read -r key value; do
      # Set the variable based on the key-value pair
      eval "$key=$value"
    done < $experiment_dir/"workload_count.txt" 

    find mnt/rocksdb/ -mindepth 1 -delete
    ./simple_example kMinOverlappingRatio $total_written_bytes  mnt/rocksdb/ $experiment_dir

    cp $experiment_dir/minimum.txt $source_dir/results/minimum$i.txt
    cp $experiment_dir/log.txt $source_dir/results/log$i.txt
    rm -rf $experiment_dir
done

