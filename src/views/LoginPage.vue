<!-- src/views/LoginPage.vue -->
<template>
  <div class="login-page fade-in">
    <van-nav-bar
      fixed
      title="登录"
      left-arrow
      @click-left="onClickLeft"
      class="slide-left"
    />

    <div class="login-form">
      <div class="logo-container animate-on-scroll">
        <van-image
          round
          width="100"
          height="100"
          src="https://fastly.jsdelivr.net/npm/@vant/assets/cat.jpeg"
          class="pulse"
        />
        <h2 class="welcome-text typewriter">欢迎回来</h2>
      </div>

      <van-form @submit="onSubmit" class="animate-on-scroll">
        <van-cell-group inset>
          <van-field
            v-model="phoneNumber"
            name="phoneNumber"
            label="手机号"
            placeholder="请输入手机号"
            :rules="[{ required: true, message: '请填写手机号' }, { pattern: /^1\d{10}$/, message: '手机号格式不正确' }]"
            class="float-up"
          />
          <van-field
            v-model="verificationCode"
            name="verificationCode"
            center
            clearable
            label="验证码"
            placeholder="请输入验证码"
            :rules="[{ required: true, message: '请填写验证码' }]"
            class="float-up"
          >
            <template #button>
              <van-button 
                size="small" 
                type="primary" 
                @click="generateCode" 
                class="btn-click bounce"
              >
                获取验证码
              </van-button>
            </template>
          </van-field>
        </van-cell-group>
        
        <div style="margin: 16px;">
          <van-button 
            round 
            block 
            type="primary" 
            native-type="submit" 
            class="btn-click pulse"
          >
            登录
          </van-button>
        </div>
      </van-form>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { showToast } from 'vant';
import { setupScrollAnimations } from '@/utils/animations';

const router = useRouter();
const phoneNumber = ref('');
const verificationCode = ref('');

// 返回上一页
const onClickLeft = () => {
  router.back();
};

// 生成并填写随机验证码
const generateCode = () => {
  const code = Math.floor(1000 + Math.random() * 9000).toString();
  verificationCode.value = code;
  showToast(`验证码已自动填写: ${code}`);
};

// 提交登录
const onSubmit = (values) => {
  console.log('提交表单', values);
  
  const userInfo = {
    phone: values.phoneNumber,
    name: `用户${values.phoneNumber.slice(-4)}`,
    avatar: 'https://fastly.jsdelivr.net/npm/@vant/assets/cat.jpeg',
    loginTime: new Date().toISOString()
  };
  
  localStorage.setItem('isLoggedIn', 'true');
  localStorage.setItem('userInfo', JSON.stringify(userInfo));
  
  showToast('登录成功');
  router.replace('/');
};

onMounted(() => {
  setTimeout(() => {
    setupScrollAnimations();
  }, 100);
});
</script>

<style scoped>
.login-page {
  padding-top: 46px;
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  animation-duration: 0.6s;
}

.login-form {
  margin-top: 20px;
  padding: 0 15px;
}

.logo-container {
  text-align: center;
  margin-bottom: 40px;
  padding-top: 20px;
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.6s ease;
}

.logo-container.animate-on-scroll.active {
  opacity: 1;
  transform: translateY(0);
}

.welcome-text {
  color: white;
  margin-top: 15px;
  font-size: 24px;
  font-weight: 300;
  overflow: hidden;
  border-right: 2px solid white;
  white-space: nowrap;
  animation: typing 3.5s steps(40, end), blink-caret 0.75s step-end infinite;
}

.van-form {
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.6s ease;
}

.van-form.animate-on-scroll.active {
  opacity: 1;
  transform: translateY(0);
}

.van-field {
  margin-bottom: 15px;
  border-radius: 8px;
  overflow: hidden;
  background: rgba(255, 255, 255, 0.9);
  animation-duration: 0.5s;
}

.van-field:hover {
  transform: translateX(5px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.van-button {
  transition: all 0.3s ease;
  border-radius: 25px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}

.van-button:active {
  transform: scale(0.95);
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
}

@keyframes typing {
  from { width: 0; }
  to { width: 100%; }
}

@keyframes blink-caret {
  from, to { border-color: transparent; }
  50% { border-color: white; }
}
</style>
