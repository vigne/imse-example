<template>
  <div class="post-single">
    <section class="hero is-primary">
      <div class="hero-body">
        <div class="container">
          <h1 class="title">
            {{ post.uri }}
          </h1>
        </div>
      </div>
    </section>
    <section class="post-comments">
      <div class="container">
          <!-- <div v-for="comment in post.comments" :key="post._id" class="column">
            <img :src="image" :alt="post.name">
          </div> -->
      </div>
    </section>
  </div>
</template>
<script>
  import {APIService} from '../APIServices';
  const apiService = new APIService();
  export default {
    name: 'PostSingle',
    data () {
      return {
        post: {}
      }
    },
    methods: {
      getPostById() {
        apiService.getPostById(this.$route.params.id)
          .then((data) => this.post = data)
          .catch((err) => {console.log("SingleView", err)})
      }
    },
    created() {
      this.post = this.getPostById();
    }
  }
</script>
