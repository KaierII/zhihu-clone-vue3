<template>
  <van-card
    class="news-card"
    :desc="news.hint"
    :title="news.title"
    :thumb="news.image || (news.images && news.images[0])"
  >
    <!-- 可以根据需要添加其他内容到卡片插槽 -->
    <template #footer>
      <slot name="footer"></slot>
    </template>
  </van-card>
</template>

<script setup lang="js">
import { defineProps } from 'vue'

const props = defineProps({
  news: {
    type: Object,
    required: true,
    default: () => ({}),
  },
})
</script>

<style scoped>
.news-card {
  margin-bottom: 10px;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  background-color: #fff;
}
.news-card :deep(.van-card__thumb) {
  width: 100px; /* 图片宽度 */
  height: 80px; /* 图片高度 */
  border-radius: 4px;
  overflow: hidden;
}
.news-card :deep(.van-card__img) {
  height: 100%;
  width: 100%;
  object-fit: cover;
}
.news-card :deep(.van-card__title) {
  font-size: 16px;
  line-height: 1.4;
  font-weight: bold;
  margin-bottom: 5px;
  max-height: 2.8em; /* 限制标题行数 */
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2; /* 限制标题显示两行 */
  -webkit-box-orient: vertical;
}
.news-card :deep(.van-card__desc) {
  font-size: 13px;
  color: #999;
  max-height: 1.3em;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
</style>
