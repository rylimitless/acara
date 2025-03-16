import { createRouter, createWebHistory } from 'vue-router'
import HomePage from '@/pages/HomePage.vue'
import SignUp from '@/pages/SignUp.vue'
import Login from '@/pages/Login.vue'
import Dashboard from '@/pages/Dashboard.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: HomePage
  },
  {
    path: '/signup',
    name: 'Sign Up',
    component: SignUp
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: Dashboard
  },

]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router