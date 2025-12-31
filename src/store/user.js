import { defineStore } from 'pinia'
import { ref, watch } from 'vue'

// 辅助函数：从localStorage加载数据
function loadFromLocalStorage(key, defaultValue) {
  try {
    const item = localStorage.getItem(key)
    return item ? JSON.parse(item) : defaultValue
  } catch (e) {
    console.error(`Error reading from localStorage key "${key}":`, e)
    return defaultValue
  }
}

// 辅助函数：保存数据到localStorage
function saveToLocalStorage(key, value) {
  try {
    localStorage.setItem(key, JSON.stringify(value))
  } catch (e) {
    console.error(`Error writing to localStorage key "${key}":`, e)
  }
}

export const useUserStore = defineStore('user', () => {
  const isLoggedIn = ref(loadFromLocalStorage('isLoggedIn', false))
  const phoneNumber = ref(loadFromLocalStorage('phoneNumber', ''))
  const avatar = ref(
    loadFromLocalStorage('avatar', 'https://fastly.jsdelivr.net/npm/@vant/assets/cat.jpeg'),
  ) // 默认头像
  const favorites = ref(loadFromLocalStorage('favorites', [])) // 收藏列表: [{ id, title, image }]

  // 监听状态变化并保存到 localStorage
  watch(isLoggedIn, (newValue) => saveToLocalStorage('isLoggedIn', newValue))
  watch(phoneNumber, (newValue) => saveToLocalStorage('phoneNumber', newValue))
  watch(avatar, (newValue) => saveToLocalStorage('avatar', newValue))
  watch(favorites, (newValue) => saveToLocalStorage('favorites', newValue), { deep: true })

  // 模拟登录
  const login = (phone, code) => {
    return new Promise((resolve) => {
      setTimeout(() => {
        if (code && phone) {
          // 简单模拟，实际应有后端验证
          isLoggedIn.value = true
          phoneNumber.value = phone
          // TODO: 替换 'YOUR_API_KEY' 为您自己的 Multiavatar API Key 或使用固定头像
          avatar.value = `https://api.multiavatar.com/${phone}.png?apikey=YOUR_API_KEY`
          resolve(true)
        } else {
          resolve(false)
        }
      }, 500)
    })
  }

  // 退出登录
  const logout = () => {
    isLoggedIn.value = false
    phoneNumber.value = ''
    avatar.value = 'https://fastly.jsdelivr.net/npm/@vant/assets/cat.jpeg'
    favorites.value = [] // 清空收藏
    localStorage.clear() // 清空所有本地存储的用户相关数据
  }

  // 添加收藏
  const addFavorite = (newsItem) => {
    // 避免重复收藏
    if (!favorites.value.some((item) => String(item.id) === String(newsItem.id))) {
      favorites.value.push(newsItem)
    }
  }

  // 移除收藏
  const removeFavorite = (newsId) => {
    favorites.value = favorites.value.filter((item) => String(item.id) !== String(newsId))
  }

  return {
    isLoggedIn,
    phoneNumber,
    avatar,
    favorites,
    login,
    logout,
    addFavorite,
    removeFavorite,
  }
})
