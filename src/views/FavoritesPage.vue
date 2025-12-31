<!-- src/views/FavoritesPage.vue -->
<template>
  <div class="favorites-page">
    <van-nav-bar
      fixed
      title="我的收藏"
      left-arrow
      @click-left="onClickLeft"
    />

    <div class="content">
      <van-cell-group inset v-if="favoriteNewsList.length">
        <van-cell
          v-for="news in favoriteNewsList"
          :key="news.id"
          :title="news.title"
          is-link
          @click="goToDetail(news.id)"
        >
          <template #right-icon>
            <img :src="news.image" class="news-cover" v-if="news.image"/>
          </template>
        </van-cell>
      </van-cell-group>
      <van-empty v-else description="暂无收藏新闻" />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import request from '@/utils/request';
import { showToast } from 'vant';

const router = useRouter();
const favoriteNewsList = ref([]); // 存储收藏新闻的详细信息

// 返回上一页
const onClickLeft = () => {
  router.back();
};

// 从本地存储获取收藏的ID列表，并逐个请求新闻详情
const fetchFavoriteNews = async () => {
  const storedIds = localStorage.getItem('collectedNewsIds');
  if (!storedIds) {
    favoriteNewsList.value = [];
    return;
  }

  const collectedIds = JSON.parse(storedIds);
  if (collectedIds.length === 0) {
    favoriteNewsList.value = [];
    return;
  }

  const newsPromises = collectedIds.map(async (id) => {
    try {
      // 严格使用您提供的新闻详情接口
      const data = await request.get(`/api/4/news/${id}`);
      // 为了在收藏列表显示标题和图片，我们只取关键信息
      return {
        id: data.id,
        title: data.title,
        image: data.images && data.images.length ? data.images[0] : '' // 使用第一张图片
      };
    } catch (error) {
      console.error(`获取收藏新闻 ${id} 详情失败:`, error);
      showToast(`获取收藏新闻 ${id} 失败`); // 提示具体失败的新闻
      return null; // 如果某个新闻获取失败，返回null
    }
  });

  // 等待所有请求完成，并过滤掉失败的请求
  const results = await Promise.all(newsPromises);
  favoriteNewsList.value = results.filter(news => news !== null);
};

// 跳转到新闻详情页
const goToDetail = (id) => {
  router.push(`/detail/${id}`);
};

onMounted(() => {
  fetchFavoriteNews();
});
</script>

<style scoped>
.favorites-page {
  padding-top: 46px; /* 留出 fixed header 的空间 */
}

.content {
  margin-top: 20px;
}

.news-cover {
  width: 80px;
  height: 60px;
  object-fit: cover;
  border-radius: 4px;
  margin-left: 10px;
}
</style>
