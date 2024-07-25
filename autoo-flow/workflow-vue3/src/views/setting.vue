<template>
    <div>

        <!-- <div class="fd-nav">
            <div class="fd-nav-left">
                <div class="fd-nav-back" @click="toReturn">
                    <i class="anticon anticon-left"></i>
                </div>
                <div class="fd-nav-title">{{ workFlowDef.name || '' }}</div>
            </div>
            <div class="fd-nav-right">
                <button type="button" class="ant-btn button-publish" @click="saveSet">
                    <span>发 布</span>
                </button>
            </div>
        </div> -->

        <div class="fd-nav-title" style="position: fixed;left: 30px;z-index: 10;top: 30px;font-size: 20px;">{{ $L(workFlowDef.name || '') }}</div>
        <el-button type="success" @click="saveSet" style="position: fixed;right: 40px;z-index: 10;bottom: 30px;">{{ $L('发 布')}}</el-button>
        
        <div class="fd-nav-content" style="top: 0px;">
            <section class="dingflow-design">
                <div class="zoom">
                    <div class="zoom-out" :class="nowVal == 50 && 'disabled'" @click="zoomSize(1)"></div>
                    <span>{{ nowVal }}%</span>
                    <div class="zoom-in" :class="nowVal == 300 && 'disabled'" @click="zoomSize(2)"></div>
                </div>
                <div class="box-scale" :style="`transform: scale(${nowVal / 100});`">
                    <nodeWrap v-model:nodeConfig="nodeConfig" v-model:flowPermission="flowPermission" />
                    <div class="end-node">
                        <div class="end-node-circle"></div>
                        <div class="end-node-text">{{$L('流程结束')}}</div>
                    </div>
                </div>
            </section>
        </div>
        
        <errorDialog v-model:visible="tipVisible" :list="tipList" />
        <promoterDrawer />
        <approverDrawer :directorMaxLevel="directorMaxLevel" />
        <copyerDrawer />
        <conditionDrawer />
    </div>
</template>

<script setup>
import errorDialog from "@/components/dialog/errorDialog.vue";
import promoterDrawer from "@/components/drawer/promoterDrawer.vue";
import approverDrawer from "@/components/drawer/approverDrawer.vue";
import copyerDrawer from "@/components/drawer/copyerDrawer.vue";
import conditionDrawer from "@/components/drawer/conditionDrawer.vue";
import { ElMessage } from 'element-plus'
import { ref, onMounted,getCurrentInstance } from "vue";
import { useRoute,useRouter } from 'vue-router'
import { getWorkFlowData, setWorkFlowData } from "@/plugins/api.js";
import { mapMutations } from "@/plugins/lib.js";

const {proxy} = getCurrentInstance()
const router=useRouter()
const route=useRoute()
let { setTableId, setIsTried } = mapMutations()
let tipList = ref([]);
let tipVisible = ref(false);
let nowVal = ref(90);
let processConfig = ref({});
let nodeConfig = ref({});
let workFlowDef = ref({});
let flowPermission = ref([]);
let directorMaxLevel = ref(0);
let workFlowDefId = ref(0);
let showbtn = ref(true);

onMounted(async () => {
    if(route.query.showbtn=="0"){
        showbtn.value = false;
    }
    if(!route.query.name){
        ElMessage.error( proxy.$L("流程名称不能为空") )
        return;
    }
    // token
    if(route.query.token){
        sessionStorage.token = route.query.token
    }
    // 
    init()
});

// 初始化
const init = async () => {
    let company = "系统默认";
    let {data,status,message} = await getWorkFlowData({ company:company, name:route.query.name })
    if (status != 200) {
        ElMessage.error(message)
        return;
    }
    if(data?.resource){
        processConfig.value = data;
        nodeConfig.value = data?.resource;
    }else{
        processConfig.value = {
            "userid": "1",
            "username": company,
            "company":company,
            "name": route.query.name,
        };
        nodeConfig.value = {
            "name": proxy.$L("发起人"),
            "type": "start",
            "nodeId": "sid-startevent",
            "childNode": {},
            "conditionNodes": []
        };
    }
    flowPermission.value = [];
    directorMaxLevel.value = 4; //最高级别
    workFlowDef.value = processConfig.value;
    setTableId(workFlowDefId.value || 0);
};

/**
 * 返回错误
 * @param {*} param0 
 */
const reErr = ({ childNode }) => {
    if (childNode) {
        let { type, error, name, conditionNodes, ccSelfSelectFlag, nodeUserList } = childNode;
        if ( type == 'start' || type == 'approver' || type == 'notifier') {
            if (error || (type == 'notifier' && ccSelfSelectFlag == 0 && nodeUserList?.length == 0) ) {
                childNode.error = 1;
                tipList.value.push({
                    name: name,
                    type: ["", "审核人", "抄送人"][type],
                });
            }
            reErr(childNode);
        } else if (type == 'condition') {
            reErr(childNode);
        } else if (type == 'route') {
            reErr(childNode);
            for (var i = 0; i < conditionNodes?.length; i++) {
                if (conditionNodes[i].error) {
                    tipList.value.push({ name: conditionNodes[i].name, type:  proxy.$L("条件") });
                }
                reErr(conditionNodes[i]);
            }
        }
    } else {
        childNode = null;
    }
};

/**
 * 保存
 * @param
 */
const saveSet = async () => {
    setIsTried(true);
    // 
    tipList.value = [];
    reErr(nodeConfig.value);
    if (tipList.value?.length != 0) {
        tipVisible.value = true;
        return;
    }
    // 
    processConfig.value.flowPermission = flowPermission.value;
    processConfig.value.resource = nodeConfig.value;
    processConfig.value.id = Number(workFlowDefId.value || 0);
    let res = await setWorkFlowData(processConfig.value);
    if (res.status == 200) {
        ElMessage.success( proxy.$L("设置成功") )
        workFlowDefId.value = res.data;
        // router.replace({
        //     path:'/',
        //     query:{
        //         workFlowDefId: workFlowDefId.value,
        //     }
        // })
        if(window.parent){
            parent.postMessage(JSON.stringify({"method":"saveSuccess","res":res}), '*')
        }
    }else{
        ElMessage.error(res.message)
    }
};

/**
 * 调整大小
 */
const zoomSize = (type) => {
    if (type == 1) {
        if (nowVal.value == 50) {
            return;
        }
        nowVal.value -= 10;
    } else {
        if (nowVal.value == 300) {
            return;
        }
        nowVal.value += 10;
    }
};

/**
 * 监听保存事件
 */
window.addEventListener('message', (e) => {
    if (typeof e.data === 'string') {
        let propsBody = JSON.parse(e.data);
        if( propsBody.method == "save"){
            saveSet()
        }
    }
})

</script>
<style>
@import "../css/workflow.css";
/* .error-modal-list {
    width: 455px;
} */
</style>