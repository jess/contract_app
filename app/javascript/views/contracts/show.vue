<template>
  <div class="fluid-container">
    <div class="row">
      <div class="col-md-6">
        <form v-on:submit.prevent="saveContract">
          <div class="form-group">
            <label for="name">Name</label>
            <input v-model="contract.name" type="text" class="form-control" id="name" aria-describedby="name" placeholder="Enter name">
          </div>
          <div class="form-group">
            <label for="name">Content</label>
            <textarea v-model="contract.content" class="form-control" id="content" aria-describedby="content" placeholder="Enter content"></textarea>
          </div>
          <button type="submit" class="btn btn-primary">Submit</button>
        </form>
      </div>
      <div class="col-md-6">
        <h3> {{contract.name}} </h3>
        {{contract.content}}
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'
  let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
  axios.defaults.headers.common['X-CSRF-Token'] = token
  axios.defaults.headers.common['Accept'] = 'application/json'

  export default {
    data: function() {
      return {
        contract: {
          name: '',
          content: ''
        }
      }
    },
    methods: {
      saveContract: function() {
      var t = this
        axios.put(window.location.href + ".json", {
          contract: t.contract
        })
        .then(function (response) {
          t.contract = response.data
        })
        .catch(function (error) {
          console.log(error);
        });
      }
    },
    mounted: function() {
      var t = this
      axios.get(window.location.href + ".json")
        .then(function (response) {
          t.contract = response.data
        })
        .catch(function (error) {
          console.log(error);
        });
    }
  }
</script>

<style lang="scss" scoped>
</style>
