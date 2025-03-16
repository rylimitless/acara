<template>
  <div class="form-container">
    <div class="form-content">
      <div class="form-header">
        <div class="document-icon">
          <!-- Simple document icon using CSS -->
          <div class="document-svg"></div>
        </div>
        <h2 class="form-title">Create an Event</h2>
      </div>

      <div class="tabs">
        <div class="tab" :class="{ active: currentStep === 0 }" @click="currentStep = 0">Details</div>
        <div class="tab" :class="{ active: currentStep === 1 }" @click="currentStep = 1">Date and location</div>
        <div class="tab" :class="{ active: currentStep === 2 }" @click="currentStep = 2">Guests</div>
        <div class="progress-bar" :style="{ width: (currentStep + 1) * 33.33 + '%' }"></div>
      </div>

    <form @submit.prevent="submitForm" action="https://0f31-173-225-243-208.ngrok-free.app/create_event" method="POST">
      <div class="form-fields">
        <div v-if="currentStep === 0">
          <div class="form-group">
            <label for="title">Title</label>
            <div class="input-container">
              <input
                type="text"
                id="title"
                v-model="eventData.title"
                placeholder="Event title"
              />
            </div>
          </div>

          <div class="form-group">
            <label for="description">Description</label>
            <textarea
              id="description"
              v-model="eventData.description"
              placeholder="Add a description. Links, emojis and new lines are supported."
              rows="3"
            ></textarea>
          </div>
        </div>

        <div v-if="currentStep === 1">
          <div class="form-group">
            <label for="date">Date and Time</label>
            <div class="date-time-picker">
              <div class="date-input">
                <input type="date" id="date" v-model="eventData.date" />
                <button class="calendar-button">
                  <!-- <div class="calendar-icon"></div> -->
                </button>
              </div>
              <div class="time-range">
                <span class="time-label">from</span>
                <div class="time-input">
                  <input type="time" id="startTime" v-model="eventData.startTime" />
                  <button class="time-button">
                    <div class="clock-icon"></div>
                  </button>
                </div>
                <span class="time-label">to</span>
                <div class="time-input">
                  <input type="time" id="endTime" v-model="eventData.endTime" />
                  <button class="time-button">
                    <div class="clock-icon"></div>
                  </button>
                </div>
              </div>
            </div>
            <button class="availability-button" @click="goToSchedule">
              Find based on participants' availability
            </button>
          </div>

          <div class="form-group">
            <label for="location">Location</label>
            <div class="location-input">
              <input
                type="text"
                id="location"
                v-model="eventData.location"
                placeholder="Enter a location"
              />
            </div>
            <div class="ai-suggestions">
              <div class="suggestion-toggle">
                <label>Want AI suggestions?</label>
                <div class="toggle-container">
                  <div
                    class="toggle"
                    :class="{ 'active': aiSuggestions }"
                    @click="toggleAiSuggestions"
                  >
                    <div class="toggle-button"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div v-if="currentStep === 2">
          <div class="form-header">
            <div class="people-icon">
              <div class="people-svg"></div>
            </div>
            <h2 class="form-title">Who should join it?</h2>
          </div>

          <div class="form-group">
            <label for="guests">Guests</label>
            <div class="guest-input-container">
              <input
                type="text"
                id="guests"
                v-model="guestInput"
                placeholder="Name"
                class="guest-input"
              />
              <button class="invite-button" @click="inviteGuest">Invite</button>
            </div>
          </div>

          <div class="guest-list">
            <div class="guest-item" v-for="(guest, index) in guests" :key="index">
              <span class="remove-guest" @click="removeGuest(index)">×</span>
              {{ guest }}
            </div>
          </div>
        </div>
      </div>

      <div class="form-actions">
        <button class="btn-cancel" @click="cancel">Cancel</button>
        <button class="btn-cancel" @click="previousStep" v-if="currentStep > 0">Back</button>
        <button class="btn-next" @click="nextStep">{{ currentStep < steps.length - 1 ? 'Next' : 'Submit' }}</button>
      </div>
    </form>
    <!-- <div v-if="message" class="message">{{ message }}</div> -->

    </div>
  </div>
</template>

  <script>
