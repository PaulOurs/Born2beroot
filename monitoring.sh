#!/bin/bash
wall "
Architecture: $(uname -m)
Kernel version: $(uname -r)
Physical processors: $(nproc --all)
Virtual processors: $(nproc)
RAM usage: $(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')
Disk usage: $(df -h / | awk 'NR==2 {print $5}')
CPU load: $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
Last reboot: $(who -b | awk '{print $3, $4}')
LVM use: $(if [ $(lsblk | grep lvm | wc -l) -gt 0 ]; then echo yes; else echo no; fi)
Active connections: $(netstat -t | grep ESTABLISHED | wc -l)
Users logged in: $(who | wc -l)
IPv4: $(hostname -I | awk '{print $1}')
MAC: $(ip link show | awk '/ether/ {print $2}')
Sudo commands: $(journalctl _COMM=sudo | grep COMMAND | wc -l)
"
