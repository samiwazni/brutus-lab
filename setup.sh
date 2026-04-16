#!/bin/bash
# setup.sh - Downloads Brutus and prepares the lab environment

echo "=== Brutus Lab Setup ==="
echo ""

# Check Docker is installed
if ! command -v docker &> /dev/null; then
    echo "[ERROR] Docker is not installed. Please install Docker first."
    exit 1
fi

echo "[+] Docker found"

# Download Brutus binary
echo "[+] Downloading Brutus..."
curl -L https://github.com/praetorian-inc/brutus/releases/latest/download/brutus-linux-amd64 -o brutus
chmod +x brutus
echo "[+] Brutus downloaded and ready"

echo ""
echo "[+] Setup complete. Run ./run_vuln.sh to start the vulnerable targets."