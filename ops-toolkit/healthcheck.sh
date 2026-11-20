#!/usr/bin/env bash
set -euo pipefail

echo "Checking health of the system..."
echo "Disk usage:"
echo "----------------"
echo "$(df -h)" > /tmp/disk_usage.txt
echo "----------------"
echo "Memory usage:"
echo "----------------"
echo "$(free -hm)" > /tmp/memory_usage.txt
echo "----------------"
echo "CPU load:"
echo "----------------"
echo "$(uptime)" > /tmp/cpu_load.txt
echo "----------------"
echo
echo "Thank You"