src=/scratchHDDb/ranw/workspace/edbt_revision/compare_workload_size/third_run/80_512_size/50_50
dst=/scratchHDDa/ranw/rocksdb/main/workspace/edbt_revision/compare_workload_size/third_run/80_512_size/50_50


mkdir -p $dst

n_workloads=20

for i in $(seq 1 $n_workloads)
do  
    mkdir $dst/run$i
    cp $src/run$i/result.txt $dst/run$i/
done
