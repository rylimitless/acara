import { createRouter, createWebHistory } from 'vue-router'
import Home from '@/pages/index.vue' // Assuming index.vue is your home page
import Form from '@/components/Form.vue' // Import the Form component

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/form',
    name: 'Form',
    component: Form
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router