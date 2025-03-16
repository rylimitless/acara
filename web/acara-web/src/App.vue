<!-- <template>
  <div class="min-h-screen flex flex-col">
    <div class="gradient-blotch mt-20">
      <Header class="sticky top-0 z-10" />
      <main>
        <RouterView />
      </main>
    </div>
  </div>
</template> -->

<script setup>
import { useRoute } from 'vue-router';
import Header from '@/components/Header.vue';

const route = useRoute();
</script>

<template>
  <div class="min-h-screen flex flex-col">
    <div class="gradient-blotch mt-20">
      <!-- Hide header if route is /dashboard -->
      <Header v-if="route.path !== '/dashboard'" class="sticky top-0 z-10" />
      <main>
        <RouterView />
      </main>
    </div>
  </div>
</template>
