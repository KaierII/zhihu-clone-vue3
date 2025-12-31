#!/bin/bash
set -e  # 出错即停

echo "🚀 开始构建项目..."
npm run build

echo "📤 部署到 Nginx 目录..."
rm -rf /var/www/chiandwan/*
cp -r dist/* /var/www/chiandwan/

echo "✅ 部署完成！访问 http://49.235.41.229"
