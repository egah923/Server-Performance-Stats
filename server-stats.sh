#!/bin/bash

# ============================================================
# Server Performance Statistics
# Usage: ./server_stats.sh
# ============================================================

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "============================================================"
echo "                 SERVER PERFORMANCE STATS"
echo "============================================================"
echo

# ------------------------------------------------------------
# OS INFORMATION
# ------------------------------------------------------------

echo -e "${BLUE}OS INFORMATION${NC}"
echo "------------------------------------------------------------"

if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "OS:       $PRETTY_NAME"
else
    echo "OS:       $(uname -s)"
fi

echo "Kernel:   $(uname -r)"
echo "Hostname: $(hostname)"
echo "Uptime:   $(uptime -p)"
echo

# ------------------------------------------------------------
# CPU USAGE
# ------------------------------------------------------------

echo -e "${BLUE}CPU USAGE${NC}"
echo "------------------------------------------------------------"

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | \
    awk '{print 100 - $8}')

printf "Total CPU Usage: %.2f%%\n" "$CPU_USAGE"
echo

# ------------------------------------------------------------
# MEMORY USAGE
# ------------------------------------------------------------

echo -e "${BLUE}MEMORY USAGE${NC}"
echo "------------------------------------------------------------"

free -m | awk '
NR==2 {
    total=$2
    used=$3
    free=$4

    used_percent=(used/total)*100
    free_percent=(free/total)*100

    printf "Total Memory: %d MB\n", total
    printf "Used Memory:  %d MB (%.2f%%)\n", used, used_percent
    printf "Free Memory:  %d MB (%.2f%%)\n", free, free_percent
}'
echo

# ------------------------------------------------------------
# DISK USAGE
# ------------------------------------------------------------

echo -e "${BLUE}DISK USAGE${NC}"
echo "------------------------------------------------------------"

df -h --total 2>/dev/null | awk '
/total/ {
    printf "Total Disk: %s\n", $2
    printf "Used Disk:  %s (%s)\n", $3, $5
    printf "Free Disk:  %s (%s)\n", $4, 100 - substr($5, 1, length($5)-1) "%"
}'
echo

# ------------------------------------------------------------
# TOP 5 PROCESSES BY CPU
# ------------------------------------------------------------

echo -e "${BLUE}TOP 5 PROCESSES BY CPU USAGE${NC}"
echo "------------------------------------------------------------"

printf "%-10s %-25s %-10s %-10s\n" "PID" "PROCESS" "CPU%" "MEM%"

ps -eo pid,comm,%cpu,%mem --sort=-%cpu | \
    head -n 6 | tail -n 5 | \
    awk '{printf "%-10s %-25s %-10s %-10s\n", $1, $2, $3, $4}'

echo

# ------------------------------------------------------------
# TOP 5 PROCESSES BY MEMORY
# ------------------------------------------------------------

echo -e "${BLUE}TOP 5 PROCESSES BY MEMORY USAGE${NC}"
echo "------------------------------------------------------------"

printf "%-10s %-25s %-10s %-10s\n" "PID" "PROCESS" "CPU%" "MEM%"

ps -eo pid,comm,%cpu,%mem --sort=-%mem | \
    head -n 6 | tail -n 5 | \
    awk '{printf "%-10s %-25s %-10s %-10s\n", $1, $2, $3, $4}'

echo


# ------------------------------------------------------------
# LOGGED-IN USERS
# ------------------------------------------------------------

echo -e "${BLUE}LOGGED-IN USERS${NC}"
echo "------------------------------------------------------------"

who | wc -l | awk '{print "Currently Logged-in Users:", $1}'
echo

# ------------------------------------------------------------
# END
# ------------------------------------------------------------

echo "============================================================"
echo "                    END OF REPORT"
echo "============================================================"
