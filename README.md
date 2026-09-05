
# Server Performance Stats

A lightweight Bash script for monitoring and displaying basic **Linux server performance statistics** directly from the terminal.

The script collects CPU, memory, disk, process, operating system, and logged-in user information using standard Linux utilities.

## Features

The script provides the following information:

* 🖥️ **Operating System Information**

  * OS name
  * Kernel version
  * Hostname
  * Server uptime

* ⚙️ **CPU Usage**

  * Total CPU utilization percentage

* 🧠 **Memory Usage**

  * Total memory
  * Used memory
  * Free memory
  * Memory utilization percentages

* 💾 **Disk Usage**

  * Total disk capacity
  * Used disk space
  * Free disk space
  * Disk utilization percentages

* 🔥 **Top 5 Processes by CPU Usage**

  * Process ID
  * Process name
  * CPU utilization
  * Memory utilization

* 🧠 **Top 5 Processes by Memory Usage**

  * Process ID
  * Process name
  * CPU utilization
  * Memory utilization

* 👤 **Logged-in Users**

  * Number of currently logged-in users

## Requirements

The script is designed to run on most Linux distributions.

### Required utilities

The script uses standard Linux commands:

```bash
bash
top
free
df
ps
awk
head
tail
who
uname
hostname
uptime
```

Most of these utilities are included by default on common Linux distributions such as:

* Ubuntu
* Debian
* CentOS
* RHEL
* Fedora
* Amazon Linux

## Installation

Clone the repository:

```bash
git clone https://github.com/YOUR-USERNAME/server-stats.git
```

Navigate into the project:

```bash
cd server-stats
```

Make the script executable:

```bash
chmod +x server_stats.sh
```

## Usage

Run the script with:

```bash
./server_stats.sh
```

You can also execute it using Bash:

```bash
bash server_stats.sh
```

## Example Output

```text
============================================================
                 SERVER PERFORMANCE STATS
============================================================

OS INFORMATION
------------------------------------------------------------
OS:       Ubuntu 24.04 LTS
Kernel:   6.8.0-31-generic
Hostname: production-server
Uptime:   up 12 days, 4 hours

CPU USAGE
------------------------------------------------------------
Total CPU Usage: 7.50%

MEMORY USAGE
------------------------------------------------------------
Total Memory: 7974 MB
Used Memory:  3210 MB (40.25%)
Free Memory:  1200 MB (15.05%)

DISK USAGE
------------------------------------------------------------
Total Disk: 100G
Used Disk:  65G (65%)
Free Disk:  35G (35%)

TOP 5 PROCESSES BY CPU USAGE
------------------------------------------------------------
PID        PROCESS                   CPU%       MEM%
1234       python3                   25.4       4.2
2156       nginx                     12.7       1.8
3421       java                       8.9       12.5
1543       dockerd                    5.2        3.4
987        systemd                    2.1        0.5

TOP 5 PROCESSES BY MEMORY USAGE
------------------------------------------------------------
PID        PROCESS                   CPU%       MEM%
3421       java                       8.9       12.5
1234       python3                   25.4        4.2
1543       dockerd                    5.2        3.4
2156       nginx                     12.7        1.8
876        mysqld                     1.5        2.9

LOGGED-IN USERS
------------------------------------------------------------
Currently Logged-in Users: 2

============================================================
                    END OF REPORT
============================================================
```

> **Note:** The values in the example above are illustrative. Actual output will depend on the server where the script is executed.

## How It Works

### CPU Usage

The script uses `top` in batch mode to retrieve CPU statistics:

```bash
top -bn1
```

The CPU idle percentage is extracted using `awk`, and CPU utilization is calculated as:

```text
CPU Usage = 100% - CPU Idle%
```

### Memory Usage

The `free` command is used to retrieve memory statistics:

```bash
free -m
```

The `-m` option displays memory values in megabytes.

The script then calculates the percentage of total memory being used and the percentage that is free.

### Disk Usage

Disk utilization is obtained using:

```bash
df -h --total
```

The `-h` option displays human-readable values such as:

```text
10G
250G
1.5T
```

The `--total` option provides an aggregate total.

### Top CPU Processes

The script uses:

```bash
ps -eo pid,comm,%cpu,%mem --sort=-%cpu
```

Processes are sorted in descending order based on CPU utilization, and the first five processes are displayed.

### Top Memory Processes

The same `ps` command is used, but processes are sorted by memory utilization:

```bash
ps -eo pid,comm,%cpu,%mem --sort=-%mem
```

### Logged-in Users

The number of active login sessions is obtained using:

```bash
who | wc -l
```

## Project Structure

```text
server-stats/
│
├── server_stats.sh
└── README.md
```

## Use Cases

This script can be useful for:

* Basic Linux server monitoring
* Troubleshooting resource usage
* Checking server health
* Identifying resource-heavy processes
* Learning Linux system administration
* Practicing Bash scripting
* DevOps and system administration exercises


## Author

**Francis Egah**

Built as a lightweight Linux server monitoring and Bash scripting project.
Repo; https://github.com/egah923/Server-Performance-Stats
