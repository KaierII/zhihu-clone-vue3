# zhihudaily-clone (知乎日报/知乎高仿)

使用 Vue 3 + Vite + TypeScript + Vue Router 开发的高仿知乎日报项目。

## 技术栈
- Vue 3 (Composition API)
- Vite 5
- TypeScript
- Vue Router 4
- Axios / fetch (API 请求)
- Naive UI / Element Plus (UI 组件库)
- ESLint + Prettier (代码规范)

## 推荐开发环境
- **IDE**：VS Code + Vue (Official) 插件
- **浏览器**：Chrome/Edge + Vue.js devtools 扩展
  - 开启 Chrome DevTools 的 "Custom Object Formatter"

## 快速开始

```bash
# 安装依赖
pnpm install   # 或 npm install / yarn

# 启动开发服务器（http://localhost:5173）
pnpm dev

# 打包生产版本
pnpm build

# 代码检查 & 修复
pnpm lint
项目结构
textsrc/
├── assets/           # 静态资源
├── components/       # 公共组件
├── views/            # 页面视图
├── router/           # 路由配置
├── api/              # API 接口封装
└── main.ts           # 入口文件
