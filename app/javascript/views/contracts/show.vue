<template>
  <div class="fluid-container">
    <div class="row">
      <div class="col-md-6">
        <form v-on:submit.prevent="saveContract">
          <div class="form-group">
            <label for="name">Name</label>
            <input v-model="contract.name" type="text" class="form-control" id="name" aria-describedby="name" placeholder="Enter name">
          </div>
          <div class="form-check">
            <input v-model="contract.is_sharing" type="checkbox" class="form-control form-check-input">
            <label for="name"> Share Contract?  </label>
          </div>
          <a :href="contract.share_url" v-if="contract.is_sharing">{{contract.share_url}}</a>
          <template v-if="contract.is_signed">
            <p>Signed by: {{contract.signer_name}}</p>
            <p><img :src="contract.signature"></p>
          </template>
          <div class="form-group">
            <label for="name">Content</label>
            <textarea v-model="contract.content" class="form-control" id="content" aria-describedby="content" placeholder="Enter content"></textarea>
          </div>
          <button type="submit" class="btn btn-primary">Submit</button>
        </form>
        <div class="row">
          <div class="col-md-12">
            <hr>
            <p>Custom Fields</p>
          </div>
        </div>
        <div v-for="(field, i) in contract.custom_fields"class="row">
          <div class="col-md-6">
            <div class="form-group">
              <a v-on:click.prevent ="removeField(i)" href="#">X</a>
              <label for="name">Field Name</label>
              <input v-model="field.name" type="text" class="form-control" placeholder="Enter field name">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label for="name">Value</label>
              <input v-model="field.value" type="text" class="form-control" placeholder="Enter field value">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <p><a v-on:click.prevent ="addField" href="#">Add</a></p>
          </div>
        </div>
      </div>
      <div class="col-md-6">
        <h3> {{contract.name}} </h3>
        <hr>
        <rendered-contract :contract="contract"></rendered-contract>
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'
  import RenderedContract from 'views/contracts/rendered_contract'
  import alertify from 'alertifyjs'
  let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
  axios.defaults.headers.common['X-CSRF-Token'] = token
  axios.defaults.headers.common['Accept'] = 'application/json'

  export default {
    data: function() {
      return {
        contract: {
          name: '',
          content: '',
          custom_fields: []
        }
      }
    },
    computed: {
    },
    components: {
      RenderedContract
    },
    methods: {
      removeField: function(i) {
        this.contract.custom_fields.splice(i,1)
      },
      addField: function() {
        this.contract.custom_fields.push(
          {
            name: '',
            value: ''
          }
        )
      },
      saveContract: function() {
      var t = this
        axios.put(window.location.href + ".json", {
          contract: t.contract
        })
        .then(function (response) {
          t.contract = response.data
          alertify.success('Saved!');
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
textarea {
  height: 400px;
}
</style>
