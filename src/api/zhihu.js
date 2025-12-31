// src/api/zhihu.js
import request from '../utils/request';

// 获取最新新闻
export function getLatestNews() {
  return request.get('/4/news/latest'); 
}

// 获取往日新闻 (日期格式 YYYYMMDD)
export function getBeforeNews(date) {
  return request.get(`/4/news/before/${date}`); 
}

// 获取新闻详情
export function getNewsDetail(id) {
  return request.get(`/4/news/${id}`); 
}

// 获取新闻额外信息 (评论数、点赞数)
export function getStoryExtra(id) {
  return request.get(`/4/story-extra/${id}`); 
}