export default {
  name: 'EventCreationForm',
  data() {
    return {
      eventData: {
        title: '',
        description: '',
        date: '',
        startTime: '',
        endTime: '',
        location: '',
        guests: '',
      },
      aiSuggestions: false,
      currentStep: 0,
      steps: ['Details', 'Date and location', 'Guests']
    }
  },
  methods: {
    toggleAiSuggestions() {
      this.aiSuggestions = !this.aiSuggestions;
      if (!this.aiSuggestions) {
        this.eventData.locationType = '';
      }
    },
    nextStep() {
      if (this.currentStep < this.steps.length - 1) {
        this.currentStep++
      } else {
        this.submitForm()
      }
    },
    previousStep() {
      if (this.currentStep > 0) {
        this.currentStep--
      }
    },
    submitForm() {
      console.log('Form submitted:', this.eventData)
      // Here you would typically send the data to your backend
      // using an HTTP request
      this.message = 'Event added'; // Highlighted line
      //alert('Event added'); // Display an alert when the form is submitted

    },

    goToSchedule() {
      this.$router.push({ name: 'Schedule' });
 // Ensure the route name matches your router configuration
    },

    cancel() {
      this.$router.push({ path: '/' });
    },
    // inviteGuest() {
    //   if (this.guestInput) {
    //     this.guests.push(this.guestInput);
    //     this.guestInput = '';
    //   }
    // },

    inviteGuest() {
      if (this.guestInput.trim()) {
        this.guests.push(this.guestInput.trim());
        this.guestInput = '';
      }
    },
    removeGuest(index) {
      this.guests.splice(index, 1);
    }

    // removeGuest(index) {
    //   this.guests.splice(index, 1);
    // },
    // getInitials(name) {
    //   return name.split(' ').map(word => word[0]).join('').toUpperCase();
    // },
    // getAvatarColor(index) {
    //   // Array of colors for avatars
    //   const colors = [
    //     '#4285F4', // blue
    //     '#34A853', // green
    //     '#FBBC05', // yellow
    //     '#EA4335', // red
    //     '#8AB4F8'  // light blue
    //   ];
    //   return colors[index % colors.length];
    // }
  }
}
</script>

<style scoped>
.form-container {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
  background-color: trannsparent;
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  padding: 20px;
}

.form-content {
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  width: 100%;
  max-width: 550px;
  padding: 24px;
}

.form-header {
  display: flex;
  align-items: center;
  margin-bottom: 24px;
}

.document-icon {
  margin-right: 12px;
  color: #5f6368;
  width: 20px;
  height: 20px;
  position: relative;
}

.document-svg {
  width: 16px;
  height: 20px;
  position: relative;
  border: 2px solid #5f6368;
  border-radius: 2px;
}

.document-svg:before {
  content: "";
  position: absolute;
  top: 4px;
  left: 3px;
  width: 10px;
  height: 2px;
  background: #5f6368;
}

.document-svg:after {
  content: "";
  position: absolute;
  top: 8px;
  left: 3px;
  width: 10px;
  height: 2px;
  background: #5f6368;
}

.form-title {
  font-size: 20px;
  font-weight: 500;
  color: #202124;
  margin: 0;
}

.tabs {
  display: flex;
  border-bottom: 1px solid #e0e0e0;
  position: relative;
  margin-bottom: 24px;
}

.tab {
  flex: 1; /* Ensure tabs are evenly divided */
  padding: 12px 16px;
  color: #5f6368;
  font-size: 14px;
  cursor: pointer;
  text-align: center; /* Center align text */
}

.tab.active {
  color: #1a73e8;
  font-weight: 500;
}

.progress-bar {
  position: absolute;
  bottom: 0;
  left: 0;
  height: 3px;
  background-color: #1a73e8;
  transition: width 0.3s;
}

.form-fields {
  margin-bottom: 24px;
}

.form-group {
  margin-bottom: 16px;
}

.form-group label {
  display: block;
  font-size: 14px;
  font-weight: 500;
  color: #202124;
  margin-bottom: 8px;
}

.input-container {
  display: flex;
  align-items: center;
  border: 1px solid #dadce0;
  border-radius: 4px;
  padding: 4px 8px;
}

.input-container input {
  border: none;
  outline: none;
  width: 100%;
  font-size: 14px;
  margin-left: 8px;
}

.input-container input,
textarea {
  color: #202124; /* Set the text color to a visible color */
}

.input-container input#title {
  width: 100%; /* Adjust the width as needed */
  padding: 2px 2px; /* Adjust the padding as needed */
  font-size: 16px; /* Adjust the font size as needed */
}

.emoji {
  color: #70757a;
  font-size: 16px;
}

.select-container {
  position: relative;
}

select {
  width: 100%;
  padding: 10px 12px;
  border: 1px solid #dadce0;
  border-radius: 4px;
  font-size: 14px;
  appearance: none;
  background-color: white;
  color: #202124;
}

.select-arrow {
  position: absolute;
  right: 12px;
  top: 50%;
  transform: translateY(-50%);
  color: #5f6368;
  pointer-events: none;
  width: 12px;
  height: 12px;
}

.chevron-down {
  width: 10px;
  height: 10px;
  border-style: solid;
  border-width: 0 2px 2px 0;
  margin-bottom: 10px;
  border-color: #5f6368;
  transform: rotate(45deg);
  display: inline-block;
}

textarea {
  width: 100%;
  padding: 10px 12px;
  border: 1px solid #dadce0;
  border-radius: 4px;
  font-size: 14px;
  resize: vertical;
  font-family: inherit;
  color: #202124;
}

.form-actions {
  display: flex;
  justify-content: flex-end;
  gap: 8px;
}

.btn-cancel {
  padding: 8px 16px;
  background-color: transparent;
  border: none;
  color: #5f6368;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  border-radius: 4px;
}

.btn-back {
  padding: 8px 16px;
  background-color: transparent;
  border: none;
  color: #5f6368;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  border-radius: 4px;
}

