<template>
  <div class="page-login">
    <PageTitle :title="$L('登录')" />
    <div class="login-body">
      <div
        class="login-logo no-dark-content"
        :class="{ 'can-click': needStartHome }"
        @click="goHome"
      ></div>


      <div class="text-center">
        <!--          <img-->
        <!--              class="mx-auto h-16 w-16"-->
        <!--              src="images/app-logo.svg"-->
        <!--              alt="logo"-->
        <!--          />-->
        <div class="mt-4">
          <h2 class="text-2xl font-semibold text-slate-600 dark:text-navy-100">
            {{ welcomeTitle }}
          </h2>
          <p class="text-slate-400 dark:text-navy-300">
            {{ $L(subTitle) }}
          </p>
        </div>
      </div>


      <div class="login-box">
<!--        <transition name="login-mode">-->
<!--          <div-->
<!--            v-if="loginMode == 'qrcode'"-->
<!--            class="login-qrcode"-->
<!--            @click="qrcodeRefresh"-->
<!--          >-->
<!--            <VueQrcode-->
<!--              :value="qrcodeUrl"-->
<!--              :options="{ width: 200, margin: 2 }"-->
<!--            ></VueQrcode>-->
<!--          </div>-->
<!--        </transition>-->


        <transition name="login-mode">
          <div v-if="loginMode == 'access'" class="card mt-5 rounded-lg p-5 lg:p-7" >
            <label class="block"  v-if="isSoftware && cacheServerUrl">
              <span>域名:</span>
              <span class="relative mt-1.5 flex">
              <Input
                  :value="$A.getDomain(cacheServerUrl)"
                  size="large"
                  readonly
                  clearable
                  @on-clear="setServerUrl('')"
              />
              </span>
            </label>

            <label class="mt-4 block">
              <span>邮箱:</span>
              <span class="relative mt-1.5 flex">
              <Input
                  v-model="email"
                  ref="email"
                  :placeholder="$L('输入您的电子邮件')"
                  type="email"
                  size="large"
                  @on-enter="onLogin"
                  clearable
              />
              </span>
            </label>

            <label class="mt-4 block">
              <span>密码:</span>
              <span class="relative mt-1.5 flex">
                  <Input
                      v-model="password"
                      ref="password"
                      :placeholder="$L('输入您的密码')"
                      type="password"
                      size="large"
                      @on-enter="onLogin"
                      clearable
                  />
              </span>
            </label>

            <label class="mt-4 block"  v-if="loginType == 'reg'">
              <span>确认密码:</span>
              <span class="relative mt-1.5 flex">
                  <Input
                      v-model="password2"
                      ref="password2"
                      :placeholder="$L('输入确认密码')"
                      type="password"
                      size="large"
                      @on-enter="onLogin"
                      clearable
                  />
              </span>
            </label>
