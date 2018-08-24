<template>
  <div class="fluid-container">
    <div class="row">
      <div class="col-md-12">
        <template v-if="contract.is_signed">
          <p>Signed by: {{contract.signer_name}}</p>
        </template>
        <template v-else>
          <rendered-contract :contract="contract"></rendered-contract>
          <hr>
          <p><input type="text" v-model="contract.signer_name" /></p>
          <signature v-model="contract.signature"></signature>
          <p><button @click="saveContract">Sign</button></p>
        </template>
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'
  import RenderedContract from 'views/contracts/rendered_contract'
  import signature from 'views/shares/signature'
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
          custom_fields: [],
          signature: '',
          signer_name: ''
        }
      }
    },
    computed: {
    },
    components: {
      RenderedContract,
      signature
    },
    methods: {
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
