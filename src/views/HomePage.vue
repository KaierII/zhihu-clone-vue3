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
      <!-- 今天的日报 -->
      <div v-if="latestNews.stories && latestNews.stories.length" class="animate-on-scroll">
        <h2 class="date-title float-up">
          {{ formatDate(latestNews.date) }} 
        </h2>
        <van-cell-group inset>
          <van-cell
            v-for="(story, index) in latestNews.stories"
            :key="story.id"
            :title="story.title"
            is-link
            @click="goToDetail(story.id)"
            @keydown.enter="goToDetail(story.id)"
            tabindex="0"
            class="news-card animate-on-scroll"
            :style="{ animationDelay: index * 0.1 + 's' }"
          >
            <template #right-icon>
              <img
                :src="story.images?.[0]"
                class="news-cover zoom-in lazy-image"
                v-if="story.images && story.images.length"
                @load="onImageLoad"
              />
            </template>
          </van-cell>
        </van-cell-group>
      </div>

      <!-- 往日新闻列表（按时间倒序：新 → 旧）-->
      <div
        v-for="(dailyNews, index) in pastNews"
        :key="dailyNews.date"
        class="animate-on-scroll"
      >
        <h2
          class="date-title float-up"
          :style="{ animationDelay: index * 0.2 + 's' }"
        >
          {{ formatDate(dailyNews.date) }} 
        </h2>
        <van-cell-group inset>
          <van-cell
            v-for="(story, storyIndex) in dailyNews.stories"
            :key="story.id"
            :title="story.title"
            is-link
            @click="goToDetail(story.id)"
            @keydown.enter="goToDetail(story.id)"
            tabindex="0"
            class="news-card animate-on-scroll"
            :style="{ animationDelay: (index * 0.2 + storyIndex * 0.1) + 's' }"
          >
            <template #right-icon>
              <img
                :src="story.images?.[0]"
                class="news-cover zoom-in lazy-image"
                v-if="story.images && story.images.length"
                @load="onImageLoad"
              />
            </template>
          </van-cell>
        </van-cell-group>
      </div>

      <!-- 加载更多 / 底部提示 -->
      <div class="load-more animate-on-scroll">
        <van-button
          v-if="!hasNoMore"
          type="default"
          block
          @click="loadMoreNews"
          :loading="loading"
          class="btn-click pulse"
        >
          {{ loading ? '加载中...' : '加载更早新闻' }}
        </van-button>
        <div v-else class="no-more-text">没有更多了</div>
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
const pastNews = ref([]);
const currentDisplayDate = ref('');
const loading = ref(false);
const hasNoMore = ref(false);
const loadedDates = new Set();

const onImageLoad = (e) => {
  e.target.classList.add('loaded');
};

// 获取最新日报
const fetchLatestNews = async () => {
  try {
    const data = await request.get('/api/4/news/latest');
    latestNews.value = data;
    currentDisplayDate.value = data.date;
    loadedDates.add(data.date);

    nextTick(() => {
      setupScrollAnimations();
    });
  } catch (error) {
    showToast('获取最新日报失败');
    console.error('获取最新日报失败:', error);
  }
};

// 获取指定日期之前的日报
const fetchBeforeNews = async (date) => {
  if (loading.value || loadedDates.has(date)) return;

  loading.value = true;
  try {
    const data = await request.get(`/api/4/news/before/${date}`);

    if (!data?.stories || data.stories.length === 0) {
      hasNoMore.value = true;
      return;
    }

    if (loadedDates.has(data.date)) {
      hasNoMore.value = true;
      return;
    }

    pastNews.value.push(data);
    loadedDates.add(data.date);

    pastNews.value.sort((a, b) => parseInt(b.date) - parseInt(a.date));
    currentDisplayDate.value = pastNews.value[pastNews.value.length - 1]?.date || '';

    nextTick(() => {
      setupScrollAnimations();
    });
  } catch (error) {
    showToast('获取往日日报失败');
    console.error('获取往日日报失败:', error);
    hasNoMore.value = true;
  } finally {
    loading.value = false;
  }
};

const loadMoreNews = () => {
  if (loading.value || !currentDisplayDate.value || hasNoMore.value) return;
  const prevDate = getPreviousDay(currentDisplayDate.value);
  if (!prevDate) {
    hasNoMore.value = true;
    return;
  }
  fetchBeforeNews(prevDate);
};

