<template>

  <div class="flex flex-row relative">
    <div class="sidebar-container fixed">
      <!-- User Profile Section -->
      <div class="user-profile">
        <div class="avatar-container">
          <img src="@/assets/beachpic.jpg" alt="username" class="user-avatar" />
        </div>
        <div class="user-info">
          <h3 class="username text-gray-800">{{ user.name }}</h3>
        </div>
      </div>

      <!-- Create Event Button -->
      <button class="create-event-btn mb-3" @click="createNewEvent">
        <span class="plus-icon">+</span>
        <span>New Event</span>
      </button>

      <!-- Events Section -->
      <div class="events-section mt-3">
        <div class="section-header">
          <h4>Events</h4>
          <span class="event-count">{{ events.length }}</span>
        </div>

        <ul class="events-list">
          <li v-for="event in events" :key="event.id" :class="['event-item', { active: event.id === activeEventId }]" @click="selectEvent(event.id)">
            <div class="event-icon">
              <img :src="event.icon" :alt="event.name" />
            </div>
            <div class="event-details">
              <p class="event-name text-blue-800">{{ event.name }}</p>
              <p class="event-date">{{ formatDate(event.date) }}</p>
            </div>
          </li>
        </ul>
      </div>

      <!-- Divider -->
      <div class="sidebar-divider"></div>

      <!-- General Section -->
      <div class="general-section">
        <h4 class="section-title">GENERAL</h4>

        <ul class="menu-list">
          <li v-for="menuItem in generalMenu" :key="menuItem.id" :class="['menu-item', { active: menuItem.id === activeMenuItem }]" @click="selectMenuItem(menuItem.id)">
            <div class="menu-icon">
              <i :class="menuItem.icon"></i>
            </div>
            <span class="menu-text">{{ menuItem.name }}</span>
          </li>
        </ul>
      </div>

      <!-- Chat Groups Section -->
      <div class="chat-groups-section">
        <h4 class="section-title">CHAT GROUPS</h4>

        <ul class="groups-list">
          <li v-for="group in chatGroups" :key="group.id" :class="['group-item', { active: group.id === activeGroupId }]" @click="selectChatGroup(group.id)">
            <div class="group-avatar">
              <img :src="group.avatar" :alt="group.name" />
              <span v-if="group.unreadMessages" class="unread-badge">{{ group.unreadMessages }}</span>
            </div>
            <div class="group-info">
              <p class="group-name text-blue-800">{{ group.name }}</p>
              <p class="last-message">{{ truncateMessage(group.lastMessage) }}</p>
            </div>
          </li>
        </ul>
      </div>

      <!-- Logout Option -->
      <div class="logout-container">
        <button class="logout-btn" @click="logout">
          <i class="fa fa-sign-out"></i>
          <span>Logout</span>
        </button>
      </div>
  </div>

  <div class="flex-1 flex flex-col relative h-screen left-52 bg-white ">
    <header class=" p-4 border-b border-gray-200">
        <div class="flex flex-col ml-8 mt-16">
          <div>
            <h1 class="text-4xl font-semibold text-blue">Good Morning, Cecil 👋</h1>
            <p class="text-blue text-xl">Plan your itinerary with us</p>
          </div>
          <!-- <div class="h-[300px] w-[600px] bg-red"></div> -->


        </div>

    </header>

    <<div class="bg-white p-6 rounded-lg shadow-md ml-8">
    <h2 class="text-xl font-semibold mt-2 mb-2 text-blue-800">Upcoming Events</h2>
    <p class="text-gray-600 mb-6">Remember your upcoming events!</p>

    <!-- Flex container for events in a row -->
    <div class="flex space-x-4 overflow-x-auto">
      <!-- Loop through events -->
      <div
        v-for="event in eventpreview"
        :key="event.id"
        class="flex-shrink-0 w-64 p-4 border ml-4  rounded-lg shadow-sm"
      >
        <!-- Dynamic date badge -->
        <div class="flex items-center gap-3">
    <!-- Small Image -->
    <img :src="event.image" alt="Event Icon" class="w-24 h-24 rounded-md" />

    <!-- Date Container -->
    <div :class="`bg-${event.color}-100 p-3 rounded-full w-12 h-12 flex items-center justify-center`">
      <!-- Day -->
      <span :class="`text-${event.color}-600 font-bold`">{{ event.date.split(' ')[0] }}</span>
      <!-- Month -->
      <span :class="`text-${event.color}-600 text-sm`"> {{ event.date.split(' ')[1] }}</span>
    </div>
  </div>
        <!-- Event location and type -->
        <div class="mt-4">
          <h3 class="font-semibold">{{ event.location }}</h3>
          <p class="text-gray-500">Event Type: {{ event.type }}</p>
        </div>
        <!-- Details button -->
        <button class="mt-4 text-blue-800 underlined">
          View Details
        </button>
      </div>
    </div>
  </div>

    <div class=" left-52 bg-white">
      <div> <h1 class="text-blue text-2xl  font-semibold ml-8 my-4">For your Tech Conference</h1> </div>

    </div>


    <div class="space-y-4 ml-8 my-8">
      <!-- Service Provider Card Component -->
      <div v-for="provider in serviceProviders" :key="provider.id"
           class="bg-white rounded-lg shadow-md overflow-hidden gap-2 flex">
           <img :src="provider.pic" :alt="provider.name" class="w-32 h-24 object-cover">

        <div class="flex-1 p-4 mb-4">
          <h2 class="text-lg font-semibold text-blue-800">{{ provider.name }} - {{ provider.location }}</h2>
          <p class="text-gray-600 text-sm mb-2">{{ provider.description }}</p>

          <div class="flex items-center">
            <span class="text-amber-500 font-bold mr-1">{{ provider.rating }}</span>
            <span class="text-gray-500 text-xs">({{ provider.reviewCount }})</span>
          </div>

          <div class="text-xs text-gray-500 mt-1">
            Guide by:
            <span class="ml-1">{{ provider.guideIcon }} {{ provider.guideName }}</span>
          </div>

          <div class="flex mt-2">
            <span v-for="tag in provider.tags" :key="tag"
                  class="bg-gray-100 text-gray-600 text-xs px-2 py-1 rounded-full mr-2">
              {{ tag }}
            </span>
          </div>
        </div>

        <div class="flex flex-col items-center justify-center p-4">
          <button @click="toggleFavorite(provider)" class="mb-1">
            <svg :class="['w-6 h-6', provider.isFavorite ? 'text-red-500' : 'text-gray-300']"
                 fill="currentColor" viewBox="0 0 24 24">
              <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
            </svg>
          </button>
          <span class="text-sm text-gray-500">{{ provider.bookmarkCount }}</span>
        </div>
      </div>
    </div>



   </div>

