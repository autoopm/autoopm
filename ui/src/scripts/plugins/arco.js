import ArcoVue, { Card, Modal } from '@arco-design/web-vue'
import ArcoVueIcon from '@arco-design/web-vue/es/icon'


export function setupArco(app) {
    // 对特定组件进行默认配置
    Card.props.bordered = false
    Modal._context = app._context
    app.use(ArcoVue)
    app.use(ArcoVueIcon)

}
