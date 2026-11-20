#!/usr/bin/env bash
set -euo pipefail

threshold=${1:-80}  # Default threshold is 80% if not provided as an argument
echo "Checking health of the system..."
echo "Disk usage:"
echo "----------------"
echo "$(df -hm)"
echo "----------------"
echo "Disk usage by mount point:"
df --output=pcent,target | tail -n +2 | while read -r pct target; do
usage=$(echo "$pct" | tr -d '%')
if [ "$usage" -gt "$threshold" ]; then
    echo "Warning: $target is at $usage% usage"
fi
#echo "$target is at $pct usage"
done
echo "----------------"
echo "Memory usage:"
echo "----------------"
echo "$(free -hm)"
echo "----------------"
echo "CPU load:"
echo "----------------"
echo "$(uptime)"
echo "----------------"
echo
echo "Thank You"