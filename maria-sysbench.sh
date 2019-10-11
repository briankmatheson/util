#!/bin/sh


host=$1
threads=$2
tables=$3
size=$4
time=$5

which mysql || apt -y install mysql
which sysbench || sudo apt -y install sysbench


mysql -h $host -u root --password=$MYSQL_ROOT_PASSWORD<<EOF
DROP DATABASE IF EXISTS sbtest;
CREATE DATABASE sbtest;
DROP USER IF EXISTS 'sbtest'@'%';
CREATE USER 'sbtest'@'%'
  IDENTIFIED BY 'sbtest';
GRANT ALL
  ON sbtest.*
  TO 'sbtest'@'%'
  WITH GRANT OPTION;
EOF

sysbench --report-interval=1 --tables=$tables --table-size=$size --mysql-host=$host --mysql-user=sbtest --mysql-password=sbtest --report-interval=1 --threads=$threads --time=$time --max-requests=0 --rand-type=uniform /usr/share/sysbench/oltp_read_write.lua prepare

sysbench --report-interval=1 --tables=$tables --table-size=$size  --mysql-host=$host --mysql-user=sbtest --mysql-password=sbtest --report-interval=1 --threads=$threads --time=$time --max-requests=0 --rand-type=uniform --validate=on --histogram=on /usr/share/sysbench/oltp_read_write.lua run

exit 0

# percona-mysql on openebs jiva / hd: [ 50s ] thds: 100 tps: 159.03 qps: 3709.61 (r/w/o: 2612.43/776.13/321.05) lat (ms,95%): 909.80 err/s: 0.00 reconn/s: 0.00
# percona-mysql on openebs localpv / nvme / qcow: [ 2s ] thds: 100 tps: 276.10 qps: 5350.94 (r/w/o: 3769.36/1030.37/551.20) lat (ms,95%): 893.56 err/s: 0.00 reconn/s: 0.00
# percona-mysql on openebs localpv / nvme / raw: [ 15s ] thds: 10 tps: 175.99 qps: 3624.73 (r/w/o: 2534.81/737.95/351.97) lat (ms,95%): 121.08 err/s: 0.00 reconn/s: 0.00
# percona-mysql on openebs cstor / hdd / qcow: [ 1s ] thds: 20 tps: 205.56 qps: 4392.63 (r/w/o: 3126.33/835.22/431.08) lat (ms,95%): 186.54 err/s: 0.00 reconn/s: 0.00
# aws rds mysql on gp ssd: [ 9s ] thds: 10 tps: 484.00 qps: 9715.00 (r/w/o: 6807.00/1940.00/968.00) lat (ms,95%): 26.20 err/s: 0.00 reconn/s: 0.00
