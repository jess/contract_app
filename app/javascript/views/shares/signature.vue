<template>
  <canvas @click="update" width="400" height="300"></canvas>
</template>

<script>
  import SignaturePad from 'signature_pad'

  export default {
    data: function() {
      return {
        signature: {}
      }
    },
    computed: {
    },
    components: {
    },
    methods: {
      update: function() {
        this.$emit("input", this.signature.toDataURL())
      }
    },
    mounted: function() {
      var canvas = document.querySelector("canvas");
      this.signature = new SignaturePad(canvas);
    }
  }
</script>

<style lang="scss" scoped>
canvas {
  border: 1px solid #ccc;
}
</style>
