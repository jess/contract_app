<template>
  <div v-html="markdownContent"></div>
</template>

<script>
  import showdown from 'showdown'
  export default {
    props: ['contract'],
    computed: {
      markdownContent: function() {
        var content = this.contract.content
        var reg = /\{\{(.*?)\}\}/g
        var custom_fields = this.contract.custom_fields
        var found
        while (found = reg.exec(content)) {
          var value = custom_fields.filter(function(f) { return f.name == found[1];  })
          if(value.length > 0) {
            var value = value[0].value
            content = content.replace(found[0], value)
          } else {
            content = content.replace(found[0], "---Not Found---")
          }
        }

        var converter = new showdown.Converter();
        return converter.makeHtml(content);
      }
    }
  }
</script>

<style lang="scss" scoped>
</style>
