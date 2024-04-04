# Experiment on 2 good baseline policies with different update distribution
# workloads settings: 8 bytes key size, 64 bytes entry size, 2000000 operations
# update proportion: 10%, 20%, 30%, 40%, 50%
# update distribution: zipfian(0.8), zipfian(1.0), zipfian(1.2), normal(0.5, 1), normal(0.5, 0.5), normal(0.5, 2)
# For each type of workload, we run 10 times.
# There will be 6 plots, each plot contains 5 lines, each line represents 
# Each line contains the min, max, mean, and median, 25% and 75% quantile of the 10 runs

