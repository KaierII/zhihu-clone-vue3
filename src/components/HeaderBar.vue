<template>
  <van-nav-bar :title="title" fixed z-index="999">
    <template #left v-if="showUserIcon">
      <van-image round width="28" height="28" :src="userStore.avatar" @click="goToUserCenter" />
    </template>
  </van-nav-bar>
</template>

<script setup lang="js">
import { useRouter } from 'vue-router'
import { useUserStore } from '../store/user'

const props = defineProps({
  title: {
    type: String,
    default: '知乎日报',
  },
  showUserIcon: {
    type: Boolean,
    default: false, // 默认不显示用户头像
  },
})

const router = useRouter()
const userStore = useUserStore()

const goToUserCenter = () => {
  router.push('/user')
}
</script>

<style scoped>
/* 确保NavBar背景色和阴影在全局样式中统一 */
</style>
