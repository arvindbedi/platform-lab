#!/usr/bin/env bash
set -euo pipefail

threshold=${1:-80}  # Default threshold is 80% if not provided as an argument
echo "Checking health of the system..."
echo "Disk usage:"
echo "----------------"
echo "$(df -h)"
echo "----------------"
echo "Disk usage by mount point:"
df -x tmpfs -x devtmpfs --output=pcent,target | tail -n +2 | while read -r pct target; do
usage=$(echo "$pct" | tr -d '%')
if [ "$usage" -gt "$threshold" ]; then
    echo "Warning: $target is at $usage% usage"
fi
#echo "$target is at $pct usage"
done
echo "----------------"
echo "Memory usage:"
echo "----------------"
echo "$(free -h)"
echo "----------------"
mem_used=$(free -m | awk '/Mem:/ {print ($2-$7)/$2*100}')
echo "Memory usage: $mem_used%"
mem_threshold=${2:-80}  # Default memory threshold is 80% if not provided as an argument
echo "Memory usage threshold: $mem_threshold%"
if [ "$mem_used -gt $mem_threshold" ]; then
    echo "Warning: Memory usage is above threshold: $mem_used%"
fi
echo "----------------"
echo "CPU load:"
echo "----------------"
echo "$(uptime)"
echo "----------------"
echo
echo "Thank You"