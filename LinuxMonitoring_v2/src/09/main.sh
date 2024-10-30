#!/bin/bash
file="/home/student/DO4_LinuxMonitoring_v2.0-1/src/09/metrics/index.html"
# while true; do

    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
    ram_usage=$(free -m | grep -i mem | awk '{print$3}')
    storage_usage=$(df -m | grep /$ | awk '{print$2}')
    # cat index.html

    echo "# HELP my_cpu_usage CPU usage percent." > $file
    echo "# TYPE my_cpu_usage gauge" >> $file
    echo "my_cpu_usage ${cpu_usage%\%*}" >> $file
    echo "# HELP my_ram_usage RAM usage." >> $file
    echo "# TYPE my_ram_usage gauge" >> $file
    echo "my_ram_usage  $ram_usage" >> $file
    echo "# HELP my_storage_usage Storage usage percent." >> $file
    echo "# TYPE my_storage_usage gauge" >> $file
    echo "my_storage_usage ${storage_usage%\%*}" >> $file

#     sleep 3s
# done
