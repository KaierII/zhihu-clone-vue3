<template>
  <div class="detail-page">
    <van-nav-bar title="新闻详情" left-arrow @click-left="onClickLeft" fixed z-index="999">
      <template #right>
        <van-icon
          :name="isFavorited ? 'star' : 'star-o'"
          size="20"
          @click="toggleFavorite"
          :color="isFavorited ? '#1989fa' : '#333'"
        />
      </template>
    </van-nav-bar>

    <div class="detail-content" v-if="newsDetail">
      <h1 class="title">{{ newsDetail.title }}</h1>
      <div
        class="image-wrapper"
        v-if="newsDetail.image || (newsDetail.images && newsDetail.images[0])"
      >
        <img
          :src="newsDetail.image || (newsDetail.images && newsDetail.images[0])"
          alt="新闻图片"
          class="news-image"
        />
        <div class="image-source" v-if="newsDetail.image_source">{{ newsDetail.image_source }}</div>
      </div>
      <div class="body-html" v-html="newsDetail.body"></div>

      <div class="extra-info" v-if="storyExtra">
        <span>评论: {{ storyExtra.comments }}</span>
        <span style="margin-left: 20px">点赞: {{ storyExtra.popularity }}</span>
      </div>
    </div>
    <van-loading v-else type="spinner" style="text-align: center; margin-top: 50px"
      >加载中...</van-loading
    >
  </div>
</template>

<script setup lang="js">
import { ref, onMounted, computed } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { showToast, showConfirmDialog } from 'vant';
import * as zhihuApi from '../api/zhihu';
import { useUserStore } from '../store/user';

const route = useRoute();
const router = useRouter();
const userStore = useUserStore();

const newsId = route.params.id;
const newsDetail = ref(null);
const storyExtra = ref(null);

// 计算属性：判断当前新闻是否已收藏
const isFavorited = computed(() => {
  return userStore.favorites.some(item => String(item.id) === String(newsId));
});

const fetchNewsDetail = async () => {
  try {
    const detailRes = await zhihuApi.getNewsDetail(newsId);
    newsDetail.value = detailRes;

    const extraRes = await zhihuApi.getStoryExtra(newsId);
    storyExtra.value = extraRes;
  } catch (error) {
    console.error('获取新闻详情失败:', error);
    showToast('获取新闻详情失败');
  }
};

const toggleFavorite = async () => {
  if (!userStore.isLoggedIn) {
    showConfirmDialog({
      title: '未登录',
      message: '收藏功能需要登录后才能使用，是否前往登录？',
    })
      .then(() => {
        router.push('/login');
      })
      .catch(() => {
        // on cancel
      });
    return;
  }

  if (isFavorited.value) {
    userStore.removeFavorite(newsId);
    showToast('取消收藏成功');
  } else {
    // 收藏时保存新闻的关键信息，以便收藏列表显示
    userStore.addFavorite({
      id: newsId,
      title: newsDetail.value.title,
      image: newsDetail.value.image || (newsDetail.value.images && newsDetail.value.images[0]), // 知乎API返回可能不同
    });
    showToast('收藏成功');
  }
};

const onClickLeft = () => {
  router.back();
};

onMounted(() => {
  fetchNewsDetail();
});
</script>

<style scoped>
.detail-page {
  padding-top: var(--van-nav-bar-height); /* 适配顶部导航栏 */
  min-height: 100vh;
  background-color: #fff;
}
.detail-content {
  padding: 15px;
}
.title {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 15px;
  line-height: 1.4;
  color: #333;
}
.image-wrapper {
  position: relative;
  width: 100%;
  padding-bottom: 56.25%; /* 16:9 比例 */
  height: 0;
  overflow: hidden;
  margin-bottom: 15px;
  border-radius: 8px;
}
.news-image {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.image-source {
  position: absolute;
  bottom: 5px;
  right: 10px;
  font-size: 12px;
  color: #eee;
  background-color: rgba(0, 0, 0, 0.4);
  padding: 2px 5px;
  border-radius: 3px;
}

/* 富文本内容样式调整 */
/* 注意：这里需要对 v-html 渲染的内容进行样式重置，以避免知乎日报自带样式污染 */
.body-html {
  line-height: 1.8;
  color: #444;
  font-size: 16px;
  overflow-x: hidden; /* 防止富文本中的超宽内容撑开页面 */
}
.body-html :deep(img) {
  max-width: 100% !important; /* 强制图片自适应 */
  height: auto !important; /* 覆盖行内样式，避免图片过大 */
  display: block;
  margin: 10px auto;
  border-radius: 8px;
}
.body-html :deep(h2),
.body-html :deep(h3),
.body-html :deep(h4) {
  margin-top: 1.5em;
  margin-bottom: 0.8em;
  font-weight: bold;
  color: #333;
  line-height: 1.4;
}
.body-html :deep(p) {
  margin-bottom: 1em;
  line-height: 1.8;
  color: #444;
  font-size: 16px;
}
.body-html :deep(a) {
  color: var(--van-primary-color);
  text-decoration: none;
}
.body-html :deep(blockquote) {
  margin: 1em 0;
  padding-left: 1em;
  border-left: 4px solid #eee;
  color: #666;
}
.body-html :deep(ul),
.body-html :deep(ol) {
  padding-left: 1.5em;
  margin-bottom: 1em;
}
.body-html :deep(li) {
  margin-bottom: 0.5em;
}

.extra-info {
  margin-top: 20px;
  padding: 15px;
  border-top: 1px solid #eee;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  font-size: 14px;
  color: #666;
}
</style>