</div>
</template>

<script>
export default {
  name: 'SideNavigation',
  props: {
    activeItem: {
      type: String,
      default: 'dashboard'
    }
  },
  data() {
    return {
      user: {
        name: 'Cecilia Puni',
        status: 'Part-time Traveler',
        avatar: '/avatars/user.jpg'
      },
      events: [
        { id: 'e1', name: 'AI Hackathon', date: '2024-12-24', icon: 'src/assets/convention.jpg' },
        { id: 'e2', name: 'BizTech', date: '2025-01-01', icon: 'src/assets/convention.jpg' },
        { id: 'e3', name: 'Tech Retreat ', date: '2025-03-04', icon: 'src/assets/convention.jpg' },
        { id: 'e4', name: 'Barus Seminar', date: '2025-07-19', icon: 'src/assets/convention.jpg' },
        { id: 'e5', name: 'Google Program', date: '2025-08-15', icon: 'src/assets/convention.jpg  ' }
      ],
      generalMenu: [
        { id: 'dashboard', name: 'Dashboard', icon: 'fa fa-home' },
        { id: 'itinerary', name: 'Itinerary', icon: 'fa fa-map' },
        { id: 'explore', name: 'Explore', icon: 'fa fa-compass' },
        { id: 'guide', name: 'Guide', icon: 'fa fa-book' },
        { id: 'friends', name: 'Friends', icon: 'fa fa-users' }
      ],
      chatGroups: [
        {
          id: 'g1',
          name: 'Malaysia Express',
          avatar: 'src/assets/convention.jpg',
          lastMessage: 'When are we meeting at the hotel?',
          unreadMessages: 3
        },
        {
          id: 'g2',
          name: 'Digicel Group',
          avatar: 'src/assets/convention.jpg',
          lastMessage: 'I found a great ramen place near Shibuya!',
          unreadMessages: 0
        },
        {
          id: 'g3',
          name: 'Sagicor Life',
          avatar: 'src/assets/convention.jpg',
          lastMessage: 'Let me send you the flight details.',
          unreadMessages: 1
        }
      ],
      eventpreview: [
        {
          id: 'e1',
          date: '24 Nov',
          location: 'Montego Bay Convention C',
          type: 'Seminar',
          image: 'src/assets/mobay.jpg',
          color: 'blue'
        },
        {
          id: 'e2',
          date: '12 Dec',
          location: 'AC Hotel, Kingston',
          type: 'Workshop',
          image: 'src/assets/ac.jpg',
          color: 'blue'
        },
        {
          id: 'e3',
          date: '15 Jan',
          location: 'Pegasus Hotel',
          image: 'src/assets/pegasus.jpg',
          type: 'Business Retreat',
          color: 'blue'
        }
      ],
      serviceProviders: [
        {
          id: 1,
          name: 'Gourmet Delights Catering',
          location: 'Kuala Lumpur',
          description: 'Premium catering service specializing in corporate events, weddings, and international cuisine',
          pic: 'src/assets/carter.jpg',
          rating: 4.8,
          reviewCount: 126,
          guideIcon: '🧑‍🍳',
          guideName: 'Chef Maria',
          tags: ['Corporate', 'Fine Dining', 'Halal'],
          bookmarkCount: 5,
          isFavorite: false
        },
        {
          id: 2,
          name: 'Grandview Convention Center',
          location: 'Kuala Lumpur',
          description: 'A modern venue with state-of-the-art facilities for conferences, exhibitions, and corporate events',
          pic: 'src/assets/convention.jpg',
          rating: 4.7,
          reviewCount: 89,
          guideIcon: '🏢',
          guideName: 'Event Pro',
          tags: ['AV Equipment', '5G Network', 'Catering'],
          bookmarkCount: 3,
          isFavorite: true
        }
      ],
      activeEventId: 'e1',
      activeMenuItem: 'dashboard',
      activeGroupId: null
    };
  },
  methods: {
    createNewEvent() {
      this.$router.push('/events/new');
    },
    selectEvent(eventId) {
      this.activeEventId = eventId;
      this.$router.push(`/events/${eventId}`);
    },
    selectMenuItem(menuId) {
      this.activeMenuItem = menuId;
      this.$router.push(`/${menuId}`);
    },
    selectChatGroup(groupId) {
      this.activeGroupId = groupId;
      this.$router.push(`/chat/${groupId}`);
    },
    formatDate(dateString) {
      const date = new Date(dateString);
      return `${date.getDate()} ${new Intl.DateTimeFormat('en', { month: 'short' }).format(date)} ${date.getFullYear()}`;
    },
    truncateMessage(message) {
      return message.length > 25 ? message.substring(0, 25) + '...' : message;
    },
    logout() {
      // Call your logout API or clear session
      this.$emit('logout');
      this.$router.push('/login');
    }
  },
  created() {
    // Set the active item based on props
    this.activeMenuItem = this.activeItem;
  }
};
</script>

