# Experiment on 4 baseline policies and the optimal policy
# workloads settings: 8 bytes key size, 64 bytes entry size, 2000000 operations
# workload 1: 100% insert, 0% update
# workload 2: 90% insert, 10% update
# workload 3: 80% insert, 20% update
# workload 4: 70% insert, 30% update
# workload 5: 60% insert, 40% update
# workload 6: 50% insert, 50% update
# For each type of workload, we run 10 times.
# There will be 6 plots, each plot contains 5 lines, each line represents a policy
# Each line contains the min, max, mean, and median, 25% and 75% quantile of the 10 runs

# Expected result:
# 1. optimal policy is the best
# 2. kRoundRobin are stable and good
# 3. kMinOverlappingRatio are not stable, but generally good
# 4. kOldestLargestSeqFirst and kOldestSmallestSeqFirst are neither stable nor good