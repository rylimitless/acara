import { createRouter, createWebHistory } from 'vue-router'
import Home from '@/pages/index.vue' // Assuming index.vue is your home page
import Form from '@/components/Form.vue' // Import the Form component
import Schedule from '@/components/Schedule.vue' // Import the Schedule component

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
  },
  {
    path: '/schedule',
    name: 'Schedule',
    component: Schedule
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router