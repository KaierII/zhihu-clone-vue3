#!/bin/bash
echo "=== 网站访问诊断 ==="

# 1. 检查服务
echo "1. 检查服务状态..."
if netstat -tulnp | grep :3000 > /dev/null; then
    echo "✅ 服务正在运行"
else
    echo "❌ 服务未启动"
fi

# 2. 检查防火墙
echo "2. 检查防火墙..."
if sudo ufw status | grep -q "Status: active"; then
    if sudo ufw status | grep "3000" > /dev/null; then
        echo "✅ 端口3000已放行"
    else
        echo "❌ 端口3000未放行"
    fi
else
    echo "⚠️  防火墙未启用"
fi

# 3. 检查本地访问
echo "3. 测试本地访问..."
if curl -s http://localhost:3000 > /dev/null; then
    echo "✅ 本地访问成功"
else
    echo "❌ 本地访问失败"
fi

echo ""
echo "如果本地能访问但公网不能访问："
echo "1. 登录云服务器控制台"
echo "2. 检查安全组是否开放端口3000"
echo "3. 确保来源IP为0.0.0.0/0"