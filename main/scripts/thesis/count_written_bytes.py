import regex as re

def count(filename):
    f = open(filename, 'r')
    lines = f.readlines()
    written_bytes = 0
    for line in lines:
        # match this "[/flush_job.cc:1018] [default] [JOB 2] Level-0 flush table #9: 446708 bytes OK", I want to get "446708"
        match = re.search(r'Level-0 flush table #\d+: (\d+) bytes OK', line)
        if match:
            print("flush:", match.group(1))
            written_bytes += int(match.group(1))
            continue
        
        # match this "[/compaction/compaction_job.cc:1748] [default] [JOB 6] Compacted 4@0 files to L1 => 1698603 bytes", I want to get "1698603"
        # I want to find a line with "[/compaction/compaction_job.cc:1748] [default]" and then fine "=> (\d+) bytes"
        # match = re.search(r'[/compaction/compaction_job.cc:1748] [default] => (\d+) bytes', line)
        match = re.search(r'\[\/compaction\/compaction_job\.cc:1748\] \[default\] .*=> (\d+) bytes', line)
        if match:
            print("compaction:", match.group(1))
            written_bytes += int(match.group(1))
    print("Total written bytes:", written_bytes)

count("/Users/weiran/BU/Thesis/rocksdb/main/mnt/rocksdb/LOG")
