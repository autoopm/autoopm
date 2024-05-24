<template>
  <div class="card mt-3 space-y-3.5 p-4 text-xs+ rounded-xl">
    <iframe
        :src="iframeSrc"
        style="width: 100%; height: 100%;"
        frameborder="0"
        allow="microphone">
    </iframe>
  </div>

</template>

<script>
import {mapState} from "vuex";
export default {
  data() {
    return {
      loadIng: 0,
      iframeUrl: ''
    }
  },
  computed: {
    ...mapState(['know']),
  },
  mounted() {
    this.knowSetting();
  },
  watch: {
    know: {
      handler(data) {
        console.log("进到这个页面")
        console.log(data);
        this.formDatum = $A.cloneJSON(data);
        this.iframeUrl = $A.cloneJSON(data).iframeUrl
        if (this.formDatum.length === 0) {
           //为空时候的处理
        }
      },
    }
  },
  methods: {
    knowSetting() {
      this.loadIng++;
      this.$store.dispatch("call", {
        url: 'system/know?type=get',
        method: 'post',
      }).then(({data}) => {
        console.log("获取知识库返回值",data)
        this.iframeSrc = $A.cloneJSON(data).iframeUrl;
        this.$store.state.know = $A.cloneJSON(data);
      }).catch(({msg}) => {
          $A.modalError(msg);
      }).finally(_ => {
        this.loadIng--;
      });
    },
  }
}
</script>