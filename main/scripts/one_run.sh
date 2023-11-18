if ! [ $# -eq 3 ]; then
    echo 'in this shell script, there will be three parameters, which are:'
    echo '1. the number of all inserted bytes'
    echo '2. the path of the rocksdb'
    echo '3. the path of the experiment'
    exit 1
fi
find $2 -mindepth 1 -delete
./simple_example kEnumerateAll $1 $2 $3
