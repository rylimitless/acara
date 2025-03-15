<template>
    <div class="form-container">
      <div class="form-content">
        <div class="form-header">
          <div class="document-icon">
            <!-- Simple document icon using CSS -->
            <div class="document-svg"></div>
          </div>
          <h2 class="form-title">What's your event about?</h2>
        </div>
        
        <div class="tabs">
          <div class="tab" :class="{ active: currentStep === 0 }" @click="currentStep = 0">Details</div>
          <div class="tab" :class="{ active: currentStep === 1 }" @click="currentStep = 1">Date and location</div>
          <div class="tab" :class="{ active: currentStep === 2 }" @click="currentStep = 2">Guests</div>
          <div class="progress-bar" :style="{ width: (currentStep + 1) * 33.33 + '%' }"></div>
        </div>
        
        <div class="form-fields">
          <div v-if="currentStep === 0">
            <div class="form-group">
              <label for="title">Title</label>
              <div class="input-container">
                <span class="emoji">📝</span>
                <input 
                  type="text" 
                  id="title" 
                  v-model="eventData.title" 
                  placeholder="Event title"
                />
              </div>
            </div>
            
            <div class="form-group">
              <label for="category">Event Type</label>
              <div class="select-container">
                <select id="category" v-model="eventData.category">
                  <option value="" disabled selected>Select a category</option>
                  <option value="party">Party</option>
                  <option value="ceremony">Ceremony</option>
                  <option value="conference">Conference</option>
                  <option value="seminar">Seminar</option>
                  <option value="tournament">Tournament</option>
                  <option value="cultural">Cultural Event</option>
                  <option value="other">Other</option>
                </select>
                <div class="select-arrow">
                  <!-- Custom chevron arrow using CSS -->
                  <div class="chevron-down"></div>
                </div>
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

          <div class="form-group">
            <label for="category">Event Size</label>
            <div class="select-container">
              <select id="category" v-model="eventData.category">
                <option value="" disabled selected>Select a category</option>
                <option value="intimate">Intimate (1-20 people)</option>
                <option value="small">Small (21-50 people)</option>
                <option value="medium">Medium (51-200 people)</option>
                <option value="large">Large (201 -500 people)</option>
                <option value="huge">Huge (500+ people)</option>
                </select>
                <div class="select-arrow">
                    <!-- Custom chevron arrow using CSS -->
                    <div class="chevron-down"></div>
                </div>
            </div>
        </div>     
  
          <div v-if="currentStep === 1">
            <!-- Date and location fields go here -->
            <div class="form-group">
            <label for="date">When is the event?</label>
            <input type="date" id="date" v-model="eventData.date" />
          </div>
          <div class="form-group">
            <label for="location">Location</label>
            <input type="text" id="location" v-model="eventData.location" placeholder="Event location" />
          </div>
        </div>
  
          <div v-if="currentStep === 2">
            <!-- Guests fields go here -->
            <div class="form-group">
              <label for="guests">Guests</label>
              <input type="text" id="guests" v-model="eventData.guests" placeholder="Guest names" />
            </div>
          </div>
        </div>
        
        <div class="form-actions">
          <button class="btn-cancel" @click="previousStep" v-if="currentStep > 0">Back</button>
          <button class="btn-next" @click="nextStep">{{ currentStep < steps.length - 1 ? 'Next' : 'Submit' }}</button>
        </div>
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
          category: '',
          description: '',
          date: '',
          location: '',
          guests: ''
        },
        currentStep: 0,
        steps: ['Details', 'Date and location', 'Guests']
      }
    },
    methods: {
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
      }
    }
  }
  </script>
  
  <style scoped>
  .form-container {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
    background-color: #f9f9f9;
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
    padding: 12px 16px;
    color: #5f6368;
    font-size: 14px;
    cursor: pointer;
    position: relative;
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
    padding: 8px 12px;
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
    background-color: #1765cc;
  }
  </style>