

<template>
  <div class="flex flex-col md:flex-row items-center justify-between py-12 ">
    <!-- Left side content -->
    <div class="max-w-lg">
      <h1 class="text-6xl font-bold text-gray-800 mt-8 mb-4 leading-snug">Managing Events Just Got Easier! </h1>
      <img
            src="@/assets/vector.png"
            alt="Trip planning app interface with user and analytics"
           />
      <p class="text-lg text-gray-700 my-12">Whether it's a seminar, business trip, or conference, our platform keeps you organized. Create event profiles, automate itineraries with Google Calendar, get real-time updates, and track tasks effortlessly. Stay prepared with backup plans for a seamless experience!</p>

      <div class="flex space-x-4">
        <button class="bg-blue hover:bg-blue-600 text-white font-medium py-3 px-6 rounded-xl transition-colors">
          Start Planning
        </button>
        <button class="border bg-transparent border-gray text-blue font-medium py-3 px-6 rounded-lg flex items-center transition-colors hover:bg-gray-100">
          <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <circle cx="12" cy="12" r="10" stroke-width="2"></circle>
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 8l6 4-6 4V8z"></path>
          </svg>
          See How It Works
        </button>
      </div>
    </div>

    <!-- Right side image -->
    <div class="mt-8 md:mt-0">
      <img
            src="@/assets/home-photo.png"
            alt="Trip planning app interface with user and analytics"
           />
    </div>
  </div>
</template>