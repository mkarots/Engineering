---
markmap:
    maxWidth: 300
---
# Benchmarking Database Hardware
## CPU and Memory benchmarking
### Memory
#### memtest86+: find intermittent errors on PC memory
#### STREAM memory testing: a memory bandwidth testing program
### CPU
### Physical disk performance
#### Random access and IOPS
##### Useful Metrics
###### Spindle Speed(RPM)
###### Average latency(ms): Waiting for the sector we want to read to show up under the read head(ms)
###### Random read seek time (ms): Seeking the right track on the disk
#### Sequential access and ZCAV
##### Disks spin at a constant angular velocity CAV, typical value 7200 RPM

# Hints & facts:
## Good way to measure CPU is to just do a CPU intensive task

## SATA transfer speeds:
### SATA I (1.5 Gb/s) was the first version, followed by
### SATA II (3 Gb/s)
### SATA III (6 Gb/s)

# Resources
## https://www.adservio.fr/post/postgresql-performance-best-practices
## https://www.enterprisedb.com/postgres-tutorials/introduction-postgresql-performance-tuning-and-optimization#baremetal
## https://github.com/MaxHalford/postgres-job-docker
## https://github.com/gregrahn/join-order-benchmark
