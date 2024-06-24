import * as vue from "vue";
import * as NaiveUI from 'naive-ui';
import * as router from '@/scripts/router'
import xicons from '@/scripts/xicons'
import svgIcons from '@/scripts/svg-icons'
import * as dictStore from "@/store/modules/dictStore";
import * as userStore from "@/store/modules/userStore";
import MbIcon from '@/components/magic/basic/mb-icon.vue';
import * as lodashEs from 'lodash-es'
import * as vueRouter from 'vue-router'
import * as  viewerApi from 'v-viewer'
import * as vueusecore from '@vueuse/core'
import * as player from 'xgplayer'
import * as modal from '@arco-design/web-vue'
import global from "@/scripts/global";


const libs = {
    vue,
    'naive-ui': NaiveUI,
    '@/scripts/xicons': xicons,
    '@/scripts/svg-icons': svgIcons,
    '@/scripts/router': router,
    '@/store/modules/dictStore': dictStore,
    '@/store/modules/userStore': userStore,
    '@/components/magic/basic/mb-icon.vue': MbIcon,
    'lodash-es': lodashEs,
    'vue-router': vueRouter,
    'v-viewer':viewerApi,
    '@vueuse/core':vueusecore,
    'xgplayer':player,
    '@/scripts/global': global,
}

window.___magic__import__ = function(lib, name){
    if(Object.prototype.toString.call(libs[lib]) != '[object Module]' && name == '*'){
        return libs[lib]
    }
    return (libs[lib] || {})[name]
}
