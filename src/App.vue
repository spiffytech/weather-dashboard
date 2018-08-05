<template>
  <div id="app">
    <Weather
      v-if="latitude && longitude"
      :latitude="latitude"
      :longitude="longitude"
    />
  </div>
</template>

<script lang="ts">
import Vue from 'vue';
import Weather from './components/Weather.vue';

export default Vue.extend({
  name: 'app',
  components: {
    Weather
  },

  data() {
    return {
      latitude: 0,
      longitude: 0,
    };
  },

  mounted() {
    navigator.geolocation.getCurrentPosition((position) => {
      this.longitude = position.coords.longitude;
      this.latitude = position.coords.latitude;
    });
  },
});
</script>