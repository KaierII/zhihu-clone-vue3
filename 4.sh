#!/bin/bash

echo "🔍 正在执行 Web 服务一键诊断..."
echo "========================================"

# 1. 检查 Nginx 是否运行
if systemctl is-active --quiet nginx; then
    echo "✅ Nginx 正在运行"
else
    echo "❌ Nginx 未运行！请执行：sudo systemctl start nginx"
    exit 1
fi

# 2. 检查是否监听 0.0.0.0:80
if ss -tuln | grep -q ':80.*0\.0\.0\.0'; then
    echo "✅ Nginx 正在监听 0.0.0.0:80"
else
    echo "❌ Nginx 未监听 0.0.0.0:80，请检查 /etc/nginx/sites-enabled/default 中的 listen 配置"
    exit 1
fi

# 3. 检查网站根目录权限（假设路径为 /home/ubuntu/chiandwan/dist）
WEB_ROOT="/home/ubuntu/chiandwan/dist"
INDEX_FILE="$WEB_ROOT/index.html"

if [ -f "$INDEX_FILE" ]; then
    if sudo -u www-data test -r "$INDEX_FILE" 2>/dev/null; then
        echo "✅ www-data 用户可读取 $INDEX_FILE"
    else
        echo "❌ 权限错误：www-data 无法读取 $INDEX_FILE"
        echo "   请运行："
        echo "   sudo chmod o+x /home/ubuntu"
        echo "   sudo chmod o+x /home/ubuntu/chiandwan"
        echo "   sudo chmod o+x /home/ubuntu/chiandwan/dist"
        echo "   sudo chmod -R o+r /home/ubuntu/chiandwan/dist"
        exit 1
    fi
else
    echo "❌ 网站文件不存在：$INDEX_FILE"
    exit 1
fi

# 4. 本地访问测试
LOCAL_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost)
if [ "$LOCAL_CODE" = "200" ]; then
    echo "✅ 本地访问成功 (HTTP $LOCAL_CODE)"
else
    echo "❌ 本地访问失败 (HTTP $LOCAL_CODE)，请检查 Nginx 错误日志："
    echo "   sudo tail -n 10 /var/log/nginx/error.log"
    exit 1
fi

# 5. 获取服务器公网出口 IP（用于确认是否与 119.29.90.235 一致）
PUBLIC_IP=$(curl -s https://ip.sb)
echo "🌐 服务器当前公网出口 IP: $PUBLIC_IP"
if [ "$PUBLIC_IP" = "119.29.90.235" ]; then
    echo "✅ 公网 IP 匹配"
else
    echo "⚠️ 注意：当前出口 IP 与 119.29.90.235 不一致！"
    echo "   请确认该实例是否绑定了弹性公网 IP（EIP）"
fi

# 6. 最终提示
echo ""
echo "🎯 诊断完成！如果外部仍无法访问，请按以下步骤操作："
echo "   1. 登录腾讯云控制台 → CVM → 实例 → 管理安全组"
echo "   2. 确保安全组入站规则包含：TCP:80 允许 0.0.0.0/0"
echo "   3. 在你本地电脑（非服务器）运行："
echo "        telnet 119.29.90.235 80"
echo "      或使用在线工具：https://ping.eu/port-chk/"
echo ""
echo "💡 如果 telnet 成功但浏览器显示 502，请检查前端资源路径（如 /assets/...）是否正确加载。"