const goToDetail = (id) => {
  router.push(`/detail/${id}`);
};

const goToProfile = () => {
  router.push('/profile');
};

const formatDate = (dateStr) => {
  if (!dateStr || dateStr.length !== 8) return dateStr;
  const year = dateStr.substring(0, 4);
  const month = dateStr.substring(4, 6);
  const day = dateStr.substring(6, 8);
  return `${year}年${month}月${day}日`;
};

const getPreviousDay = (dateStr) => {
  if (!/^\d{8}$/.test(dateStr)) return null;
  const year = parseInt(dateStr.substring(0, 4), 10);
  const month = parseInt(dateStr.substring(4, 6), 10) - 1;
  const day = parseInt(dateStr.substring(6, 8), 10);
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
/* 全局字体设置：使用系统默认无衬线字体，更现代 */
:root {
  --font-sans: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto,
    'Helvetica Neue', Arial, sans-serif;
}

.home-page {
  padding-top: 46px;
  padding-bottom: 30px;
  background: linear-gradient(135deg, #f5f7fa 0%, #e4edf9 100%);
  min-height: 100vh;
  font-family: var(--font-sans);
  line-height: 1.6;
}

.header {
  background-color: #ffffff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  border-bottom: 1px solid #eee;
  padding-left: 12px;
  padding-right: 12px;
  animation-duration: 0.6s;
}

.logo {
  height: 50px;
  width: auto;
  margin-left: 8px;
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
  color: #0084ff;
}

.content {
  padding: 12px;
  perspective: 1000px; /* 启用 3D 空间 */
}

.date-title {
  margin: clamp(20px, 5vw, 32px) 0 clamp(10px, 3vw, 16px) 0;
  background: linear-gradient(90deg, #0084ff, #00c6ff);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
  font-weight: 700;
  letter-spacing: -0.5px;
  font-size: 18px;
  line-height: 1.3;
}

.van-cell-group {
  margin-bottom: clamp(16px, 4vw, 24px);
  overflow: hidden;
}

.news-card {
  background: rgba(255, 255, 255, 0.85);
  -webkit-backdrop-filter: blur(8px);
  backdrop-filter: blur(8px);
  border: 1px solid rgba(220, 228, 240, 0.6);
  border-radius: 12px;
  overflow: hidden;
  opacity: 0;
  transform: translateY(20px);
  transition: 
    transform 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275),
    box-shadow 0.3s ease,
    opacity 0.3s ease;
  min-height: 72px;
}

.news-card.animate-on-scroll.active {
  opacity: 1;
  transform: translateY(0);
}

.news-card:hover {
  transform: translateY(-6px) rotateX(2deg) rotateY(2deg) !important;
  box-shadow: 0 6px 16px rgba(0, 132, 255, 0.12);
}

.van-cell__title {
  font-weight: 500 !important;
  color: #1d1d1d !important;
  font-size: 15px !important;
  line-height: 1.4 !important;
  max-width: calc(100% - 90px);
}

.van-cell {
  padding: 14px 12px !important;
  min-height: 72px;
}

.news-cover {
  opacity: 0;
  width: 80px;
  height: 60px;
  object-fit: cover;
  border-radius: 8px;
  margin-left: 12px;
  transition: opacity 0.4s ease, transform 0.3s ease;
  flex-shrink: 0;
}

.news-cover.loaded {
  opacity: 1;
}

.news-cover:hover {
  transform: scale(1.08);
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
}

.load-more {
  margin-top: 32px;
  padding: 0 12px;
  opacity: 0;
  transform: translateY(20px);
  text-align: center;
}

.load-more.animate-on-scroll.active {
  opacity: 1;
  transform: translateY(0);
}

.no-more-text {
  text-align: center;
  color: #888;
  font-size: 14px;
  padding: 16px;
  font-weight: 400;
}

.van-button {
  background-color: #0084ff !important;
  border-color: #0084ff !important;
  color: white !important;
  font-weight: 500 !important;
  height: 44px !important;
  border-radius: 22px !important;
  box-shadow: 0 2px 6px rgba(0, 132, 255, 0.2) !important;
}

.van-button:active {
  background-color: #0066cc !important;
  transform: scale(0.98) !important;
}

.fade-in {
  opacity: 0;
  animation: fadeIn 0.6s forwards;
}

@keyframes fadeIn {
  to { opacity: 1; }
}
</style>