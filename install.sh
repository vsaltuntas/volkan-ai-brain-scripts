#!/bin/bash
# Volkan AI Brain - Basit Kurulum (heredoc yok!)
# Kullanim: curl -o /tmp/i.sh https://raw.githubusercontent.com/vsaltuntas/volkan-ai-brain-scripts/main/install.sh && bash /tmp/i.sh
set -e
DIR="/home/workspace/universal-ai-brain"
FE="$DIR/frontend"
mkdir -p "$FE"

echo "[1/3] Dashboard indiriliyor..."
curl -sL -o "$FE/index.html" https://raw.githubusercontent.com/vsaltuntas/volkan-ai-brain-scripts/main/dashboard.html
echo "  OK"

echo "[2/3] Python server baslatiliyor..."
pkill -f "http.server 8000" 2>/dev/null || true
sleep 1
cd "$FE"
nohup python3 -m http.server 8000 > "$DIR/logs/frontend.log" 2>&1 &
echo $! > "$DIR/frontend.pid"
echo "  Dashboard: http://localhost:8000 (PID: $!)"

echo "[3/3] Python paketleri kuruluyor..."
pip3 install --user mem0ai 2>/dev/null && echo "  Mem0 OK" || echo "  Mem0 fail"
pip3 install --user cognee 2>/dev/null && echo "  Cognee OK" || echo "  Cognee fail"

echo "PM2 kaydediliyor..."
pm2 save 2>/dev/null || true

echo ""
echo "========================================"
echo "  TAMAMLANDI!"
echo "  Dashboard: http://localhost:8000"
echo "========================================"