<style scoped>
.sidebar-container {
  width: 350px;
  height: 100vh;
  background-color: #f9f9f9;
  border-right: 1px solid #eeeeee;
  display: flex;
  flex-direction: column;
  padding: 16px;
  overflow-y: auto;

  position: fixed;
  left: 0;
  top: 0;
}

.user-profile {
  display: flex;
  align-items: center;
  padding: 8px 0;
  margin-bottom: 16px;
}

.user-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  object-fit: cover;
  margin-right: 12px;
}

.username {
  font-weight: 600;
  font-size: 16px;
  margin: 0;
}

.user-status {
  color: #666;
  font-size: 12px;
  margin: 0;
}

.create-event-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #0F8CE9;
  color: white;
  border: none;
  border-radius: 8px;
  padding: 10px;
  margin-bottom: 20px;
  cursor: pointer;
  font-weight: 600;
  transition: background-color 0.2s;
}

.create-event-btn:hover {
  background-color: #0A2463;
}

.plus-icon {
  font-size: 18px;
  margin-right: 8px;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.section-header h4 {
  margin: 0;
  font-size: 14px;
  color: #333;
}

.event-count {
  background-color: #eeeeee;
  color: #666;
  border-radius: 8px;
  padding: 2px 8px;
  font-size: 12px;
}

.events-list, .menu-list, .groups-list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.event-item {
  display: flex;
  align-items: center;
  padding: 8px;
  border-radius: 8px;
  margin-bottom: 8px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.event-item:hover, .menu-item:hover, .group-item:hover {
  background-color: #f0f0f0;
}

.event-item.active {
  background-color: #E8F2FA;
}

.event-icon {
  width: 24px;
  height: 24px;
  margin-right: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.event-icon img {
  width: 20px;
  height: 20px;
  object-fit: contain;
}

.event-name {
  font-weight: 500;
  margin: 0;
  font-size: 14px;
}

.event-date {
  color: #888;
  margin: 0;
  font-size: 12px;
}

.sidebar-divider {
  height: 1px;
  background-color: #eeeeee;
  margin: 16px 0;
}

.section-title {
  color: #888;
  font-size: 12px;
  font-weight: 600;
  margin-bottom: 12px;
}

.menu-item {
  display: flex;
  align-items: center;
  padding: 10px 8px;
  border-radius: 8px;
  margin-bottom: 4px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.menu-item.active {
  background-color: #E8F2FA;
  color: #193CB8;
}

.menu-icon {
  width: 24px;
  margin-right: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.menu-text {
  font-size: 14px;
  color: #193CB8;
  font-weight: 500;
}

.chat-groups-section {
  margin-top: 20px;
}

.group-item {
  display: flex;
  padding: 8px;
  border-radius: 8px;
  margin-bottom: 8px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.group-avatar {
  position: relative;
  margin-right: 12px;
}

.group-avatar img {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  object-fit: cover;
}

.unread-badge {
  position: absolute;
  top: -5px;
  right: -5px;
  background-color: #ff4d4d;
  color: white;
  border-radius: 50%;
  width: 18px;
  height: 18px;
  font-size: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.group-name {
  font-weight: 500;
  margin: 0 0 2px 0;
  font-size: 14px;
}

.last-message {
  color: #888;
  margin: 0;
  font-size: 12px;
}

.logout-container {
  margin-top: auto;
  padding-top: 16px;
}

.logout-btn {
  display: flex;
  align-items: center;
  background: none;
  border: none;
  color: #666;
  cursor: pointer;
  padding: 8px;
  border-radius: 8px;
  width: 100%;
  font-size: 14px;
}

.logout-btn i {
  margin-right: 8px;
}

.logout-btn:hover {
  background-color: #E8F2FA;
}
</style>
