/*
 * @Date: 2022-08-25 11:58:11
 * @LastEditors: StavinLi 495727881@qq.com
 * @LastEditTime: 2022-09-21 14:36:07
 * @FilePath: /Workflow-Vue3/src/main.js
 */
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import { switchLanguage as $L, languageType, addLocales } from "./language";
import './assets/main.css'
import store from './store'
import './css/override-element-ui.css'
import 'element-plus/es/components/message/style/css'

// 加载语言
const loadLang = () => {
    return new Promise(async resolve => {
        await addLocales(languageType)
        resolve()
    })
}

// 
const app = createApp(App)
app.config.globalProperties.$L = $L
app.use(store)
app.use(router)
loadLang().then(() => {
    app.mount('#app')
})

import nodeWrap from '@/components/nodeWrap.vue'
app.component('nodeWrap', nodeWrap); //初始化组件
import addNode from '@/components/addNode.vue'
app.component('addNode', addNode); //初始化组件

app.directive('focus', {
    mounted(el) {
        el.focus();
    }
});

app.directive('enterNumber', {
    mounted(el, { value = 100 }, vnode) {
        el = el.nodeName == "INPUT" ? el : el.children[0]
        var RegStr = value == 0 ? `^[\\+\\-]?\\d+\\d{0,0}` : `^[\\+\\-]?\\d+\\.?\\d{0,${value}}`;
        el.addEventListener('input', function () {
            el.value = el.value.match(new RegExp(RegStr, 'g'));
            // el.dispatchEvent(new Event('input'))
        });
    }
});