.btn-next {
  padding: 8px 24px;
  background-color: #1a73e8;
  border: none;
  color: white;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  border-radius: 4px;
}

.btn-cancel:hover {
  background-color: rgba(0, 0, 0, 0.05);
}

.btn-next:hover {
  background-color: rgba(0, 0, 0, 0.05);
}

.btn-next:hover {
  background-color: #1765cc;
}

/* New styles for the date and location section */
.location-icon {
  margin-right: 12px;
  color: #5f6368;
  width: 20px;
  height: 20px;
  position: relative;
}

.location-pin {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: #5f6368;
  position: relative;
  top: 0;
  left: 4px;
}

.location-pin:after {
  content: "";
  position: absolute;
  width: 0;
  height: 0;
  bottom: -8px;
  left: -4px;
  border-left: 10px solid transparent;
  border-right: 10px solid transparent;
  border-top: 12px solid #5f6368;
}

.date-time-picker {
  display: flex;
  flex-direction: column;
  gap: 12px;
  margin-bottom: 16px;
}

.date-input {
  display: flex;
  align-items: center;
}

.date-input input {
  flex: 1;
  padding: 10px 12px;
  border: 1px solid #dadce0;
  border-radius: 4px;
  font-size: 14px;
  color:#202124
}

.calendar-button {
  background: none;
  border: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 8px;
  margin-left: -34px;
}

.calendar-icon {
  width: 16px;
  height: 16px;
  border: 1px solid #5f6368;
  border-radius: 2px;
  position: relative;
}

/* .calendar-icon:before {
  content: "";
  position: absolute;
  top: -4px;
  left: 3px;
  width: 1px;
  height: 4px;
  background: #5f6368;
}

.calendar-icon:after {
  content: "";
  position: absolute;
  top: -4px;
  right: 3px;
  width: 1px;
  height: 4px;
  background: #5f6368;
} */

.time-range {
  display: flex;
  align-items: center;
  gap: 8px;
}

.time-label {
  color: #5f6368;
  font-size: 14px;
}

.time-input {
  display: flex;
  align-items: center;
  flex: 1;
}

.time-input input {
  flex: 1;
  padding: 10px 12px;
  border: 1px solid #dadce0;
  border-radius: 4px;
  font-size: 14px;
  color:#202124
}

.time-button {
  background: none;
  border: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 8px;
  margin-left: -34px;
}

.clock-icon {
  width: 14px;
  height: 14px;
  border: 1px solid #5f6368;
  border-radius: 50%;
  position: relative;
}

.clock-icon:before {
  content: "";
  position: absolute;
  top: 6px;
  left: 6px;
  width: 4px;
  height: 1px;
  background: #5f6368;
  transform: rotate(45deg);
  transform-origin: 0 0;
}

.availability-button {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  padding: 10px;
  margin-top: 12px;
  background-color: #1a73e8;
  border: 1px solid #dadce0;
  border-radius: 4px;
  font-size: 14px;
  color: #fff;
  cursor: pointer;
  font-weight: 500;
}

.availability-icon {
  margin-right: 8px;
}

.location-input {
  margin-bottom: 16px;
}

.location-input input {
  width: 100%;
  padding: 10px 12px;
  border: 1px solid #dadce0;
  border-radius: 4px;
  font-size: 14px;
  color:#202124
}

.ai-suggestions {
  margin-top: 16px;
}

.suggestion-toggle {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 16px;
}

.suggestion-toggle label {
  font-size: 14px;
  color: #202124;
}

.toggle-container {
  display: flex;
  align-items: center;
}

.toggle {
  width: 36px;
  height: 20px;
  background-color: #dadce0;
  border-radius: 10px;
  position: relative;
  cursor: pointer;
  transition: background-color 0.3s;
}

.toggle.active {
  background-color: #1a73e8;
}

.toggle-button {
  width: 16px;
  height: 16px;
  background-color: white;
  border-radius: 50%;
  position: absolute;
  top: 2px;
  left: 2px;
  transition: left 0.3s;
}

.toggle.active .toggle-button {
  left: 18px;
}

.guest-input-container {
  display: flex;
  align-items: center;
  margin-bottom: 16px;
}

.guest-input {
  flex: 1;
  padding: 10px 12px;
  border: 1px solid #dadce0;
  border-radius: 4px;
  font-size: 14px;
  margin-right: 8px;
  color:#202124
}

.invite-button {
  padding: 8px 16px;
  background-color: #1a73e8;
  border: none;
  color: white;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  border-radius: 4px;
}

.guest-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-bottom: 24px;
}

.guest-item {
  display: flex;
  align-items: center;
  background-color: #f1f3f4;
  padding: 8px 12px;
  border-radius: 4px;
  position: relative;
}

/* .guest-avatars {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 24px;
}

.avatar {
  display: flex;
  align-items: center;
  justify-content: center;
}

.avatar-circle {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background-color: #dadce0;
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  font-weight: 500;
} */


.remove-avatar {
  position: absolute;
  top: -5px;
  right: -5px;
  background-color: #ff0000;
  color: white;
  border-radius: 50%;
  width: 16px;
  height: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  cursor: pointer;
}

</style>