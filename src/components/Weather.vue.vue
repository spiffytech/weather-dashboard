<template>
  <b-container>
    <b-row class="display-1">
      {{sky}}.
    </b-row>

    <b-row class="lead">
      {{daySky}}
    </b-row>

    <b-row class="display-4">
      {{Math.round(temp)}} ({{Math.round(apparent)}})
    </b-row>

    <b-row class="lead">
      {{Math.round(highTemp)}} ({{Math.round(highApparent)}})
    </b-row>
  </b-container>
</template>

<script lang="ts">
import axios from 'axios';
const DarkSky = require('dark-sky');
import Vue from 'vue';
import { setInterval } from 'timers';

export default Vue.extend({
  name: 'Weather',
  props: ['latitude', 'longitude'],
  data() {
    return {
      darksky: null as any | null,
      sky: null as string | null,
      daySky: null as string | null,

      temp: null as number | null,
      apparent: null as number | null,

      highTemp: null as number | null,
      highApparent: null as number | null,
    } 
  },

  mounted() {
    // this.darksky = new DarkSky(process.env.VUE_APP_DARK_SKY);
    this.refreshWeather();

    setInterval(this.refreshWeather.bind(this), 1000 * 60 * 30);
  },

  methods: {
    async refreshWeather() {
      /*
      const d = this.darksky;
      if (!this.darksky) return;
      const weather =
        await this.darksky.
        latitude(this.latitude).
        longitude(this.longitude).
        get();
      */
      const weather = await axios.get(`https://cors.spiffy.tech/https://api.darksky.net/forecast/8d1d70533bc806861e12bdd0469495d9/${this.latitude},${this.longitude}`);
      console.log(weather);
      this.sky = weather.data.currently.summary;
      this.daySky = weather.data.hourly.summary;
      this.temp = weather.data.currently.temperature;
      this.apparent = weather.data.currently.apparentTemperature;

      this.highTemp = weather.data.daily.data[0].temperatureHigh;
      this.highApparent = weather.data.daily.data[0].apparentTemperatureHigh;
    },
  },
});
</script>