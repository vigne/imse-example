<template>
  <div class="profile">
    <section class="hero is-primary">
      <div class="hero-body">
        <div class="container profile">
          <h1 class="title">
            {{ profile.name }} ({{ profile._id }})
          </h1>
        </div>
      </div>
    </section>
    <div class="mailto">
        <div class="label">mail:</div>
        <a :href="'mailto://' + profile.mail">{{ profile.mail }}</a>
    </div>
    <div class="address">
        <div class="label">Address</div>
        <pre>{{ profile.address }}</pre>
    </div>
    <div class="follows">
        <div class="label">Follows</div>
        <ul>
          <li v-for="(category, idx) in profile.follows" :key="idx">
            {{ category }}
          </li>
        </ul>
    </div>
    <div class="posts">
        <div class="label">Authored Posts</div>
        <ul>
          <li v-for="(category, idx) in profile.follows" :key="idx">
            {{ category }}
          </li>
        </ul>
    </div>
    <div class="comments">
        <div class="label">Authored Comments</div>
        <ul>
          <li v-for="(category, idx) in profile.follows" :key="idx">
            {{ category }}
          </li>
        </ul>
    </div>
</div>
</template>
<script>
  import {APIService} from '../APIServices';
  const apiService = new APIService();
  import moment from 'moment'
  export default {
    name: 'PostSingle',
    data () {
      return {
        profile: {}
      }
    },
    methods: {
      getUserProfile() {
        apiService.getUserProfile(this.$route.params.id)
          .then((data) => this.profile = data)
          .catch((err) => {console.log("ProfileView", err)})
      },
    },
    filters: {
      formatDate: function (value) {
        if (!value) return ''
        value = moment(value).format('DD.MM.YYYY hh:mm')
        return value
      }
    },
    created() {
      this.user = this.getUserProfile();
    }
  }
</script>
<style lang="scss" scoped>
</style>
