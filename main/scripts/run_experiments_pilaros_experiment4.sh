# Experiment with different workloads
# workloads settings: 8 bytes key size fixed
# operation number: 4m, 8m, 16m (64 bytes entry size)
# entry size: 128 bytes, 256 bytes, 512 bytes (2m operations)
# workload distribution: pick some workloads is ok
# update distribution: zipfian(0.8), zipfian(1.0), zipfian(1.2), normal(0.5, 1), normal(0.25, 1), normal(0.75, 1)
# For each type of workload, we run 10 times.
# There will be 6 plots, each plot contains 5 lines, each line represents 
# use some policies
# Each line contains the min, max, mean, and median, 25% and 75% quantile of the 10 runs

