<template>
  <div class="flex flex-col md:flex-row justify-center gap-3.5 mt-8">
    <!-- Left side - Form -->
    <div class="w-full md:w-1/3 bg-gradient-to-b from-[#D9EBFF] to-[#F0E8FF] p-4 md:p-12 flex flex-col rounded-4xl">
      <!-- Form Content -->
      <div class="flex flex-col mt-8 justify-center">
        <h2 class="text-2xl font-bold text-blue-800 mb-2 text-center">Let's Get Started</h2>
        <p class="text-sm text-gray-600 mb-8 text-center">Create your account today and unlock <br> exclusive travel and event planning features.</p>

        <!-- Form Fields -->
        <form class="flex flex-col gap-4 " @submit.prevent="submitForm">
          <div class="flex flex-col gap-2">
            <label class="text-sm ml-5 font-medium text-blue-800">Name</label>
            <input
              v-model="formData.name"
              type="text"
              placeholder="Enter your name"
              class="p-3 rounded-full mx-5 h-[42px] bg-white border border-gray-200 text-sm"
            />
          </div>

          <div class="flex flex-col gap-2">
            <label class="text-sm ml-5 font-medium text-blue-800">Email</label>
            <input
              v-model="formData.email"
              type="email"
              placeholder="Enter your email"
              class="p-3 rounded-full mx-5 h-[42px] border bg-white border-gray-200 text-sm"
            />
          </div>

          <div class="flex flex-col gap-2">
            <label class="text-sm ml-5 font-medium text-blue-800">Password</label>
            <input
              v-model="formData.password"
              type="password"
              placeholder="Create a password"
              class="p-3 mx-5 rounded-full h-[42px] border bg-white border-gray-200 text-sm"
            />
          </div>

          <button
            type="submit"
            class="bg-blue text-white mx-5 font-medium py-3 px-4 rounded-full mt-4 hover:bg-blue-600 transition-colors"
          >
            Sign up
          </button>

          <p class="text-gray-600 mx-auto mt-12">Already have an account?
            <router-link to="/login" class="underline text-blue">Log in</router-link>
          </p>
        </form>
        <div></div>
      </div>
    </div>

    <!-- Right side - Image -->
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

const formData = ref({
  name: '',
  email: '',
  password: ''
});

const submitForm = () => {
  const jsonData = JSON.stringify({
    name: formData.value.name,
    email: formData.value.email,
    password: formData.value.password
  });

  console.log('Form data as JSON:', jsonData);

  fetch('/api/register', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: jsonData
  })
  .then(response => response.json())
  .then(data => console.log('Success:', data))
  .catch(error => console.error('Error:', error));
};


</script>