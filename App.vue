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
