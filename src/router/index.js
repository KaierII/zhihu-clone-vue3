// src/router/index.js
import { createRouter, createWebHistory } from 'vue-router'
import HomePage from '../views/HomePage.vue'
import NewsDetail from '../views/NewsDetail.vue'
import LoginPage from '../views/LoginPage.vue'
import ProfilePage from '../views/ProfilePage.vue'
import FavoritesPage from '../views/FavoritesPage.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/', name: 'home', component: HomePage },
    { path: '/detail/:id', name: 'detail', component: NewsDetail, props: true },
    { path: '/login', name: 'login', component: LoginPage },
    { path: '/profile', name: 'profile', component: ProfilePage },
    { path: '/favorites', name: 'favorites', component: FavoritesPage },
  ]
})

export default router
