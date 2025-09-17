#!/bin/bash

# Simple Happy Service - Just logs messages to show it's running
echo "🚀 Happy Service starting up..."
echo "📅 Started at: $(date -Iseconds)"
echo "🏠 Hostname: ${HOSTNAME:-unknown}"

counter=0
start_time=$(date +%s)

# Graceful shutdown handler
cleanup() {
    echo "⚠️  Signal received, shutting down gracefully..."
    echo "✅ Happy Service stopped"
    exit 0
}

# Set up signal handlers
trap cleanup SIGTERM SIGINT

echo "✅ Happy Service is running! Check logs for heartbeat messages..."

# Simple heartbeat every 5 seconds
while true; do
    # Assume the service is serving traffic on port 3000, but for simplicity I have excluded that functionality.

    ((counter++))
    echo "💗 Happy Service heartbeat #${counter} - $(date -Iseconds)"
    
    # Log some system info periodically (every 30 seconds)
    if ((counter % 10 == 0)); then
        current_time=$(date +%s)
        uptime=$((current_time - start_time))
        memory=$(awk '/VmRSS/ {printf "%.0f", $2/1024}' /proc/self/status 2>/dev/null || echo "unknown")
        echo "📊 System info - Uptime: ${uptime}.0s, Memory: ${memory}MB"
    fi
    
    sleep 2
done