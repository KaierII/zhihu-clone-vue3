// src/main.js
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import 'vant/lib/index.css'; // 引入 Vant UI 样式
import './assets/css/animations.css' // 引入自定义动画样式
import './styles/vant-theme.css'; // ← 自定义主题

const app = createApp(App)
app.use(router)
app.mount('#app')
