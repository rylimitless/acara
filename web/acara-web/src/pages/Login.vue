<template>
  <div class="flex flex-col md:flex-row justify-center gap-3.5 mt-8">
    <!-- Left side - Form -->
    <div class="w-full md:w-1/3 bg-gradient-to-b from-[#D9EBFF] to-[#F0E8FF] p-4 md:p-12 flex flex-col rounded-4xl">
      <!-- Form Content -->
      <div class="flex flex-col mt-8 justify-center">
        <h2 class="text-2xl font-bold text-blue-800 mb-2 text-center">Login</h2>
        <p class="text-sm text-gray-600 mb-8 text-center">Welcome back! <br> Access your account to continue your adventure.</p>

        <!-- Form Fields -->
        <form class="flex flex-col gap-4" @submit.prevent="submitLogin">
          <div class="flex flex-col gap-2">
            <label class="text-sm ml-5 font-medium text-blue-800">Email</label>
            <input
              v-model="loginData.email"
              type="email"
              placeholder="Enter your email"
              class="p-3 rounded-full mx-5 h-[42px] border bg-white border-gray-200 text-sm"
            />
          </div>

          <div class="flex flex-col gap-2">
            <label class="text-sm ml-5 font-medium text-blue-800">Password</label>
            <input
              v-model="loginData.password"
              type="password"
              placeholder="Enter your password"
              class="p-3 mx-5 rounded-full h-[42px] border bg-white border-gray-200 text-sm"
            />
          </div>

          <button
            type="submit"
            class="bg-blue text-white mx-5 font-medium py-3 px-4 rounded-full mt-4 hover:bg-blue-600 transition-colors"
          >
            Login
          </button>

          <p class="text-gray-600 mx-auto mt-12">Don't have an account?
            <router-link to="/signup" class="underline text-blue">Sign Up</router-link>
          </p>
        </form>
      </div>
    </div>


    <div class="hidden md:block w-full md:w-2/3 h-full">
      <img
        src="@/assets/beachpic.jpg"
        alt="Beautiful beach cove with turquoise water surrounded by cliffs"
        class="w-full h-full object-cover rounded-4xl"
      />
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();
const loginData = ref({
  email: '',
  password: ''
});

const submitLogin = () => {

  const jsonData = JSON.stringify({
    email: loginData.value.email,
    password: loginData.value.password
  });

  console.log('Login data as JSON:', jsonData);

  fetch('/api/login', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: jsonData
  })
  .then(response => response.json())
  .then(data => {
    if (data.success) {

      localStorage.setItem('authToken', data.token);

      router.push('/dashboard');
    } else {

      console.error('Login failed:', data.message);
    }
  })
  .catch(error => console.error('Error:', error));
};
</script>