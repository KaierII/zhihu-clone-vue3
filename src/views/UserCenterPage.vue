<template>
  <div class="user-center-page">
    <van-nav-bar title="个人中心" left-arrow @click-left="onClickLeft" fixed z-index="999" />

    <div class="user-info">
      <van-image
        round
        width="80"
        height="80"
        :src="userStore.avatar || 'https://fastly.jsdelivr.net/npm/@vant/assets/cat.jpeg'"
      />
      <div class="phone-number">手机号: {{ userStore.phoneNumber || '未登录' }}</div>
    </div>

    <van-cell-group inset>
      <van-cell title="我的收藏" is-link @click="goToFavorites" />
    </van-cell-group>

    <div style="margin: 16px">
      <van-button round block type="danger" @click="logout"> 退出登录 </van-button>
    </div>

    <van-tabbar v-model="activeTab" active-color="#1989fa" inactive-color="#000">
      <van-tabbar-item icon="wap-home-o" to="/">首页</van-tabbar-item>
      <van-tabbar-item icon="star-o" to="/favorites">收藏</van-tabbar-item>
      <van-tabbar-item icon="manager-o" to="/user">我的</van-tabbar-item>
    </van-tabbar>
  </div>
</template>

<script setup lang="js">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { showToast, showConfirmDialog } from 'vant'
import { useUserStore } from '../store/user'

const router = useRouter()
const userStore = useUserStore()
const activeTab = ref(2) // 底部导航栏选中“我的”

const onClickLeft = () => {
  router.back()
}

const goToFavorites = () => {
  router.push('/favorites')
}

const logout = () => {
  showConfirmDialog({
    title: '退出登录',
    message: '确定要退出登录吗？',
  })
    .then(() => {
      userStore.logout()
      showToast('已退出登录')
      router.replace('/login') // 退出后跳转到登录页
    })
    .catch(() => {
      // on cancel
    })
}
</script>

<style scoped>
.user-center-page {
  padding-top: var(--van-nav-bar-height); /* 适配顶部导航栏 */
  padding-bottom: var(--van-tabbar-height); /* 适配底部标签栏 */
  min-height: 100vh;
  background-color: #f7f8fa;
}
.user-info {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 30px 0;
  background-color: #fff;
  margin-bottom: 20px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  border-bottom-left-radius: 8px;
  border-bottom-right-radius: 8px;
}
.phone-number {
  margin-top: 15px;
  font-size: 16px;
  color: #333;
}
</style>
