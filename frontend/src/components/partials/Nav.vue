<template>
<nav class="navbar container" role="navigation" aria-label="main navigation">
  <div class="navbar-brand">
    <a class="navbar-item" href="/">
      <strong class="is-size-4">Something like Reddit</strong>
    </a>
  </div>
  <div id="navbar" class="navbar-menu">
    <div class="navbar-start">
    <div v-if="getUser()" class="buttons">
        <router-link to="/" class="navbar-item">Home</router-link>
        <router-link to="/Categories" class="navbar-item">Categories</router-link>
        <router-link :to="'/Profile/' + this.username" class="navbar-item">Profile</router-link>
      </div>
    </div>
    <div class="navbar-end">
      <div class="navbar-item">
        <div v-if="getUser()" class="buttons">
          Logged in as:&nbsp;<span class="username"> {{getUser()}}</span>
        </div>
        <div v-else class="buttons">
          <a class="button is-dark">
            <router-link :to="'/login'">
              <strong>Sign In</strong>
            </router-link>
          </a>
        </div>
      </div>
    </div>
  </div>
</nav>
</template>
<script>
export default {
  name: 'Nav',
  data() {
    return {
      username: ""
    }
  },
  methods: {
    getUser() {
      let username = localStorage.username
      if (username == 'undefined')
        return false
      this.username = username
      return username
    }
  },
}
</script>
<style lang="scss" scoped>
nav {
    margin-top: 25px;
    margin-bottom: 30px;
    a {
        font-weight: bold;
        color: #cc0000;
        &.router-link-exact-active {
            color: #d88d00;
        }
    }
}
.username {
  font-weight: bold;
  color: #cc0000;
}
</style>
