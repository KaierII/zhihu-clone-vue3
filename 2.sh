cat > start-zhihu-server.sh << 'EOF'
#!/bin/bash
echo "启动知乎日报服务..."

# 进入项目目录
cd ~/chiandwan

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 停止已运行的进程
echo -e "${YELLOW}停止已运行的进程...${NC}"
pkill -f "node.*vite" || true
pkill -f "npm.*run.*dev" || true

# 等待端口释放
sleep 2

# 检查依赖
echo -e "${YELLOW}检查依赖...${NC}"
if [ ! -d "node_modules" ]; then
    echo "安装依赖..."
    npm install
fi

# 获取IP地址
IP=$(hostname -I | awk '{print $1}')
PUBLIC_IP=$(curl -s ifconfig.me 2>/dev/null || echo "无法获取")

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}    启动知乎日报服务    ${NC}"
echo -e "${GREEN}========================================${NC}"
echo "本地访问:  http://localhost:3000"
echo "内网访问:  http://$IP:3000"
echo "公网访问:  http://${PUBLIC_IP}:3000"
echo ""
echo -e "${YELLOW}重要：${NC}"
echo "1. 确保云服务器安全组已开放端口 3000"
echo "2. 如果使用防火墙，需要允许端口 3000"
echo ""
echo -e "${YELLOW}按 Ctrl+C 停止服务${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# 启动服务
HOST=0.0.0.0 PORT=3000 npm run dev
EOF

chmod +x start-zhihu-server.sh
./start-zhihu-server.sh