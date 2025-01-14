#!/bin/bash


echo "Total CPU usage"
top -bn1 | grep "Cpu(s)" | \
           sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
           awk '{print 100 - $1"%"}'
echo "######################"
echo "Total memory usage (Free vs Used including percentage)"
free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3, $2, $3*100/$2 }'

echo "######################"
echo "Total disk usage (Free vs Used including percentage)"
df -h --total | awk '$1 == "total" {printf "Disk Usage: %s/%s (%s used)\n", $3, $2, $5}'

echo "######################"
echo "Top 5 processes by CPU usage"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

echo "######################"
echo "Top 5 processes by Memory usage"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6

echo "######################"
echo "Server Statistics"
echo "================="
echo "OS Version: $(uname -a)"
echo "Uptime: $(uptime -p)"
echo "Load Average: $(uptime | awk '{print $10 $11 $12}')"
echo "Logged In Users:"
who
echo "Failed Login Attempts:"
grep "Failed password" /var/log/auth.log
