import { createRouter, createWebHistory } from 'vue-router'
import HomePage from '@/pages/HomePage.vue'
import SignUp from '@/pages/SignUp.vue'
import Login from '@/pages/Login.vue'
import Dashboard from '@/pages/Dashboard.vue'
import Form from '@/components/Form.vue' // Import the Form component
import Schedule from '@/components/Schedule.vue' // Import the Schedule component
import Event from '@/components/Event.vue' // Import the Schedule component

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


  {
    path: '/form',
    name: 'Form',
    component: Form
  },
  {
    path: '/schedule',
    name: 'Schedule',
    component: Schedule
  },
  {
    path: '/event',
    name: 'Event',
    component: Event
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router