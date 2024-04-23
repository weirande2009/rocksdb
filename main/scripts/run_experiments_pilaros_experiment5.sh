# Experiment on 4 baseline policies and the optimal policy, but with delete
# workloads settings: 8 bytes key size, 64 bytes entry size, 2000000 operations
# workload 1: 80% insert, 10% update, 10% delete
# workload 2: 80% insert, 12% update, 8% delete
# workload 3: 80% insert, 14% update, 6% delete
# workload 4: 80% insert, 16% update, 4% delete
# workload 5: 80% insert, 18% update, 2% delete
# workload 6: 80% insert, 20% update, 0% delete
# For each type of workload, we run 10 times.
# There will be 5 plots, each plot contains 5 lines, each line represents a policy
# Each line contains the min, max, mean, and median, 25% and 75% quantile of the 10 runs
