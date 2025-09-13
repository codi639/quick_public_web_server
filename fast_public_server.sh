#!/bin/bash

# Check if cloudflared is installed
command -v cloudflared >/dev/null 2>&1 || { echo >&2 "cloudflared is required but not installed. Aborting."; exit 1; }

# Folder to serve (current folder by default)
DIR="${1:-$(pwd)}"
PORT="${2:-8156}"

cd "$DIR" || exit

echo "Serving folder: $DIR on port $PORT"

# Start local server in background
python3 -m http.server "$PORT" &
SERVER_PID=$!
echo "Local server PID: $SERVER_PID"

# Start cloudflared tunnel in background
cloudflared tunnel --url "http://localhost:$PORT" &
TUNNEL_PID=$!

# Print public URL
echo "Public URL (Cloudflare tunnel) will appear below:"
#cloudflared tunnel list | grep -o 'https://.*trycloudflare.com' || 
echo "(Wait a few seconds if not yet ready)"
# Give it a few seconds to start
sleep 3

# Trap Ctrl+C to stop both processes
trap "echo; echo 'Stopping server and tunnel...'; kill $SERVER_PID $TUNNEL_PID; exit" SIGINT

# Keep script alive while tunnel runs
wait
