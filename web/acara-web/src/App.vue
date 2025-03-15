<script setup>
import { RouterView } from 'vue-router';
import Header from '@/components/Header.vue';
</script>


<template>
  <div class="min-h-screen flex flex-col">
    <div class="gradient-blotch mt-20">
      <Header />
      <main>

        <RouterView />
      </main>
    </div>
  </div>
</template>

