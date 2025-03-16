<template>
  <div class="min-h-screen flex items-center justify-center p-6">
    <div class="bg-white rounded-lg ml-12 mb-8 shadow-lg p-8 max-w-3xl w-full">
      <!-- Heading -->
      <h1 class="text-5xl font-bold text-blue-500 ml-8 mt-8 mb-8">
        Your event has been added!
      </h1>

      <!-- Event Details -->
      <div v-if="event" class="space-y-4 ml-12">
        <h2 class="text-4xl font-semibold text-blue-900 ml-12 mb-6">Event Details</h2>
        <p><strong class="text-blue-900">Title:</strong> <span class="text-blue-700">{{ event.title }}</span></p>
        <p><strong class="text-blue-900">Description:</strong> <span class="text-blue-700">{{ event.description }}</span></p>
        <p><strong class="text-blue-900">Date:</strong> <span class="text-blue-700">{{ event.date }}</span></p>
        <p><strong class="text-blue-900">Start Time:</strong> <span class="text-blue-700">{{ event.startTime }}</span></p>
        <p><strong class="text-blue-900">End Time:</strong> <span class="text-blue-700">{{ event.endTime }}</span></p>
        <p><strong class="text-blue-900">Location:</strong> <span class="text-blue-700">{{ event.location }}</span></p>
        <p><strong class="text-blue-900">Guests:</strong> <span class="text-blue-700">{{ event.guests }}</span></p>
      </div>

      <!-- No Event Data Message -->
      <div v-else>
        <p class="text-blue-900">No event data found.</p>
      </div>
    </div>
  </div>
</template>


<script>
export default {
  data() {
    return {
      event: null,
    };
  },
  created() {
    // Retrieve the event data from the query parameters
    const eventData = this.$route.query.eventData;
    if (eventData) {
      this.event = JSON.parse(eventData);
    }

    // Show a success alert
    alert('Event was successfully uploaded!');
  },
};
</script>