<!--            <Input-->
<!--              v-if="loginType == 'reg' && needInvite"-->
<!--              v-model="invite"-->
<!--              ref="invite"-->
<!--              class="login-code"-->
<!--              :placeholder="$L('请输入注册邀请码')"-->
<!--              type="text"-->
<!--              size="large"-->
<!--              @on-enter="onLogin"-->
<!--              clearable-->
<!--              ><span slot="prepend">&nbsp;{{ $L("邀请码") }}&nbsp;</span></Input-->
<!--            >-->
<!--            <Input-->
<!--              v-if="loginType == 'login' && codeNeed"-->
<!--              v-model="code"-->
<!--              ref="code"-->
<!--              class="login-code"-->
<!--              :placeholder="$L('输入图形验证码')"-->
<!--              type="text"-->
<!--              size="large"-->
<!--              @on-enter="onLogin"-->
<!--              clearable-->
<!--            >-->
<!--              <Icon-->
<!--                type="ios-checkmark-circle-outline"-->
<!--                class="login-icon"-->
<!--                slot="prepend"-->
<!--              ></Icon>-->
<!--              <div slot="append" class="login-code-end" @click="refreshCode">-->
<!--                <div v-if="codeLoad > 0" class="code-load"><Loading /></div>-->
<!--                <span v-else-if="codeUrl === 'error'" class="code-error">{{-->
<!--                  $L("加载失败")-->
<!--                }}</span>-->
<!--                <img v-else :src="codeUrl" />-->
<!--              </div>-->
<!--            </Input>-->


            <div class="mt-4 flex items-center justify-between space-x-2">
              <label class="inline-flex items-center space-x-2">
                <span class="line-clamp-1"></span>
              </label>

              <a href="javascript:void(0)" @click="forgotPassword"
                  class="text-slate-400 transition-colors line-clamp-1 hover:text-slate-800 focus:text-slate-800 dark:text-navy-300 dark:hover:text-navy-100 dark:focus:text-navy-100"
              >忘记密码?</a
              >
            </div>

            <Button
                class = "mt-5"
              type="primary"
              :loading="loadIng > 0 || loginJump"
              size="large"
              long
              @click="onLogin"
              >{{ $L(loginText) }}</Button>

            <div class="mt-4 text-center text-xs+" v-if="loginType == 'reg'">
              <p class="line-clamp-1">
                <span>已经有帐号?</span>
                <a
                    class="text-primary transition-colors hover:text-primary-focus dark:text-accent-light dark:hover:text-accent"
                    href="javascript:void(0)" @click="loginType = 'login'"
                >登录帐号</a
                >
              </p>
            </div>

            <div class="mt-4 text-center text-xs+" v-else>
              <p class="line-clamp-1">
                <span>还没有帐号?</span>
                <a
                    class="text-primary transition-colors hover:text-primary-focus dark:text-accent-light dark:hover:text-accent"
                    href="javascript:void(0)" @click="loginType = 'reg'"
                >注册帐号</a
                >
              </p>
            </div>
          </div>
        </transition>
      </div>

    </div>

    <!--隐私政策提醒-->
    <Modal v-model="privacyShow" :title="$L('隐私协议')" :mask-closable="false">
      <div class="privacy-content">
        <div>欢迎使用本软件！</div>
        <p>
          在您使用本软件前，请您认真阅读并了解相应的<a
            target="_blank"
            :href="$A.apiUrl('privacy')"
            >《{{ $L("隐私政策") }}》</a
          >，以了解我们的服务内容和您相关个人信息的处理规则。我们将严格的按照隐私服务协议为您提供服务，保护您的个人信息。
        </p>
      </div>
      <div slot="footer" class="adaption">
        <Button type="default" @click="onPrivacy(false)">{{
          $L("不同意")
        }}</Button>
        <Button type="primary" @click="onPrivacy(true)">{{
          $L("同意")
        }}</Button>
      </div>
    </Modal>
  </div>
</template>

<script>
import { mapState } from "vuex";
import { Store } from "le5le-store";
import { languageList, languageType, setLanguage } from "../language";
import VueQrcode from "@chenfengyuan/vue-qrcode";

