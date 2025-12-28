#!/usr/bin/env bash

# ================================
# 🚀 Server Performance Dashboard 🚀
# ================================

# Interval between updates (seconds)
INTERVAL=${1:-5}   # Default 5 seconds if not provided

# Check for required commands
for cmd in top free df ps ls awk; do
    if ! command -v $cmd &> /dev/null; then
        echo "$cmd is missing. Please install it."
        exit 1
    fi
done

# Colors
RED='\033[0;31m' 
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# CPU Usage
display_cpu_usage() {
    echo -e "${CYAN} CPU Usage:${NC}"
    CPU=$(top -bn1 | grep "Cpu(s)" | awk -F',' '{for(i=1;i<=NF;i++){if($i ~ /id/) {split($i,a," "); print 100 - a[1]}}}')
    echo -e "Total CPU Usage: ${GREEN}$CPU%${NC}"
    echo ""
}

# Memory Usage
display_memory_usage() {
    echo -e "${CYAN} Memory Usage:${NC}"
    free -m | awk -v red="$RED" -v green="$GREEN" -v nc="$NC" 'NR==2{
        printf "Used: %sMB | Total: %sMB | Usage: %.2f%%\n", $3, $2, ($3/$2)*100
    }'
    echo ""
}

# Disk Usage
display_disk_usage() {
    echo -e "${CYAN} Disk Usage:${NC}"
    df -h --total | awk '/total/ {printf "Used: %s | Free: %s | Usage: %s\n", $3, $4, $5}'
    echo ""
}

# Load Average
display_load_average() {
    echo -e "${CYAN} Load Average:${NC}"
    uptime | awk -F'load average:' '{print $2}'
    echo ""
}

# Top 5 CPU-consuming processes
display_top_cpu_processes() {
    echo -e "${CYAN} Top 5 CPU Processes:${NC}"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
    echo ""
}

# Top 5 Memory-consuming processes
display_top_mem_processes() {
    echo -e "${CYAN} Top 5 Memory Processes:${NC}"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
    echo ""
}

# Main loop
main() {
    while true; do
        clear
       cat << "EOF"
 ██████  ███████ ██████  ██    ██ ███████ ██████  
██       ██      ██   ██ ██    ██ ██      ██   ██ 
██   ███ █████   ██████  ██    ██ █████   ██████  
██    ██ ██      ██   ██  ██  ██  ██      ██   ██ 
 ██████  ███████ ██      ██████   ███████ ██   ██ 
                                                  
 ██████   █████  ███████ ██   ██ ██████   ██████   █████  ██████  ██████  
 ██   ██ ██   ██ ██      ██   ██ ██   ██ ██    ██ ██   ██ ██   ██ ██   ██ 
 ██   ██ ███████ ███████ ███████ ██████  ██    ██ ███████ ██████  ██   ██ 
 ██   ██ ██   ██      ██ ██   ██ ██   ██ ██    ██ ██   ██ ██   ██ ██   ██ 
 ██████  ██   ██ ███████ ██   ██ ██████   ██████  ██   ██ ██   ██ ██████  
EOF

echo "----------------------------------------------------------------"
echo -e "${YELLOW}  System Health Check | $(date +'%Y-%m-%d %H:%M:%S')${NC}"
echo "----------------------------------------------------------------"
        echo ""

        display_cpu_usage
        display_memory_usage
        display_disk_usage
        display_load_average
        display_top_cpu_processes
        display_top_mem_processes

        echo "=============================================================="
        echo -e "Updating every ${INTERVAL} seconds... (Press Ctrl+C to exit)"
        sleep $INTERVAL
    done
}

# Execute main function
main
