# server-perf-stats

# Server Performance Dashboard

A real-time, color-coded Bash script that monitors and displays your server's performance metrics in a beautiful dashboard format.

## Features

- **CPU Usage**: Real-time CPU utilization percentage
- **Memory Usage**: RAM consumption with usage percentage
- **Disk Usage**: Storage space used and available
- **Load Average**: System load over time
- **Top Processes**: Top 5 CPU and memory-consuming processes
- **Auto-refresh**: Continuously updates at customizable intervals
- **Color-coded output**: Easy-to-read visual indicators

## Prerequisites

The script requires the following commands (typically pre-installed on most Linux systems):
- `top`
- `free`
- `df`
- `ps`
- `ls`
- `awk`

## Installation

1. Download the script:
```bash
curl -O https://your-script-location/server-stats.sh
```

2. Make it executable:
```bash
chmod +x server-stats.sh
```

## Usage

### Basic Usage

Run with default 5-second refresh interval:
```bash
./server-stats.sh
```

Run with custom refresh interval (e.g., 10 seconds):
```bash
./server-stats.sh 10
```

### Using with tmux

Tmux is perfect for running this dashboard in the background while you work in other terminal windows.

#### 1. Install tmux (if not already installed)

**Ubuntu/Debian:**
```bash
sudo apt-get install tmux
```

**CentOS/RHEL:**
```bash
sudo yum install tmux
```

**macOS:**
```bash
brew install tmux
```

#### 2. Start a tmux session with the dashboard

```bash
tmux new -s dashboard
```

Then run the script:
```bash
./server-stats.sh
```

#### 3. Detach from tmux session

Press `Ctrl+b`, then press `d` to detach and leave the dashboard running in the background.

#### 4. Useful tmux commands

- **List sessions**: `tmux ls`
- **Attach to session**: `tmux attach -t dashboard`
- **Kill session**: `tmux kill-session -t dashboard`
- **Split window horizontally**: `Ctrl+b` then `"`
- **Split window vertically**: `Ctrl+b` then `%`
- **Switch between panes**: `Ctrl+b` then arrow keys
- **Create new window**: `Ctrl+b` then `c`
- **Switch windows**: `Ctrl+b` then `0-9`

#### 5. Advanced tmux setup

Create a dedicated monitoring layout:
```bash
# Start new session
tmux new -s monitor

# Split horizontally
Ctrl+b "

# Run dashboard in top pane
./server-stats.sh

# Switch to bottom pane
Ctrl+b (down arrow)

# Run additional commands or logs
tail -f /var/log/syslog
```

## Output Explanation

- **CPU Usage**: Percentage of CPU currently in use
- **Memory Usage**: Shows used memory, total memory, and usage percentage
- **Disk Usage**: Total used space, free space, and usage percentage
- **Load Average**: 1, 5, and 15-minute load averages
- **Top Processes**: Lists processes by PID, parent PID, command, memory %, and CPU %

## Stopping the Script

Press `Ctrl+C` to exit the dashboard.

## Troubleshooting

**Script reports missing commands**: Install the required package (usually `procps` or `coreutils`)
```bash
sudo apt-get install procps  # Ubuntu/Debian
sudo yum install procps-ng   # CentOS/RHEL
```

**Permission denied**: Ensure the script is executable
```bash
chmod +x server-stats.sh
```

## Learn More

This project is part of the roadmap.sh DevOps projects:
https://roadmap.sh/projects/server-stats