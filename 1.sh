#!/bin/bash

echo "正在为网站添加丰富的动画效果..."

# 检查是否在项目根目录
if [ ! -f "package.json" ]; then
    echo "错误：请在项目根目录运行此脚本"
    exit 1
fi

# 创建动画CSS文件
echo "创建全局动画CSS文件..."
mkdir -p src/assets/css
cat > src/assets/css/animations.css << 'EOF_ANIMATIONS'
/* src/assets/css/animations.css */
/* 全局动画样式 */

/* 1. 页面切换动画 */
.page-enter-active,
.page-leave-active {
  transition: all 0.3s ease;
}
.page-enter-from {
  opacity: 0;
  transform: translateY(20px);
}
.page-leave-to {
  opacity: 0;
  transform: translateY(-20px);
}

/* 2. 渐入动画 */
.fade-in {
  animation: fadeIn 0.6s ease forwards;
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

/* 3. 上浮动画 */
.float-up {
  animation: floatUp 0.5s ease forwards;
}

@keyframes floatUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* 4. 左侧滑入 */
.slide-left {
  animation: slideLeft 0.4s ease forwards;
}

@keyframes slideLeft {
  from {
    opacity: 0;
    transform: translateX(-30px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

/* 5. 右侧滑入 */
.slide-right {
  animation: slideRight 0.4s ease forwards;
}

@keyframes slideRight {
  from {
    opacity: 0;
    transform: translateX(30px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

/* 6. 缩放进入 */
.zoom-in {
  animation: zoomIn 0.4s ease forwards;
}

@keyframes zoomIn {
  from {
    opacity: 0;
    transform: scale(0.9);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

/* 7. 弹跳动画 */
.bounce {
  animation: bounce 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

@keyframes bounce {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-8px);
  }
}

/* 8. 脉动动画 */
.pulse {
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0% {
    opacity: 1;
  }
  50% {
    opacity: 0.7;
  }
  100% {
    opacity: 1;
  }
}

/* 9. 旋转动画 */
.spin {
  animation: spin 1s linear infinite;
}

@keyframes spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

/* 10. 摇摆动画 */
.swing {
  animation: swing 1s ease infinite alternate;
  transform-origin: top center;
}

@keyframes swing {
  0% {
    transform: rotate(-3deg);
  }
  100% {
    transform: rotate(3deg);
  }
}

/* 11. 闪烁动画 */
.blink {
  animation: blink 1.5s infinite;
}

@keyframes blink {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.5;
  }
}

/* 12. 新闻卡片悬停效果 */
.news-card {
  transition: all 0.3s ease;
}
.news-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

/* 13. 按钮点击效果 */
.btn-click {
  transition: all 0.2s ease;
}
.btn-click:active {
  transform: scale(0.95);
}

/* 14. 加载骨架动画 */
.skeleton {
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 200% 100%;
  animation: loading 1.5s infinite;
}

@keyframes loading {
  0% {
    background-position: 200% 0;
  }
  100% {
    background-position: -200% 0;
  }
}

/* 15. 波纹效果 */
.ripple {
  position: relative;
  overflow: hidden;
}
.ripple:after {
  content: "";
  position: absolute;
  top: 50%;
  left: 50%;
  width: 5px;
  height: 5px;
  background: rgba(255, 255, 255, 0.5);
  opacity: 0;
  border-radius: 100%;
  transform: scale(1, 1) translate(-50%);
  transform-origin: 50% 50%;
}
.ripple:focus:not(:active)::after {
  animation: ripple 1s ease-out;
}

@keyframes ripple {
  0% {
    transform: scale(0, 0);
    opacity: 0.5;
  }
  20% {
    transform: scale(25, 25);
    opacity: 0.3;
  }
  100% {
    opacity: 0;
    transform: scale(40, 40);
  }
}

/* 16. 打字机效果 */
.typewriter {
  overflow: hidden;
  border-right: 2px solid;
  white-space: nowrap;
  animation: typing 3.5s steps(40, end), blink-caret 0.75s step-end infinite;
}

@keyframes typing {
  from {
    width: 0;
  }
  to {
    width: 100%;
  }
}

@keyframes blink-caret {
  from, to {
    border-color: transparent;
  }
  50% {
    border-color: orange;
  }
}

/* 17. 心跳动画 */
.heartbeat {
  animation: heartbeat 1.5s ease-in-out infinite;
}

@keyframes heartbeat {
  0% {
    transform: scale(1);
  }
  14% {
    transform: scale(1.1);
  }
  28% {
    transform: scale(1);
  }
  42% {
    transform: scale(1.1);
  }
  70% {
    transform: scale(1);
  }
}

/* 18. 摇晃动画 */
.shake {
  animation: shake 0.5s;
}

@keyframes shake {
  0%, 100% {
    transform: translateX(0);
  }
  10%, 30%, 50%, 70%, 90% {
    transform: translateX(-5px);
  }
  20%, 40%, 60%, 80% {
    transform: translateX(5px);
  }
}

/* 19. 翻转动画 */
.flip {
  animation: flip 0.8s;
  backface-visibility: visible;
}

@keyframes flip {
  0% {
    transform: perspective(400px) rotateY(0);
    animation-timing-function: ease-out;
  }
  40% {
    transform: perspective(400px) translateZ(150px) rotateY(170deg);
    animation-timing-function: ease-out;
  }
  50% {
    transform: perspective(400px) translateZ(150px) rotateY(190deg) scale(1);
    animation-timing-function: ease-in;
  }
  80% {
    transform: perspective(400px) rotateY(360deg) scale(0.95);
    animation-timing-function: ease-in;
  }
  100% {
    transform: perspective(400px) scale(1);
    animation-timing-function: ease-in;
  }
}

/* 20. 悬停放大 */
.hover-grow {
  transition: transform 0.3s ease;
}
.hover-grow:hover {
  transform: scale(1.05);
}

/* 21. 渐变色背景动画 */
.gradient-bg {
  background: linear-gradient(-45deg, #ee7752, #e73c7e, #23a6d5, #23d5ab);
  background-size: 400% 400%;
  animation: gradient 15s ease infinite;
}

@keyframes gradient {
  0% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
  100% {
    background-position: 0% 50%;
  }
}

/* 22. 滚动动画触发类 */
.animate-on-scroll {
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.6s ease;
}
.animate-on-scroll.active {
  opacity: 1;
  transform: translateY(0);
}

/* 23. 延迟动画 */
.delay-1 { animation-delay: 0.1s; }
.delay-2 { animation-delay: 0.2s; }
.delay-3 { animation-delay: 0.3s; }
.delay-4 { animation-delay: 0.4s; }
.delay-5 { animation-delay: 0.5s; }
.delay-6 { animation-delay: 0.6s; }
.delay-7 { animation-delay: 0.7s; }
.delay-8 { animation-delay: 0.8s; }
.delay-9 { animation-delay: 0.9s; }
.delay-10 { animation-delay: 1s; }

/* 24. 持续时间控制 */
.duration-fast { animation-duration: 0.3s; }
.duration-normal { animation-duration: 0.5s; }
.duration-slow { animation-duration: 0.8s; }
.duration-slower { animation-duration: 1.2s; }
.duration-slowest { animation-duration: 2s; }

/* 25. 无限动画 */
.infinite { animation-iteration-count: infinite; }
.repeat-2 { animation-iteration-count: 2; }
.repeat-3 { animation-iteration-count: 3; }
EOF_ANIMATIONS

# 创建动画工具函数
echo "创建动画工具函数..."
cat > src/utils/animations.js << 'EOF_ANIMATIONS_JS'
// src/utils/animations.js
/**
 * 动画工具函数
 */

/**
 * 检查元素是否在视口中
 * @param {Element} element - DOM元素
 * @param {number} offset - 偏移量
 * @returns {boolean} 是否在视口中
 */
export const isInViewport = (element, offset = 0) => {
  if (!element) return false;
  
  const rect = element.getBoundingClientRect();
  return (
    rect.top <= (window.innerHeight || document.documentElement.clientHeight) - offset &&
    rect.bottom >= offset &&
    rect.left <= (window.innerWidth || document.documentElement.clientWidth) - offset &&
    rect.right >= offset
  );
};

/**
 * 为元素添加滚动动画
 * @param {string} selector - CSS选择器
 * @param {string} activeClass - 激活时添加的类名
 * @param {number} offset - 偏移量
 */
export const setupScrollAnimations = (selector = '.animate-on-scroll', activeClass = 'active', offset = 100) => {
  const elements = document.querySelectorAll(selector);
  
  const checkScroll = () => {
    elements.forEach(element => {
      if (isInViewport(element, offset)) {
        element.classList.add(activeClass);
      }
    });
  };
  
  // 初始检查
  checkScroll();
  
  // 监听滚动
  window.addEventListener('scroll', checkScroll);
  
  // 监听resize
  window.addEventListener('resize', checkScroll);
  
  return () => {
    window.removeEventListener('scroll', checkScroll);
    window.removeEventListener('resize', checkScroll);
  };
};

/**
 * 为元素添加点击波纹效果
 * @param {Element} element - DOM元素
 */
export const addRippleEffect = (element) => {
  element.classList.add('ripple');
  element.addEventListener('click', function(e) {
    const ripple = document.createElement('span');
    const rect = this.getBoundingClientRect();
    
    const size = Math.max(rect.width, rect.height);
    const x = e.clientX - rect.left - size / 2;
    const y = e.clientY - rect.top - size / 2;
    
    ripple.style.cssText = `
      position: absolute;
      border-radius: 50%;
      background: rgba(255, 255, 255, 0.7);
      transform: scale(0);
      animation: ripple 0.6s linear;
      width: ${size}px;
      height: ${size}px;
      top: ${y}px;
      left: ${x}px;
      pointer-events: none;
    `;
    
    this.appendChild(ripple);
    
    setTimeout(() => {
      ripple.remove();
    }, 600);
  });
};

/**
 * 执行动画
 * @param {Element} element - DOM元素
 * @param {string} animation - 动画名称
 * @param {Function} callback - 回调函数
 */
export const animateCSS = (element, animation, callback) => {
  const prefix = 'animate__';
  const animationName = `${prefix}${animation}`;
  const node = element;
  
  node.classList.add(`${prefix}animated`, animationName);
  
  function handleAnimationEnd() {
    node.classList.remove(`${prefix}animated`, animationName);
    node.removeEventListener('animationend', handleAnimationEnd);
    
    if (typeof callback === 'function') {
      callback();
    }
  }
  
  node.addEventListener('animationend', handleAnimationEnd);
};

/**
 * 顺序动画
 * @param {Array} elements - 元素数组
 * @param {string} animationClass - 动画类名
 * @param {number} delay - 延迟时间
 */
export const sequentialAnimation = (elements, animationClass, delay = 100) => {
  elements.forEach((element, index) => {
    setTimeout(() => {
      element.classList.add(animationClass);
    }, index * delay);
  });
};
EOF_ANIMATIONS_JS

# 更新main.js引入动画CSS
echo "更新main.js引入动画CSS..."
cat > src/main.js << 'EOF_MAIN'
// src/main.js
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import 'vant/lib/index.css'; // 引入 Vant UI 样式
import './assets/css/animations.css' // 引入自定义动画样式

const app = createApp(App)
app.use(router)
app.mount('#app')
EOF_MAIN

# 更新App.vue添加路由过渡动画
echo "更新App.vue添加路由过渡动画..."
cat > App.vue << 'EOF_APP'
<!-- App.vue -->
<template>
  <div class="app-container">
    <!-- 路由视图添加过渡动画 -->
    <router-view v-slot="{ Component }">
      <transition name="page" mode="out-in">
        <component :is="Component" />
      </transition>
    </router-view>
  </div>
</template>

<script setup>
import { onMounted } from 'vue';
import { setupScrollAnimations } from '@/utils/animations';

onMounted(() => {
  // 初始化滚动动画
  setupScrollAnimations();
});
</script>

<style>
/* 全局样式 */
body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background-color: #f8f8f8;
}

/* 路由过渡动画 */
.page-enter-active,
.page-leave-active {
  transition: all 0.3s ease;
}
.page-enter-from {
  opacity: 0;
  transform: translateX(-20px);
}
.page-leave-to {
  opacity: 0;
  transform: translateX(20px);
}
</style>
EOF_APP

# 更新HomePage.vue添加动画效果
echo "更新HomePage.vue添加动画效果..."
cat > src/views/HomePage.vue << 'EOF_HOME'
<!-- src/views/HomePage.vue -->
<template>
  <div class="home-page fade-in">
    <!-- 顶部固定 Header -->
    <van-nav-bar fixed title="知乎日报" class="header slide-left">
      <template #left>
        <img src="@/assets/logo.png" alt="Logo" class="logo heartbeat hover-grow" />
      </template>
      <template #right>
        <van-icon name="user-o" size="22" @click="goToProfile" class="hover-grow btn-click" />
      </template>
    </van-nav-bar>

    <div class="content">
      <!-- 今日新闻 -->
      <div v-if="latestNews.stories && latestNews.stories.length" class="animate-on-scroll">
        <h2 class="date-title float-up">今日热闻</h2>
        <van-cell-group inset>
          <van-cell
            v-for="(story, index) in latestNews.stories"
            :key="story.id"
            :title="story.title"
            is-link
            @click="goToDetail(story.id)"
            class="news-card animate-on-scroll"
            :style="{ animationDelay: index * 0.1 + 's' }"
          >
            <template #right-icon>
              <img :src="story.images[0]" class="news-cover zoom-in" v-if="story.images && story.images.length"/>
            </template>
          </van-cell>
        </van-cell-group>
      </div>

      <!-- 往日新闻列表 -->
      <div v-for="(dailyNews, date, dateIndex) in pastNews" :key="date" class="animate-on-scroll">
        <h2 class="date-title float-up" :style="{ animationDelay: dateIndex * 0.2 + 's' }">{{ formatDate(dailyNews.date) }}</h2>
        <van-cell-group inset>
          <van-cell
            v-for="(story, storyIndex) in dailyNews.stories"
            :key="story.id"
            :title="story.title"
            is-link
            @click="goToDetail(story.id)"
            class="news-card animate-on-scroll"
            :style="{ animationDelay: (dateIndex * 0.2 + storyIndex * 0.1) + 's' }"
          >
            <template #right-icon>
              <img :src="story.images[0]" class="news-cover zoom-in" v-if="story.images && story.images.length"/>
            </template>
          </van-cell>
        </van-cell-group>
      </div>

      <!-- 加载更多/底部按钮 -->
      <div class="load-more animate-on-scroll">
        <van-button 
          type="default" 
          block 
          @click="loadMoreNews" 
          :loading="loading" 
          class="btn-click pulse"
        >
          {{ loading ? '加载中...' : '加载更早新闻' }}
        </van-button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, nextTick } from 'vue';
import { useRouter } from 'vue-router';
import request from '@/utils/request';
import { showToast } from 'vant';
import { setupScrollAnimations } from '@/utils/animations';

const router = useRouter();
const latestNews = ref({});
const pastNews = ref({});
const currentDisplayDate = ref('');
const loading = ref(false);

// 获取最新新闻
const fetchLatestNews = async () => {
  try {
    const data = await request.get('/api/4/news/latest');
    latestNews.value = data;
    currentDisplayDate.value = data.date;
    
    // 数据加载完成后触发滚动动画
    nextTick(() => {
      setupScrollAnimations();
    });
  } catch (error) {
    showToast('获取最新新闻失败');
    console.error('获取最新新闻失败:', error);
  }
};

// 获取指定日期之前的新闻
const fetchBeforeNews = async (date) => {
  if (loading.value) return;
  loading.value = true;
  try {
    const data = await request.get(`/api/4/news/before/${date}`);
    pastNews.value[data.date] = data;
    currentDisplayDate.value = data.date;
    
    // 新数据加载后触发动画
    nextTick(() => {
      setupScrollAnimations();
    });
  } catch (error) {
    showToast('获取往日新闻失败');
    console.error('获取往日新闻失败:', error);
  } finally {
    loading.value = false;
  }
};

// 加载更多新闻
const loadMoreNews = () => {
  if (currentDisplayDate.value) {
    const prevDate = getPreviousDay(currentDisplayDate.value);
    fetchBeforeNews(prevDate);
  }
};

// 跳转到新闻详情页
const goToDetail = (id) => {
  router.push(`/detail/${id}`);
};

// 跳转到个人中心页
const goToProfile = () => {
  router.push('/profile');
};

// 格式化日期显示
const formatDate = (dateStr) => {
  if (!dateStr || dateStr.length !== 8) return dateStr;
  const year = dateStr.substring(0, 4);
  const month = dateStr.substring(4, 6);
  const day = dateStr.substring(6, 8);
  return `${year}年${month}月${day}日`;
};

// 计算上一天的日期
const getPreviousDay = (dateStr) => {
  const year = parseInt(dateStr.substring(0, 4));
  const month = parseInt(dateStr.substring(4, 6)) - 1;
  const day = parseInt(dateStr.substring(6, 8));

  const date = new Date(year, month, day);
  date.setDate(date.getDate() - 1);

  const prevYear = date.getFullYear();
  const prevMonth = (date.getMonth() + 1).toString().padStart(2, '0');
  const prevDay = date.getDate().toString().padStart(2, '0');

  return `${prevYear}${prevMonth}${prevDay}`;
};

onMounted(() => {
  fetchLatestNews();
});
</script>

<style scoped>
.home-page {
  padding-top: 46px;
  padding-bottom: 20px;
}

.header {
  background-color: #fff;
  border-bottom: 1px solid #eee;
  padding-left: 12px;
  padding-right: 12px;
  animation-duration: 0.6s;
}

.logo {
  height: 45px;
  width: auto;
  margin-left: 5px;
  transition: all 0.3s ease;
  object-fit: contain;
  cursor: pointer;
  animation-duration: 1.5s;
}

.logo:hover {
  transform: scale(1.1);
  filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.2));
}

.header .van-icon {
  margin-right: 5px;
  transition: all 0.3s ease;
}

.header .van-icon:hover {
  transform: scale(1.2);
  color: #1989fa;
}

.content {
  padding: 10px;
}

.date-title {
  font-size: 18px;
  font-weight: bold;
  margin: 20px 0 10px 0;
  color: #333;
  padding-left: 10px;
  animation-duration: 0.5s;
}

.news-cover {
  width: 80px;
  height: 60px;
  object-fit: cover;
  border-radius: 4px;
  margin-left: 10px;
  transition: all 0.3s ease;
  animation-duration: 0.4s;
}

.news-cover:hover {
  transform: scale(1.1);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}

.van-cell-group {
  margin-bottom: 15px;
  overflow: hidden;
}

.news-card {
  transition: all 0.3s ease;
  margin-bottom: 8px;
  border-radius: 8px;
  overflow: hidden;
  opacity: 0;
  transform: translateY(20px);
}

.news-card.animate-on-scroll.active {
  opacity: 1;
  transform: translateY(0);
}

.news-card:hover {
  transform: translateY(-5px) !important;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
  background-color: #f9f9f9;
}

.van-cell {
  transition: all 0.3s ease;
  border-radius: 8px;
}

.van-cell:hover {
  background-color: #f5f7fa;
}

.load-more {
  margin-top: 30px;
  padding: 0 10px;
  opacity: 0;
  transform: translateY(20px);
}

.load-more.animate-on-scroll.active {
  opacity: 1;
  transform: translateY(0);
}

.btn-click:active {
  transform: scale(0.95);
}
</style>
EOF_HOME

# 更新NewsDetail.vue添加动画效果
echo "更新NewsDetail.vue添加动画效果..."
cat > src/views/NewsDetail.vue << 'EOF_DETAIL'
<!-- src/views/NewsDetail.vue -->
<template>
  <div class="news-detail fade-in">
    <van-nav-bar
      fixed
      title="新闻详情"
      left-arrow
      @click-left="onClickLeft"
      class="slide-left"
    >
      <template #right>
        <!-- 收藏图标 -->
        <van-icon
          :name="isCollected ? 'star' : 'star-o'"
          :color="isCollected ? '#ffd21e' : '#333'"
          size="22"
          @click="toggleCollect"
          class="hover-grow btn-click"
        />
        <!-- 评论和点赞图标 -->
        <span class="nav-extra-info bounce">
            <van-icon name="chat-o" size="20" /> {{ extraInfo.comments || 0 }}
        </span>
        <span class="nav-extra-info bounce">
            <van-icon name="good-job-o" size="20" /> {{ extraInfo.popularity || 0 }}
        </span>
      </template>
    </van-nav-bar>

    <div class="content" v-if="detail.body">
      <h1 class="title float-up">{{ detail.title }}</h1>
      <p class="image-source slide-right" v-if="detail.image_source">图片：{{ detail.image_source }}</p>
      
      <!-- 新闻内容 -->
      <div class="detail-body animate-on-scroll" v-html="detail.body"></div>

      <!-- 操作按钮组 -->
      <div class="action-buttons animate-on-scroll">
        <van-button 
          type="primary" 
          size="large" 
          @click="toggleCollect" 
          class="btn-click pulse"
        >
          <van-icon :name="isCollected ? 'star' : 'star-o'" />
          {{ isCollected ? '已收藏' : '收藏文章' }}
        </van-button>
      </div>
    </div>
    <div v-else class="loading-placeholder">
      <van-loading type="spinner" class="spin" /> 
      <span class="blink">加载中...</span>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import request from '@/utils/request';
import { showToast, showConfirmDialog } from 'vant';
import { setupScrollAnimations } from '@/utils/animations';

const route = useRoute();
const router = useRouter();
const newsId = computed(() => route.params.id);

const detail = ref({});
const extraInfo = ref({});
const collectedNewsIds = ref([]);

// 判断当前新闻是否已收藏
const isCollected = computed(() => {
  return collectedNewsIds.value.includes(parseInt(newsId.value));
});

// 返回上一页
const onClickLeft = () => {
  router.back();
};

// 获取新闻详情
const fetchNewsDetail = async () => {
  try {
    const data = await request.get(`/api/4/news/${newsId.value}`);
    detail.value = data;
    detail.value.body = detail.value.body.replace(/<img/g, '<img style="max-width:100%; height:auto;" class="zoom-in"');
    
    // 内容加载后触发动画
    setTimeout(() => {
      setupScrollAnimations();
    }, 100);
  } catch (error) {
    showToast('获取新闻详情失败');
    console.error('获取新闻详情失败:', error);
  }
};

// 获取新闻的评论和点赞数
const fetchStoryExtra = async () => {
  try {
    const data = await request.get(`/api/4/story-extra/${newsId.value}`);
    extraInfo.value = data;
  } catch (error) {
    showToast('获取评论和点赞信息失败');
    console.error('获取评论和点赞信息失败:', error);
  }
};

// 从本地存储加载收藏列表
const loadCollectedNews = () => {
  const storedIds = localStorage.getItem('collectedNewsIds');
  if (storedIds) {
    collectedNewsIds.value = JSON.parse(storedIds);
  } else {
    collectedNewsIds.value = [];
  }
};

// 保存收藏列表到本地存储
const saveCollectedNews = () => {
  localStorage.setItem('collectedNewsIds', JSON.stringify(collectedNewsIds.value));
};

// 检查用户登录状态
const checkLoginStatus = () => {
  return localStorage.getItem('isLoggedIn') === 'true';
};

// 收藏/取消收藏
const toggleCollect = () => {
  if (!checkLoginStatus()) {
    showConfirmDialog({
      title: '未登录',
      message: '请先登录才能收藏文章',
      confirmButtonText: '去登录',
      cancelButtonText: '取消',
    })
      .then(() => {
        router.push('/login');
      })
      .catch(() => {});
    return;
  }

  const id = parseInt(newsId.value);
  if (isCollected.value) {
    collectedNewsIds.value = collectedNewsIds.value.filter(item => item !== id);
    showToast('取消收藏');
  } else {
    collectedNewsIds.value.push(id);
    showToast('收藏成功');
  }
  saveCollectedNews();
};

// 监听路由参数变化
watch(newsId, (newId, oldId) => {
  if (newId !== oldId) {
    fetchNewsDetail();
    fetchStoryExtra();
    loadCollectedNews();
  }
});

onMounted(() => {
  fetchNewsDetail();
  fetchStoryExtra();
  loadCollectedNews();
});
</script>

<style>
.news-detail .detail-body img {
  max-width: 100%;
  height: auto;
  display: block;
  margin: 10px auto;
  border-radius: 8px;
  transition: all 0.3s ease;
}
.news-detail .detail-body img:hover {
  transform: scale(1.02);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
}
.news-detail .detail-body {
  padding: 15px;
  line-height: 1.6;
  font-size: 16px;
  color: #333;
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.6s ease;
}
.news-detail .detail-body.animate-on-scroll.active {
  opacity: 1;
  transform: translateY(0);
}
.news-detail .detail-body h2 {
  font-size: 22px;
  margin-top: 20px;
  margin-bottom: 10px;
  color: #2c3e50;
  border-left: 4px solid #1989fa;
  padding-left: 10px;
}
.news-detail .detail-body p {
  margin-bottom: 1em;
  animation: fadeIn 0.6s ease forwards;
}
</style>

<style scoped>
.news-detail {
  padding-top: 46px;
  animation-duration: 0.6s;
}

.title {
  font-size: 24px;
  font-weight: bold;
  padding: 15px;
  margin-bottom: 10px;
  color: #333;
  line-height: 1.4;
  animation-duration: 0.6s;
}

.image-source {
  font-size: 12px;
  color: #999;
  padding: 0 15px 10px;
  text-align: right;
  animation-duration: 0.7s;
}

.nav-extra-info {
  margin-left: 10px;
  font-size: 14px;
  color: #333;
  animation-duration: 1s;
}
.nav-extra-info .van-icon {
  vertical-align: middle;
  margin-right: 2px;
  transition: all 0.3s ease;
}
.nav-extra-info:hover .van-icon {
  transform: scale(1.2);
  color: #1989fa;
}

.loading-placeholder {
  text-align: center;
  padding: 50px;
  color: #999;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 20px;
}

.action-buttons {
  margin: 20px 15px;
  padding: 20px 0;
  border-top: 1px solid #eee;
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.6s ease;
}

.action-buttons.animate-on-scroll.active {
  opacity: 1;
  transform: translateY(0);
}

.van-button {
  transition: all 0.3s ease;
  border-radius: 8px;
  overflow: hidden;
}

.van-button:active {
  transform: scale(0.95);
}
</style>
EOF_DETAIL

# 更新其他页面的动画效果
echo "更新LoginPage.vue添加动画效果..."
cat > src/views/LoginPage.vue << 'EOF_LOGIN'
<!-- src/views/LoginPage.vue -->
<template>
  <div class="login-page fade-in">
    <van-nav-bar
      fixed
      title="登录"
      left-arrow
      @click-left="onClickLeft"
      class="slide-left"
    />

    <div class="login-form">
      <div class="logo-container animate-on-scroll">
        <van-image
          round
          width="100"
          height="100"
          src="https://fastly.jsdelivr.net/npm/@vant/assets/cat.jpeg"
          class="pulse"
        />
        <h2 class="welcome-text typewriter">欢迎回来</h2>
      </div>

      <van-form @submit="onSubmit" class="animate-on-scroll">
        <van-cell-group inset>
          <van-field
            v-model="phoneNumber"
            name="phoneNumber"
            label="手机号"
            placeholder="请输入手机号"
            :rules="[{ required: true, message: '请填写手机号' }, { pattern: /^1\d{10}$/, message: '手机号格式不正确' }]"
            class="float-up"
          />
          <van-field
            v-model="verificationCode"
            name="verificationCode"
            center
            clearable
            label="验证码"
            placeholder="请输入验证码"
            :rules="[{ required: true, message: '请填写验证码' }]"
            class="float-up"
          >
            <template #button>
              <van-button 
                size="small" 
                type="primary" 
                @click="generateCode" 
                class="btn-click bounce"
              >
                获取验证码
              </van-button>
            </template>
          </van-field>
        </van-cell-group>
        
        <div style="margin: 16px;">
          <van-button 
            round 
            block 
            type="primary" 
            native-type="submit" 
            class="btn-click pulse"
          >
            登录
          </van-button>
        </div>
      </van-form>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { showToast } from 'vant';
import { setupScrollAnimations } from '@/utils/animations';

const router = useRouter();
const phoneNumber = ref('');
const verificationCode = ref('');

// 返回上一页
const onClickLeft = () => {
  router.back();
};

// 生成并填写随机验证码
const generateCode = () => {
  const code = Math.floor(1000 + Math.random() * 9000).toString();
  verificationCode.value = code;
  showToast(`验证码已自动填写: ${code}`);
};

// 提交登录
const onSubmit = (values) => {
  console.log('提交表单', values);
  
  const userInfo = {
    phone: values.phoneNumber,
    name: `用户${values.phoneNumber.slice(-4)}`,
    avatar: 'https://fastly.jsdelivr.net/npm/@vant/assets/cat.jpeg',
    loginTime: new Date().toISOString()
  };
  
  localStorage.setItem('isLoggedIn', 'true');
  localStorage.setItem('userInfo', JSON.stringify(userInfo));
  
  showToast('登录成功');
  router.replace('/');
};

onMounted(() => {
  setTimeout(() => {
    setupScrollAnimations();
  }, 100);
});
</script>

<style scoped>
.login-page {
  padding-top: 46px;
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  animation-duration: 0.6s;
}

.login-form {
  margin-top: 20px;
  padding: 0 15px;
}

.logo-container {
  text-align: center;
  margin-bottom: 40px;
  padding-top: 20px;
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.6s ease;
}

.logo-container.animate-on-scroll.active {
  opacity: 1;
  transform: translateY(0);
}

.welcome-text {
  color: white;
  margin-top: 15px;
  font-size: 24px;
  font-weight: 300;
  overflow: hidden;
  border-right: 2px solid white;
  white-space: nowrap;
  animation: typing 3.5s steps(40, end), blink-caret 0.75s step-end infinite;
}

.van-form {
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.6s ease;
}

.van-form.animate-on-scroll.active {
  opacity: 1;
  transform: translateY(0);
}

.van-field {
  margin-bottom: 15px;
  border-radius: 8px;
  overflow: hidden;
  background: rgba(255, 255, 255, 0.9);
  animation-duration: 0.5s;
}

.van-field:hover {
  transform: translateX(5px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.van-button {
  transition: all 0.3s ease;
  border-radius: 25px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}

.van-button:active {
  transform: scale(0.95);
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
}

@keyframes typing {
  from { width: 0; }
  to { width: 100%; }
}

@keyframes blink-caret {
  from, to { border-color: transparent; }
  50% { border-color: white; }
}
</style>
EOF_LOGIN

# 更新ProfilePage.vue添加动画效果
echo "更新ProfilePage.vue添加动画效果..."
cat > src/views/ProfilePage.vue << 'EOF_PROFILE'
<!-- src/views/ProfilePage.vue -->
<template>
  <div class="profile-page fade-in">
    <van-nav-bar
      fixed
      title="个人中心"
      left-arrow
      @click-left="onClickLeft"
      class="slide-left"
    />

    <div class="profile-card">
      <div class="user-info animate-on-scroll">
        <van-image
          round
          width="100"
          height="100"
          :src="userAvatar"
          class="avatar heartbeat hover-grow"
          @click="showUploadOptions"
        />
        <h2 class="username float-up">{{ userName }}</h2>
        <p class="phone slide-right">{{ userPhone }}</p>
      </div>

      <van-cell-group inset class="animate-on-scroll">
        <van-cell
          title="头像"
          center
          @click="showUploadOptions"
          class="float-up btn-click"
        >
          <template #right-icon>
            <van-icon name="arrow" />
          </template>
        </van-cell>
        
        <van-cell
          title="用户名"
          center
          class="float-up btn-click"
        >
          <template #value>
            <van-field
              v-model="userName"
              placeholder="请输入用户名"
              :border="false"
              @blur="saveUserName"
              class="username-input"
            />
          </template>
        </van-cell>
        
        <van-cell
          title="手机号"
          :value="userPhone"
          class="float-up"
        />
        <van-cell
          title="我的收藏"
          is-link
          @click="goToFavorites"
          class="float-up btn-click"
        />
        <van-cell
          title="退出登录"
          @click="logout"
          clickable
          class="float-up btn-click shake"
        />
      </van-cell-group>
    </div>

    <!-- 头像上传选项弹窗 -->
    <van-action-sheet
      v-model:show="showUploadSheet"
      :actions="uploadActions"
      @select="onUploadSelect"
      cancel-text="取消"
      close-on-click-action
      class="zoom-in"
    />

    <!-- 文件上传input，隐藏 -->
    <input
      ref="fileInput"
      type="file"
      accept="image/*"
      style="display: none"
      @change="onFileChange"
    />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { showToast, showConfirmDialog, showImagePreview } from 'vant';
import { setupScrollAnimations } from '@/utils/animations';

const router = useRouter();
const userName = ref('');
const userPhone = ref('');
const userAvatar = ref('');
const showUploadSheet = ref(false);
const fileInput = ref(null);

// 上传选项
const uploadActions = ref([
  { name: '拍照' },
  { name: '从相册选择' },
  { name: '查看头像' }
]);

// 返回上一页
const onClickLeft = () => {
  router.back();
};

// 加载用户信息
const loadUserInfo = () => {
  const savedUser = localStorage.getItem('userInfo');
  if (savedUser) {
    const userInfo = JSON.parse(savedUser);
    userPhone.value = userInfo.phone || '未登录';
    userName.value = userInfo.name || '知乎用户';
    userAvatar.value = userInfo.avatar || 'https://fastly.jsdelivr.net/npm/@vant/assets/cat.jpeg';
  } else {
    const oldPhone = localStorage.getItem('userPhone');
    if (oldPhone) {
      const userInfo = {
        phone: oldPhone,
        name: `用户${oldPhone.slice(-4)}`,
        avatar: localStorage.getItem('userAvatar') || 'https://fastly.jsdelivr.net/npm/@vant/assets/cat.jpeg'
      };
      localStorage.setItem('userInfo', JSON.stringify(userInfo));
      localStorage.removeItem('userPhone');
      localStorage.removeItem('userAvatar');
      
      userPhone.value = userInfo.phone;
      userName.value = userInfo.name;
      userAvatar.value = userInfo.avatar;
    } else {
      userPhone.value = '未登录';
      userName.value = '知乎用户';
      userAvatar.value = 'https://fastly.jsdelivr.net/npm/@vant/assets/cat.jpeg';
    }
  }
};

// 显示上传选项
const showUploadOptions = () => {
  if (userPhone.value === '未登录') {
    showToast('请先登录');
    router.push('/login');
    return;
  }
  showUploadSheet.value = true;
};

// 处理上传选项选择
const onUploadSelect = (action) => {
  if (action.name === '拍照') {
    showToast('拍照功能需要真机调试');
  } else if (action.name === '从相册选择') {
    fileInput.value.click();
  } else if (action.name === '查看头像') {
    if (userAvatar.value) {
      showImagePreview([userAvatar.value]);
    }
  }
};

// 处理文件选择
const onFileChange = (event) => {
  const file = event.target.files[0];
  if (!file) return;

  if (!file.type.startsWith('image/')) {
    showToast('请选择图片文件');
    return;
  }

  if (file.size > 2 * 1024 * 1024) {
    showToast('图片大小不能超过2MB');
    return;
  }

  const reader = new FileReader();
  reader.onload = (e) => {
    const imageData = e.target.result;
    
    compressImage(imageData, (compressedData) => {
      saveAvatar(compressedData);
      userAvatar.value = compressedData;
      showToast('头像更新成功');
    });
  };
  reader.readAsDataURL(file);
  
  event.target.value = '';
};

// 图片压缩函数
const compressImage = (imageData, callback) => {
  const img = new Image();
  img.onload = () => {
    const canvas = document.createElement('canvas');
    const ctx = canvas.getContext('2d');
    
    const MAX_WIDTH = 200;
    const MAX_HEIGHT = 200;
    
    let width = img.width;
    let height = img.height;
    
    if (width > height) {
      if (width > MAX_WIDTH) {
        height *= MAX_WIDTH / width;
        width = MAX_WIDTH;
      }
    } else {
      if (height > MAX_HEIGHT) {
        width *= MAX_HEIGHT / height;
        height = MAX_HEIGHT;
      }
    }
    
    canvas.width = width;
    canvas.height = height;
    
    ctx.drawImage(img, 0, 0, width, height);
    
    const compressedData = canvas.toDataURL('image/jpeg', 0.8);
    callback(compressedData);
  };
  img.src = imageData;
};

// 保存头像到本地存储
const saveAvatar = (avatarData) => {
  const savedUser = localStorage.getItem('userInfo');
  let userInfo = savedUser ? JSON.parse(savedUser) : {};
  
  userInfo.avatar = avatarData;
  localStorage.setItem('userInfo', JSON.stringify(userInfo));
};

// 保存用户名
const saveUserName = () => {
  if (userPhone.value === '未登录') {
    showToast('请先登录');
    return;
  }
  
  if (userName.value.trim().length > 20) {
    showToast('用户名不能超过20个字符');
    userName.value = userName.value.substring(0, 20);
    return;
  }
  
  const savedUser = localStorage.getItem('userInfo');
  let userInfo = savedUser ? JSON.parse(savedUser) : {};
  userInfo.name = userName.value.trim();
  localStorage.setItem('userInfo', JSON.stringify(userInfo));
  showToast('用户名已保存');
};

// 跳转到收藏列表
const goToFavorites = () => {
  if (userPhone.value === '未登录') {
    showToast('请先登录');
    router.push('/login');
    return;
  }
  router.push('/favorites');
};

// 退出登录
const logout = () => {
  showConfirmDialog({
    title: '退出登录',
    message: '确定要退出登录吗？',
  })
    .then(() => {
      localStorage.removeItem('isLoggedIn');
      localStorage.removeItem('userInfo');
      showToast('已退出登录');
      userPhone.value = '未登录';
      userName.value = '知乎用户';
      userAvatar.value = 'https://fastly.jsdelivr.net/npm/@vant/assets/cat.jpeg';
      router.replace('/');
    })
    .catch(() => {});
};

onMounted(() => {
  loadUserInfo();
  setTimeout(() => {
    setupScrollAnimations();
  }, 100);
});
</script>

<style scoped>
.profile-page {
  padding-top: 46px;
  min-height: 100vh;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  animation-duration: 0.6s;
}

.profile-card {
  margin-top: 20px;
}

.user-info {
  text-align: center;
  padding: 30px 20px;
  background: white;
  margin: 0 15px 20px 15px;
  border-radius: 15px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.6s ease;
}

.user-info.animate-on-scroll.active {
  opacity: 1;
  transform: translateY(0);
}

.avatar {
  border: 4px solid #1989fa;
  box-shadow: 0 4px 12px rgba(25, 137, 250, 0.3);
  animation-duration: 1.5s;
  cursor: pointer;
  transition: all 0.3s ease;
}

.avatar:hover {
  transform: scale(1.1) rotate(5deg);
  box-shadow: 0 8px 20px rgba(25, 137, 250, 0.5);
}

.username {
  font-size: 24px;
  font-weight: bold;
  margin: 15px 0 5px 0;
  color: #333;
  animation-duration: 0.6s;
}

.phone {
  color: #666;
  font-size: 16px;
  animation-duration: 0.7s;
}

.van-cell-group {
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.6s ease;
  border-radius: 15px;
  overflow: hidden;
  margin: 0 15px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.van-cell-group.animate-on-scroll.active {
  opacity: 1;
  transform: translateY(0);
}

.van-cell {
  padding: 15px 16px;
  transition: all 0.3s ease;
  animation-duration: 0.5s;
}

.van-cell:hover {
  background-color: #f5f7fa;
  transform: translateX(5px);
}

.btn-click:active {
  transform: scale(0.95);
}

.username-input {
  text-align: right;
  padding: 0;
}

.username-input:focus {
  transform: translateX(-5px);
}
</style>
EOF_PROFILE

echo ""
echo "===================================================="
echo "动画增强完成！"
echo "===================================================="
echo "已添加的动画功能："
echo "1. 全局动画CSS文件 (25种动画效果)"
echo "2. 动画工具函数 (滚动检测、波纹效果等)"
echo "3. 路由过渡动画 (页面切换效果)"
echo "4. 首页动画 (Logo心跳、卡片上浮、延迟加载)"
echo "5. 新闻详情页动画 (内容渐入、图片缩放、按钮效果)"
echo "6. 登录页动画 (背景渐变、打字机效果、表单动画)"
echo "7. 个人中心动画 (头像心跳、卡片滑动、悬停效果)"
echo ""
echo "主要动画效果包括："
echo "- fade-in (渐入)"
echo "- float-up (上浮)"
echo "- slide-left/right (左右滑入)"
echo "- zoom-in (缩放进入)"
echo "- bounce (弹跳)"
echo "- pulse (脉动)"
echo "- spin (旋转)"
echo "- heartbeat (心跳)"
echo "- hover-grow (悬停放大)"
echo "- ripple (点击波纹)"
echo "- typewriter (打字机效果)"
echo "- 滚动触发动画"
echo ""
echo "使用说明："
echo "1. 在元素上添加对应的CSS类即可使用动画"
echo "2. 滚动到视口时自动触发动画"
echo "3. 支持延迟动画 (.delay-1 到 .delay-10)"
echo "4. 支持动画持续时间控制 (.duration-fast 等)"
echo ""
echo "请重启开发服务器查看效果："
echo "npm run dev"
echo ""
echo "注意：如果觉得动画过多，可以适当移除一些动画类"
echo "===================================================="