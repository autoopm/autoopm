import './styles/tailwind.css'
import '@/assets/css/common.css'
import 'vite-plugin-svg-icons/register'
import {createApp} from 'vue'
import App from './App.vue'
import {
    setupNaive,
    setupArco,
    setupNaiveDiscreteApi,
    setupDirectives,
    setupGlobalProperties,
    setupMonacoVolar,
    setupTheme,
    setupLayer
} from '@/scripts/plugins'
import {setupRouter} from '@/scripts/router'
import {setupStore} from '@/store'
import {setupComponents} from '@/components'
import '@/scripts/compiler/magic-import'



// 额外引入 Arco Design Icon图标库


import '@/styles/arco/arco-ui/index.less'
// 使用动画库
import 'animate.css/animate.min.css'
// 自定义过渡动画
import '@/styles/arco/css/transition.css'
// 导入全局scss主文件
// import '@/styles/arco/index.scss'
// 支持SVG
import 'virtual:svg-icons-register'


import 'viewerjs/dist/viewer.css'

const app = createApp(App)

async function start() {
    setupStore(app)
    setupNaive(app)
    setupArco(app)
    setupNaiveDiscreteApi()
    setupDirectives(app)
    setupGlobalProperties(app)
    await setupRouter(app)
    await setupMonacoVolar()
    setupComponents(app)
    await setupTheme()
    setupLayer(app)
    app.mount('#app')
}

void start()

