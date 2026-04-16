#!/bin/bash
# run_secured.sh - Starts hardened targets with strong passwords

echo "=== Starting Secured Targets ==="
echo ""

# Stop vulnerable version first
docker compose down

# Start secured version
docker compose -f docker-compose.secured.yml up -d

echo ""
echo "[+] Waiting 15 seconds for services to start..."
sleep 15

echo ""
echo "[+] Secured targets running with strong passwords."
echo "[+] Run ./exploit_test.sh to confirm Brutus cannot crack them."