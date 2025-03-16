<template>
  <header class="bg-transparent w-full py-4 px-6 fixed top-0 left-0 right-0 z-10 transition-all duration-300" :class="{ 'bg-white shadow-md': scrolled }">
    <nav class="flex items-center justify-between max-w-7xl mx-auto">
      <!-- Logo -->
      <div class="flex items-center">
        <router-link to="/" class="text-3xl font-bold text-blue-500 flex items-center">
      <img src="@/assets/logoo.png" alt="Logo" class="mr-2 h-[110px]">

    </router-link>
      </div>

      <div class="hidden md:flex items-center">
          <router-link to="/" class="text-gray-700 hover:text-blue-500 transition-colors mr-12">Home</router-link>
          <router-link to="/about" class="text-gray-700 hover:text-blue-500 transition-colors mr-12">About Us</router-link>
          <router-link to="/contact" class="text-gray-700 hover:text-blue-500 transition-colors">Contact</router-link>
      </div>

      <!-- Auth Buttons -->
      <div class="hidden md:flex items-center space-x-4">
        <router-link to="/login" class="text-gray-700 hover:text-blue-500 transition-colors mr-8">Login</router-link>
        <router-link to="/signup" class="bg-blue text-white px-4 py-2 rounded-md hover:bg-[#ff0000]">Sign Up</router-link>
      </div>


      <!-- For Mobile View -->

      <!-- Mobile Menu Button -->
      <button @click="toggleMobileMenu" class="md:hidden text-gray-700 focus:outline-none">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path v-if="!mobileMenuOpen" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
          <path v-else stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
        </svg>
      </button>
    </nav>

    <!-- Mobile Menu -->
    <div v-if="mobileMenuOpen" class="md:hidden bg-white shadow-lg rounded-lg mt-2 py-4 px-6 absolute left-4 right-4 z-20">
      <div class="flex flex-col space-y-4">
        <router-link to="/" class="text-gray-700 hover:text-blue-500 transition-colors" @click="closeMobileMenu">Home</router-link>

        <router-link to="/about" class="text-gray-700 hover:text-blue-500 transition-colors" @click="closeMobileMenu">About Us</router-link>

        <router-link to="/about" class="text-gray-700 hover:text-blue-500 transition-colors" @click="closeMobileMenu">Contact</router-link>
        <hr class="border-gray-200">
        <router-link to="/login" class="text-gray-700 hover:text-blue-500 transition-colors" @click="closeMobileMenu">Login</router-link>
        <router-link to="/signup" class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600 transition-colors text-center" @click="closeMobileMenu">Sign Up</router-link>
      </div>
    </div>
  </header>
</template>

<script>
export default {
  name: 'HeaderComponent',
  data() {
    return {
      mobileMenuOpen: false,
      scrolled: false
    }
  },
  mounted() {
    window.addEventListener('scroll', this.handleScroll);
  },
  beforeUnmount() {
    window.removeEventListener('scroll', this.handleScroll);
  },
  methods: {
    toggleMobileMenu() {
      this.mobileMenuOpen = !this.mobileMenuOpen;
    },
    closeMobileMenu() {
      this.mobileMenuOpen = false;
    },
    handleScroll() {
      this.scrolled = window.scrollY > 20;
    }
  }
}
</script>


<style>

.primary{

}

</style>