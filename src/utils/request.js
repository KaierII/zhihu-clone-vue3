// src/utils/request.js
import axios from 'axios'
import { showToast } from 'vant'

const request = axios.create({
  baseURL: import.meta.env.VITE_APP_BASE_API || '/api', // Vite配置的代理前缀
  timeout: 10000, // 请求超时时间
})

// 请求拦截器
request.interceptors.request.use(
  (config) => {
    // 可以在这里添加token等
    return config
  },
  (error) => {
    console.error('请求错误:', error)
    showToast('网络请求失败')
    return Promise.reject(error)
  },
)

// 响应拦截器
request.interceptors.response.use(
  (response) => {
    const res = response.data
    // 根据实际后端接口设计进行判断
    // 知乎日报API直接返回数据，无需额外处理状态码
    return res
  },
  (error) => {
    console.error('响应错误:', error)
    showToast(error.message || '服务器响应异常')
    return Promise.reject(error)
  },
)

export default request
