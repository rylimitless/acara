<template>
    <div class="scheduler">
      <h2>AI Scheduler</h2>
  
      <!-- Form to Input Availability -->
      <div class="form-group">
        <div><h3>Username</h3></div>
        
        <label>Start Date:</label>
        <input type="date" v-model="startDate" />
  
        <label>End Date:</label>
        <input type="date" v-model="endDate" />
  
        <label>Start Time:</label>
        <input type="time" v-model="startTime" />
  
        <label>End Time:</label>
        <input type="time" v-model="endTime" />
  
        <button @click="generateTimeSlots">Generate Time Slots</button>
      </div>
  
      <!-- Availability Table -->
      <div v-if="timeSlots.length">
        <h3>Availability Table</h3>
        <table class="availability-table">
          <thead>
            <tr>
              <th>Time</th>
              <th v-for="day in days" :key="day">{{ day }}</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="time in timeSlots" :key="time">
              <td>{{ time }}</td>
              <td v-for="day in days" :key="day" :class="{ selected: isSelected(day, time) }">
                <input type="checkbox" @change="toggleSelection(day, time)" :checked="isSelected(day, time)" />
              </td>
            </tr>
          </tbody>
        </table>
        <button @click="findBestTime">Find the Best Time</button>
      </div>
  
      <!-- Best Time List -->
      <div v-if="bestTimes.length">
        <h3>Selected Times</h3>
        <ul>
          <li v-for="(time, index) in bestTimes" :key="index">{{ time }}</li>
        </ul>
      </div>
    </div>
  </template>

<script>
export default {
  data() {
    return {
      name: "",
      startDate: "",
      endDate: "",
      startTime: "",
      endTime: "",
      timeSlots: [],
      selectedCells: {},
      days: [],
      bestTimes: []
    };
  },
  methods: {
    generateTimeSlots() {
      if (!this.startDate || !this.endDate || !this.startTime || !this.endTime) return;

      // Generate days between startDate and endDate
      const start = new Date(this.startDate);
      const end = new Date(this.endDate);
      const days = [];
      for (let d = start; d <= end; d.setDate(d.getDate() + 1)) {
        days.push(new Date(d).toLocaleDateString('en-US', { weekday: 'long' }));
      }
      this.days = days;

      // Generate time slots between startTime and endTime
      const startHour = parseInt(this.startTime.split(':')[0]);
      const endHour = parseInt(this.endTime.split(':')[0]);
      const timeSlots = [];
      for (let hour = startHour; hour <= endHour; hour++) {
        timeSlots.push(`${hour.toString().padStart(2, '0')}:00`);
      }
      this.timeSlots = timeSlots;
    },
    toggleSelection(day, time) {
      const key = `${day}-${time}`;
      this.$set(this.selectedCells, key, !this.selectedCells[key]);
    },
    isSelected(day, time) {
      const key = `${day}-${time}`;
      return !!this.selectedCells[key];
    },
    findBestTime() {
      this.bestTimes = Object.keys(this.selectedCells).filter(key => this.selectedCells[key]);
    }
  }
};
</script>
  
<style>
.scheduler {
  max-width: 1000px;
  margin: auto;
  padding: 20px;
  border: 1px solid #ddd;
  border-radius: 8px;
  box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
  background-color: white; /* Set background color to white */
  color: black; /* Set text color to black */
}

.form-group {
  margin-bottom: 20px;
}

input[type="date"],
input[type="time"],
input[type="text"] {
  display: block;
  width: 100%;
  margin-bottom: 10px;
  padding: 8px;
  border: 1px solid #ccc; /* Set border color to a light gray */
  border-radius: 4px; /* Add border radius for rounded corners */
  background-color: white; /* Ensure background color is white */
  color: black; /* Ensure text color is black */
}

input[type="date"]:focus,
input[type="time"]:focus,
input[type="text"]:focus {
  border-color: #1a73e8; /* Change border color on focus */
  outline: none; /* Remove default outline */
}

button {
  background-color: #1a73e8;
  color: white;
  padding: 10px;
  border: none;
  cursor: pointer;
  margin-top: 10px;
  border-radius: 4px; /* Add border radius for rounded corners */
}

button:hover {
  background-color: #1765cc; /* Darken button color on hover */
}

.availability-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}

.availability-table th,
.availability-table td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: center;
  background-color: white; /* Set background color to white */
  color: black; /* Set text color to black */
}

.availability-table th {
  background-color: #f1f3f4;
}

.availability-table td.selected {
  background-color: #34a853;
  color: white;
}

.availability-table td input[type="checkbox"] {
  transform: scale(1.5); /* Increase the size of the checkbox */
  accent-color: #1a73e8; /* Set the color of the checkbox to gray */
}

.availability-table td.selected input[type="checkbox"] {
  accent-color: white; /* Set the color of the checkbox to white when selected */
}
</style>