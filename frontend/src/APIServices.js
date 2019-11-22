import axios from 'axios'
import {EJSON} from 'bson'


axios.defaults.baseURL = 'http://localhost:5000'
axios.defaults.headers.common['Authorization'] = `Bearer ${localStorage.token}`

const options = {
  transformResponse: [(data) => {
    // transform the response from MongoDB BSON-string proper JavaScript object
    return EJSON.parse(data);
  }]
}

export class APIService{

  constructor(){
  }
  getFeaturedPosts() {
      console.log("get featured")
      const url = `/posts`;
      return axios.get(url, options).then(response => response.data)
  }

  getPostById(postId) {
    console.log("get post by id")
    const url = `/posts/${postId}`;
    return axios.get(url)
      .then(response => response.data)
      .catch((error) => {
        console.log("Error requesting post from backend", error)
        if (error.response && error.response.status === 401)
          window.location.href = "/login"
      })
  }
  getToken(username, password) {
    const url = `/tokens`;
    return axios.post(url, options, {
      auth: {
        username: username,
        password: password
      }})
      .then(response => {
        localStorage.token = response.data._id
        localStorage.user = response.data.user
        window.location.href = "/"
      })
      .catch((error) => {
        console.log("Error requesting token", error)
      })
  }
}
