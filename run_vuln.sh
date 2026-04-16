#!/bin/bash
# run_vuln.sh - Starts all vulnerable target containers

echo "=== Starting Vulnerable Targets ==="
echo ""

docker compose up -d

echo ""
echo "[+] Waiting 15 seconds for services to start..."
sleep 15

echo ""
echo "[+] Targets running:"
echo "    SSH   -> localhost:2222  (user: admin,    pass: password123)"
echo "    FTP   -> localhost:21    (user: ftpuser,  pass: ftp123)"
echo "    MySQL -> localhost:3306  (user: dbuser,   pass: dbpass123)"
echo ""
echo "[+] Run ./exploit_test.sh to start the brute force attack."