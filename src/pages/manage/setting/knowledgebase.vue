<template>
    <div class="setting-item submit">
        <Form ref="formDatum" :model="formDatum" :rules="ruleDatum" :labelPosition="formLabelPosition" :labelWidth="formLabelWidth" @submit.native.prevent>
          <FormItem :label="$L('连接地址')" prop="linkUrl">
            <Input v-model="formDatum.linkUrl" type="text" :placeholder="$L('请输入连接地址')"></Input>
          </FormItem>

          <FormItem :label="$L('账号')" prop="user">
                <Input v-model="formDatum.user" type="text" :placeholder="$L('请输入账号')"></Input>
            </FormItem>

            <FormItem :label="$L('密码')" prop="pwd">
                <Input v-model="formDatum.pwd" type="password" :placeholder="$L('请输入密码')"></Input>
            </FormItem>

            <FormItem :label="$L('应用id')" prop="appid">
                <Input v-model="formDatum.appid" type="text" :placeholder="$L('请输入应用id')"></Input>
            </FormItem>

            <FormItem :label="$L('全屏模式URL')" prop="iframeUrl" >
              <Input v-model="formDatum.iframeUrl" type="text" :placeholder="$L('请输入全屏模式URL')"></Input>
            </FormItem>

            <FormItem :label="$L('文件自动上传知识库')" prop="autoUpload">
              <RadioGroup :value="formDatum.auto_upload" @on-change="formUpload">
                <Radio label="open">{{$L('开启')}}</Radio>
                <Radio label="close">{{$L('关闭')}}</Radio>
              </RadioGroup>
            </FormItem>

        </Form>
        <div class="setting-footer">
            <Button :loading="loadIng > 0" type="primary" @click="submitForm">{{$L('提交')}}</Button>
            <Button :loading="loadIng > 0" @click="resetForm" style="margin-left: 8px">{{$L('重置')}}</Button>
        </div>
    </div>
</template>

<script>
import {mapState} from "vuex";

export default {
    data() {
        return {
            loadIng: 0,
            formDatum: {
              linkUrl: '',
              user: '',
              pwd: '',
              appid: '',
              iframeUrl: '',
              auto_upload:'open'
            },

            ruleDatum: {
              linkUrl:  [
                  { required: true, message: this.$L('请输入连接地址！'), trigger: 'change' },
                  { type: 'string', min: 6, message: this.$L('地址错误！'), trigger: 'change' }
                ],
              user:  [
                { required: true, message: this.$L('请输入账号！'), trigger: 'change' },
                { type: 'string', min: 5, message: this.$L('账号错误！'), trigger: 'change' }
              ],
              pwd:  [
                { required: true, message: this.$L('请输入密码！'), trigger: 'change' },
                { type: 'string', min: 1, message: this.$L('密码输入错误！'), trigger: 'change' }
              ],
              appid:  [
                { required: true, message: this.$L('请输入应用ID！'), trigger: 'change' },
                { type: 'string', min: 4, message: this.$L('应用ID输入错误！'), trigger: 'change' }
              ],
              iframeUrl:  [
                { required: true, message: this.$L('请输入集成URL！'), trigger: 'change' },
                { type: 'string', min: 4, message: this.$L('URL输入错误！'), trigger: 'change' }
              ],
            },
            nullDatum: {}
        }
    },

    mounted() {
      this.knowSetting();
    },
    computed: {
      ...mapState(['know']),
    },
    watch: {
      know: {
        handler(data) {
          console.log('进入到这里。。。。。'+data);
          console.log(data);
          this.formDatum = $A.cloneJSON(data);
          if (this.formDatum.length === 0) {
            this.addDatum();
          }
        },
        immediate: true,
      }
    },
    // computed: {
    //     ...mapState(['userInfo', 'formLabelPosition', 'formLabelWidth']),
    // },
    methods: {
        //自动上传文件
        formUpload(value) {
          this.formDatum = { ...this.formDatum, auto_upload: value };
        },

        knowSetting(save) {
          this.loadIng++;
          this.$store.dispatch("call", {
            url: 'system/know?type=' + (save ? 'save' : 'get'),
            method: 'post',
            data: {
              know: this.formDatum
            },
          }).then(({data}) => {
            if (save) {
              $A.messageSuccess('修改成功');
            }
            this.$store.state.know = $A.cloneJSON(data);
          }).catch(({msg}) => {
            if (save) {
              $A.modalError(msg);
            }
          }).finally(_ => {
            this.loadIng--;
          });
        },

        submitForm() {
          this.$refs.formDatum.validate((valid) => {
            if (valid) {
              this.knowSetting(true);
            }
          })
        },

        resetForm() {
            this.formDatum = $A.cloneJSON(this.know);
        },

        addDatum() {
          console.log("这里。。。。。。。。。。。。。。。。。。。。")
          this.formDatum.push($A.cloneJSON(this.nullDatum));
        },
    }
}
</script>
