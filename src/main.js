const isElectron = !!(window && window.process && window.process.type);
const isEEUiApp =
  window && window.navigator && /eeui/i.test(window.navigator.userAgent);

import microappInit from "./microapp";
import { switchLanguage as $L, setLanguage, getLanguage } from "./language";

import "./functions/common";
import "./functions/eeui";
import "./functions/web";

import Vue from "vue";
import Vuex from "vuex";
import App from "./App.vue";
import routes from "./router";
import VueRouter from "vue-router";
import VueClipboard from "vue-clipboard2";
import ViewUI from "view-design-hi";
import store from "./store/index";
import mixin from "./store/mixin";
import "element-sea/lib/theme-chalk/index.css";
import "./css/iview.css"
import "./css/tailwindcss.css"
import "./sass/app.scss";
import './my-theme/index.less';

Vue.use(Vuex);
Vue.use(VueRouter);
Vue.use(VueClipboard, {
  config: {
    autoSetContainer: true,
  },
});
Vue.use(ViewUI, {
  modal: {
    checkEscClose: true,
  },
});

import PageTitle from "./components/PageTitle.vue";
import Loading from "./components/Loading.vue";
import AutoTip from "./components/AutoTip.vue";
import TagInput from "./components/TagInput.vue";
import TableAction from "./components/TableAction.vue";
import QuickEdit from "./components/QuickEdit.vue";
import UserAvatar from "./components/UserAvatar";
import ImgView from "./components/ImgView.vue";
import Scrollbar from "./components/Scrollbar";

Vue.component("PageTitle", PageTitle);
Vue.component("Loading", Loading);
Vue.component("AutoTip", AutoTip);
Vue.component("TagInput", TagInput);
Vue.component("TableAction", TableAction);
Vue.component("QuickEdit", QuickEdit);
Vue.component("UserAvatar", UserAvatar);
Vue.component("ImgView", ImgView);
Vue.component("Scrollbar", Scrollbar);

import {
  Avatar,
  Tooltip,
  Popover,
  Dropdown,
  DropdownMenu,
  DropdownItem,
} from "element-sea";

Vue.component("EAvatar", Avatar);
Vue.component("ETooltip", Tooltip);
Vue.component("EPopover", Popover);
Vue.component("EDropdown", Dropdown);
Vue.component("EDropdownMenu", DropdownMenu);
Vue.component("EDropdownItem", DropdownItem);

const originalPush = VueRouter.prototype.push;
VueRouter.prototype.push = function push(location) {
  return originalPush.call(this, location).catch((err) => err);
};

const router = new VueRouter({
  mode: 'hash', // 将路由模式设置为 hash 模式
  // mode: isElectron || isEEUiApp ? "hash" : "history",
  routes,
});

// 进度条配置
if (!isElectron && !isEEUiApp) {
  ViewUI.LoadingBar.config({
    color: "#3fcc25",
    failedColor: "#ff0000",
  });
  router.beforeEach((to, from, next) => {
    ViewUI.LoadingBar._timer && clearTimeout(ViewUI.LoadingBar._timer);
    ViewUI.LoadingBar._timer = setTimeout((_) => {
      ViewUI.LoadingBar._load = true;
      ViewUI.LoadingBar.start();
    }, 300);
    next();
  });
  router.afterEach(() => {
    ViewUI.LoadingBar._timer && clearTimeout(ViewUI.LoadingBar._timer);
    if (ViewUI.LoadingBar._load === true) {
      ViewUI.LoadingBar._load = false;
      ViewUI.LoadingBar.finish();
    }
  });
}

// 加载路由
Vue.prototype.goForward = function (location, isReplace) {
  if (typeof location === "string") {
    location = { name: location };
  }
  console.log(location, ">>>>>>>>>goForward");
  console.log(isReplace, ">>>>>>>>>goForward");
  if (app.$store.state.routeHistorys.length === 0) {
    app.$store.state.routeHistorys.push(app.$route);
  }
  if (isReplace === true) {
    app.$router
      .replace(location)
      .then((to) => {
        app.$store.state.routeHistorys.pop();
        app.$store.state.routeHistorys.push(to);
      })
      .catch((_) => {});
  } else {
    app.$router
      .push(location)
      .then((to) => {
        const length = app.$store.state.routeHistorys.push(to);
        length > 120 && app.$store.state.routeHistorys.splice(length - 100);
        app.$store.state.routeHistoryLast =
          length >= 2 ? app.$store.state.routeHistorys[length - 2] : {};
      })
      .catch((_) => {});
  }
};

// 返回路由
Vue.prototype.goBack = function () {
  if (app.$store.state.routeHistorys.length > 1) {
    app.$router.back();
    //
    app.$store.state.routeHistorys.pop();
    const length = app.$store.state.routeHistorys.length;
    app.$store.state.routeHistoryLast =
      length >= 2 ? app.$store.state.routeHistorys[length - 2] : {};
  } else {
    app.$router.replace({ path: "/" }).catch((_) => {});
    app.$store.state.routeHistorys = [];
    app.$store.state.routeHistoryLast = {};
  }
};

// 全局对象/变量
$A.L = $L;
$A.Electron = null;
$A.Platform = "web";
$A.isMainElectron = false;
$A.isSubElectron = false;
$A.isEEUiApp = isEEUiApp;
$A.isElectron = isElectron;
$A.openLog = false;
if (isElectron) {
  $A.Electron = electron;
  $A.Platform = /macintosh|mac os x/i.test(navigator.userAgent) ? "mac" : "win";
  $A.isMainElectron = /\s+MainTaskWindow\//.test(window.navigator.userAgent);
  $A.isSubElectron = /\s+SubTaskWindow\//.test(window.navigator.userAgent);
} else if (isEEUiApp) {
  $A.Platform = /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)
    ? "ios"
    : "android";
}

// 子窗口给主窗口发送指令相关
$A.execMainDispatch = (action, data) => {
  if ($A.isSubElectron) {
    $A.Electron.sendMessage("sendForwardMain", {
      channel: "dispatch",
      data: { action, data },
    });
  }
};

window.execMainCacheData = {};
$A.execMainCacheJudge = (key) => {
  const val = window.execMainCacheData[key] || false;
  window.execMainCacheData[key] = true;
  return val;
};

// 绑定截图快捷键
$A.bindScreenshotKey = (data) => {
  let key = "";
  const screenshot_key = (data.screenshot_key || "").trim().toLowerCase();
  if (screenshot_key) {
    key = /macintosh|mac os x/i.test(navigator.userAgent) ? "command" : "ctrl";
    key = `${key}+shift+${screenshot_key.toLowerCase()}`;
  }
  $A.Electron.sendMessage("bindScreenshotKey", { key });
};

Vue.prototype.$A = $A;
Vue.prototype.$L = $L;
Vue.prototype.$Electron = $A.Electron;
Vue.prototype.$Platform = $A.Platform;
Vue.prototype.$isMainElectron = $A.isMainElectron;
Vue.prototype.$isSubElectron = $A.isSubElectron;
Vue.prototype.$isEEUiApp = $A.isEEUiApp;

Vue.config.productionTip = false;
Vue.mixin(mixin);

let app;
store.dispatch("init").then((action) => {
  microappInit();

  app = new Vue({
    router,
    store,
    render: (h) => h(App),
    template: "<App/>",
  }).$mount("#app");

  $A.goForward = app.goForward;
  $A.goBack = app.goBack;
  $A.Message = app.$Message;
  $A.Notice = app.$Notice;
  $A.Modal = app.$Modal;

  if (action === "handleClearCache") {
    $A.messageSuccess("清除成功");
  }
});
