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
