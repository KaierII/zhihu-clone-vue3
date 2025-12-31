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