export default {
  components: { VueQrcode },
  data() {
    return {
      loadIng: 0,

      languageList,
      languageType,

      qrcodeVal: "",
      qrcodeTimer: null,
      qrcodeLoad: false,

      codeNeed: false,
      codeLoad: 0,
      codeKey: "",
      codeUrl: "",

      loginMode: "access",
      loginType: "login",
      loginJump: false,

      email: "",
      password: "",
      password2: "",
      code: "",
      invite: "",

      needStartHome: false,

      needInvite: false,

      subscribe: null,

      privacyShow: false,
    };
  },

  async mounted() {
    this.privacyShow =
      !!this.$isEEUiApp && (await $A.IDBString("cachePrivacyShow")) !== "no";
    this.email = (await $A.IDBString("cacheLoginEmail")) || "";
    //
    if (this.isSoftware) {
      this.chackServerUrl().catch((_) => {});
    } else {
      this.setServerUrl("").catch((_) => {});
    }
    //
    this.qrcodeTimer = setInterval(this.qrcodeStatus, 2000);
    //
    this.subscribe = Store.subscribe("useSSOLogin", () => {
      this.inputServerUrl();
    });
  },

  beforeDestroy() {
    clearInterval(this.qrcodeTimer);
    if (this.subscribe) {
      this.subscribe.unsubscribe();
      this.subscribe = null;
    }
  },

  activated() {
    this.loginType = this.$route.query.type === "reg" ? "reg" : "login";
    //
    this.getDemoAccount();
    this.getNeedStartHome();
    //
    if (this.$Electron) {
      this.$Electron.sendMessage("subWindowDestroyAll");
    }
  },

  deactivated() {
    this.loginJump = false;
    this.password = "";
    this.password2 = "";
    this.code = "";
    this.invite = "";
  },

  computed: {
    ...mapState(["cacheServerUrl", "themeMode", "themeList"]),

    isSoftware() {
      return this.$Electron || this.$isEEUiApp;
    },

    currentLanguage() {
      return languageList[languageType] || "Language";
    },

    welcomeTitle() {
      // if (this.loginMode == "qrcode") {
      //   return this.$L("扫码登录");
      // }
      // const title = window.systemInfo.title || "Autoo";
      // return "Welcome " + title;
      return "欢迎回来";
    },

    subTitle() {
      // const title = window.systemInfo.title || "Autoo";
      // if (this.loginMode == "qrcode") {
      //   return this.$L(`请使用${title}移动端扫描二维码。`);
      // }
      // if (this.loginType == "reg") {
      //   return this.$L(`输入您的信息以创建帐户。`);
      // }
      // return this.$L(`输入您的凭证以访问您的帐户。`);
      return "请登录以继续。"
    },

    loginText() {
      let text = this.loginType == "login" ? "登录" : "注册";
      if (this.loginJump) {
        text += "成功...";
      }
      return text;
    },

    qrcodeUrl() {
      return $A.apiUrl("../login?qrcode=" + this.qrcodeVal);
    },
  },

  watch: {
    $route({ query }) {
      if (query.type == "reg") {
        this.$nextTick(() => {
          this.loginType = "reg";
        });
      }
    },
    loginMode() {
      this.qrcodeRefresh();
    },
    loginType(val) {
      if (val == "reg") {
        this.getNeedInvite();
      }
    },
  },

  methods: {
    goHome() {
      if (this.needStartHome) {
        this.goForward("index");
      }
    },

    setTheme(mode) {
      this.$store.dispatch("setTheme", mode);
    },

    getDemoAccount() {
      if (this.isNotServer()) {
        return;
      }
      this.$store
        .dispatch("call", {
          url: "system/demo",
        })
        .then(({ data }) => {
          if (data.account) {
            this.email = data.account;
            this.password = data.password;
          }
        })
        .catch((_) => {
          //
        });
    },

    getNeedStartHome() {
      if (this.isNotServer()) {
        return;
      }
      this.$store
        .dispatch("needHome")
        .then((_) => {
          this.needStartHome = true;
        })
        .catch((_) => {
          this.needStartHome = false;
        });
    },

    getNeedInvite() {
      this.$store
        .dispatch("call", {
          url: "users/reg/needinvite",
        })
        .then(({ data }) => {
          this.needInvite = !!data.need;
        })
        .catch((_) => {
          this.needInvite = false;
        });
    },

    switchLoginMode() {
      this.chackServerUrl(true).then(() => {
        if (this.loginMode === "qrcode") {
          this.loginMode = "access";
        } else {
          this.loginMode = "qrcode";
        }
      });
    },

    qrcodeRefresh() {
      if (this.loginMode == "qrcode") {
        this.qrcodeVal = $A.randomString(32);
      }
    },

    qrcodeStatus() {
      if (this.$route.name !== "login" || this.loginMode != "qrcode") {
        return;
      }
      if (this.qrcodeLoad) {
        return;
      }
      this.qrcodeLoad = true;
      //
      this.$store
        .dispatch("call", {
          url: "users/login/qrcode?code=" + this.qrcodeVal,
        })
        .then(({ data }) => {
          this.$store.dispatch("handleClearCache", data).then(this.goNext);
        })
        .catch((_) => {
          //
        })
        .finally((_) => {
          this.qrcodeLoad = false;
        });
    },

    forgotPassword() {
      $A.modalWarning("请联系管理员！");
    },

    refreshCode() {
      if (this.codeLoad > 0) {
        return;
      }
      setTimeout((_) => {
        this.codeLoad++;
      }, 600);
      this.$store
        .dispatch("call", {
          url: "users/login/codejson",
        })
        .then(({ data }) => {
          this.codeKey = data.key;
          this.codeUrl = data.img;
        })
        .catch((_) => {
          this.codeUrl = "error";
        })
        .finally((_) => {
          this.codeLoad--;
        });
    },

    inputServerUrl() {
      if (this.privacyShow) {
        return;
      }
      let value = $A.rightDelete(this.cacheServerUrl, "/api/");
      value = $A.leftDelete(value, "http://");
      $A.modalInput({
        title: "使用 SSO 登录",
        value,
        placeholder: "请输入服务器地址",
        onOk: (value) => {
          if (!value) {
            return "请输入服务器地址";
          }
          return this.inputServerChack($A.trim(value));
        },
      });
    },

    inputServerChack(value) {
      return new Promise((resolve, reject) => {
        let url = value;
        if (!/\/api\/$/.test(url)) {
          url = url + ($A.rightExists(url, "/") ? "api/" : "/api/");
        }
        if (!/^https*:\/\//i.test(url)) {
          url = `https://${url}`;
        }
        this.$store
          .dispatch("call", {
            url: `${url}system/setting`,
            checkNetwork: false,
          })
          .then(async () => {
            await this.setServerUrl(url);
            resolve();
          })
          .catch(({ ret, msg }) => {
            if (ret === -1001) {
              if (!/^https*:\/\//i.test(value)) {
                this.inputServerChack(`http://${value}`)
                  .then(resolve)
                  .catch(reject);
                return;
              }
              msg = "服务器地址无效";
            }
            reject(msg);
          });
      });
    },

    chackServerUrl(tip) {
      return new Promise((resolve, reject) => {
        if (this.isNotServer()) {
          this.inputServerUrl();
          tip === true &&
            this.$nextTick((_) => $A.messageWarning("请设置服务器"));
          reject();
        } else {
          resolve();
        }
      });
    },

    async setServerUrl(value) {
      await $A.IDBSet("cachePrivacyShow", value ? "no" : "yes");
      //
      if (value != this.cacheServerUrl) {
        await $A.IDBSet("cacheServerUrl", value);
        $A.reloadUrl();
      }
    },

    isNotServer() {
      let apiHome = $A.getDomain(window.systemInfo.apiUrl);
      return this.isSoftware && (apiHome == "" || apiHome == "public");
    },

    onBlur() {
      if (this.loginType != "login" || !this.email) {
        this.codeNeed = false;
        return;
      }
      this.loadIng++;
      this.$store
        .dispatch("call", {
          url: "users/login/needcode",
          data: {
            email: this.email,
          },
        })
        .then(() => {
          this.refreshCode();
          this.codeNeed = true;
        })
        .catch((_) => {
          this.codeNeed = false;
        })
        .finally((_) => {
          this.loadIng--;
        });
    },

    onPrivacy(agree) {
      if (agree) {
        this.privacyShow = false;
        this.chackServerUrl().catch((_) => {});
      } else {
        $A.eeuiAppGoDesktop();
      }
    },

    onLogin() {
      this.chackServerUrl(true).then(() => {
        this.email = $A.trim(this.email);
        this.password = $A.trim(this.password);
        this.password2 = $A.trim(this.password2);
        this.code = $A.trim(this.code);
        this.invite = $A.trim(this.invite);
        //
        if (!$A.isEmail(this.email)) {
          $A.messageWarning("请输入正确的邮箱地址");
          this.$refs.email.focus();
          return;
        }
        if (!this.password) {
          $A.messageWarning("请输入密码");
          this.$refs.password.focus();
          return;
        }
        if (this.loginType == "reg") {
          if (this.password != this.password2) {
            $A.messageWarning("确认密码输入不一致");
            this.$refs.password2.focus();
            return;
          }
        }
        this.loadIng++;
        this.$store
          .dispatch("call", {
            url: "users/login",
            data: {
              type: this.loginType,
              email: this.email,
              password: this.password,
              code: this.code,
              code_key: this.codeKey,
              invite: this.invite,
            },
          })
          .then(({ data }) => {
            this.loadIng--;
            this.codeNeed = false;
            //这里需要执行清空缓存操作
            // this.$store.dispatch("cleanCacheProjects")
            // $A.IDBSet("clearCache", "handle").then(_ => {
            //   $A.reloadUrl()
            //   console.log("清除缓存成功！")
            // });

            $A.setStorage("cacheLoginEmail", this.email);
            $A.setStorage("cacheProjects", []);
            $A.setStorage("userInfo",{});


            this.$store
              .dispatch("handleClearCache", data)
              .then(() => {
                this.goNext();
              })
              .catch((_) => {
                this.goNext();
              });
          })
          .catch(({ data, msg }) => {
            this.loadIng--;
            $A.modalError(msg);
            // if (data.code === "email") {
            //   $A.modalWarning(message);
            // } else {
            //   $A.modalError(message);
            // }
            // if (data.code === "need") {
            //   this.reCode();
            //   this.codeNeed = true;
            // }
          });
      });
    },

    goNext() {
      this.loginJump = true;
      const fromUrl = decodeURIComponent(
        $A.getObject(this.$route.query, "from")
      );
      if (fromUrl) {
        $A.IDBSet("clearCache", "login").then((_) => {
          window.location.replace(fromUrl);
        });
      } else {
        this.goForward({ name: "manage-dashboard" }, true);
      }
    },

    onLanguage(l) {
      setLanguage(l);
    },
  },
};
</script>
