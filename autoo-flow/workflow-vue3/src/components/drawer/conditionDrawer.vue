<template>
    <el-drawer :append-to-body="true" :title="$L('条件设置')" v-model="visible" custom-class="condition_copyer" :show-close="false" :size="550" :before-close="saveCondition"> 
        <template #header="{ titleId, titleClass }">
            <h3 :id="titleId" :class="titleClass">{{ $L('条件设置') }}</h3>
            <select v-model="conditionConfig.priorityLevel" class="priority_level">
                <option v-for="item in conditionsConfig.conditionNodes.length" :value="item" :key="item"> {{ $L('优先级') }}{{item}}</option>
            </select>
        </template>
        <div class="demo-drawer__content">
            <div class="condition_content drawer_content">
                <p class="tip">{{$L('当审批单同时满足以下条件时进入此流程')}}</p>
                <ul>
                    <li v-for="(item,index) in conditionConfig.conditionList" :key="index">
                        <span class="ellipsis">{{ $L(item.type==1 ? '发起人': item.showName) }} ：</span>
                        <div v-if="item.type==1">
                            <p :class="conditionConfig.nodeUserList.length > 0?'selected_list':''" @click.self="addConditionRole" style="cursor:text">
                                <span v-for="(item1,index1) in conditionConfig.nodeUserList" :key="index1">
                                    {{item1.name}}<img src="@/assets/images/add-close1.png" @click="$func.removeEle(conditionConfig.nodeUserList,item1,'targetId')">
                                </span>
                                <input type="text" :placeholder="$L('请选择具体人员/角色/部门')" v-if="conditionConfig.nodeUserList.length == 0" @click="addConditionRole">
                            </p>
                        </div>
                        <div v-else-if="item.columnType == 'String' && item.showType == 3">
                            <p class="check_box" v-if="item.fixedDownBoxValue">
                                <a :class="$func.toggleStrClass(item,item1.key)&&'active'" @click="toStrChecked(item,item1.key)"
                                v-for="(item1,index1) in JSON.parse(item.fixedDownBoxValue)" :key="index1">{{item1.value}}</a>
                            </p>
                        </div>
                        <div v-else>
                            <p style="display: flex;">
                                <select v-model="item.optType" :style="'width:'+(item.optType==6?370:100)+'px'" @change="changeOptType(item)">
                                    <option value="1">{{$L('小于')}}</option>
                                    <option value="2">{{$L('大于')}}</option>
                                    <option value="3">{{$L('小于等于')}}</option>
                                    <option value="4">{{$L('等于')}}</option>
                                    <option value="5">{{$L('大于等于')}}</option>
                                    <option value="6">{{$L('介于两个数之间')}}</option>
                                </select>
                                <input v-if="item.optType!=6" type="text" :placeholder="$L('请输入'+item.showName)" v-enter-number="2" v-model="item.zdy1">
                                <span style=" width: 40px;line-height: 35px;text-align: center;">小时</span>
                            </p>
                            <p v-if="item.optType==6">
                                <input type="text" style="width:75px;" class="mr_10" v-enter-number="2" v-model="item.zdy1">
                                <select style="width:60px;" v-model="item.opt1">
                                    <option value="<">&lt;</option>
                                    <option value="≤">≤</option>
                                </select>
                                <span class="ellipsis" style="display:inline-block;width:60px;vertical-align: text-bottom;">{{$L(item.showName)}}</span>
                                <select style="width:60px;" class="ml_10" v-model="item.opt2">
                                    <option value="<">&lt;</option>
                                    <option value="≤">≤</option>
                                </select>
                                <input type="text" style="width:75px;" v-enter-number="2" v-model="item.zdy2">
                            </p>
                        </div>
                        <a v-if="item.type==1" @click="conditionConfig.nodeUserList= [];$func.removeEle(conditionConfig.conditionList,item,'columnId')">{{$L('删除')}}</a>
                        <a v-if="item.type==2" @click="$func.removeEle(conditionConfig.conditionList,item,'columnId')">{{$L('删除')}}</a>
                    </li>
                </ul>
                <el-button @click="addCondition">{{$L('添加条件')}}</el-button>
                <el-dialog :title="$L('选择条件')" v-model="conditionVisible" :width="480" append-to-body class="condition_list">
                    <p>{{$L('请选择用来区分审批流程的条件字段')}}</p>
                    <p class="check_box">
                        <a :class="$func.toggleClass(conditionList || [],{columnId:0},'columnId')&&'active'" @click="$func.toChecked(conditionList || [],{columnId:0},'columnId')">{{$L('发起人')}}</a>
                        <a v-for="(item,index) in conditions" :key="index" :class="$func.toggleClass(conditionList || [],item,'columnId')&&'active'" 
                        @click="$func.toChecked(conditionList  || [],item,'columnId')">{{$L(item.showName)}}</a>
                    </p>
                    <template #footer>
                        <el-button @click="conditionVisible = false">{{$L('取 消')}}</el-button>
                        <el-button type="success" @click="sureCondition">{{$L('确 定')}}</el-button>
                    </template>
                </el-dialog>
            </div>
            <employees-role-dialog 
                v-model:visible="conditionRoleVisible"
                :data="checkedList"
                @change="sureConditionRole"
                :isDepartment="true"
            />
            <div class="demo-drawer__footer clear">
                <el-button type="success" @click="saveCondition">确 定</el-button>
                <el-button @click="closeDrawer">取 消</el-button>
            </div>
        </div>
    </el-drawer>
</template>
<script setup>
import employeesRoleDialog from '../dialog/employeesRoleDialog.vue'
import $func from '@/plugins/preload'
import { mapState, mapMutations } from '@/plugins/lib.js'
import { getConditions } from '@/plugins/api.js'
import { ref, watch, computed,getCurrentInstance } from 'vue'
import { useRoute } from 'vue-router'

const {proxy} = getCurrentInstance()
let conditionVisible = ref(false)
let conditionsConfig = ref({
    conditionNodes: [],
})
let conditionConfig = ref({})
let PriorityLevel = ref('')
let conditions = ref([])
let conditionList = ref([])
let checkedList = ref([])
let conditionRoleVisible = ref(false)
const route=useRoute()

let { tableId, conditionsConfig1, conditionDrawer } = mapState()

let visible = computed({
    get() {
        return conditionDrawer.value
    },
    set() {
        closeDrawer()
    }
})
watch(conditionsConfig1, (val) => {
    conditionsConfig.value = val.value;
    PriorityLevel.value = val.priorityLevel
    conditionsConfig.value.conditionNode = conditionsConfig.value.conditionNode || []
    // 
    var condition = val.priorityLevel ? conditionsConfig.value.conditionNodes[val.priorityLevel - 1] : { nodeUserList: [], conditionList: [] };
    condition.nodeUserList = condition.nodeUserList || [];
    conditionConfig.value = condition;
})
let { setCondition, setConditionsConfig } = mapMutations()

const changeOptType = (item) => {
    if (item.optType == 1) {
        item.zdy1 = "2";
    } else {
        item.zdy1 = "1";
        item.zdy2 = "2";
    }
}
const toStrChecked = (item, key) => {
    let a = item.zdy1 ? item.zdy1.split(",") : []
    var isIncludes = $func.toggleStrClass(item, key);
    if (!isIncludes) {
        a.push(key)
        item.zdy1 = a.toString()
    } else {
        removeStrEle(item, key);
    }
}
const removeStrEle = (item, key) => {
    let a = item.zdy1 ? item.zdy1.split(",") : []
    var includesIndex;
    a.map((item, index) => {
        if (item == key) {
            includesIndex = index
        }
    });
    a.splice(includesIndex, 1);
    item.zdy1 = a.toString()
}

const addCondition = async () => {
    conditionList.value = [];
    conditionVisible.value = true;
    // let { data } = await getConditions({ tableId: tableId.value })
    // conditions.value = data;

    conditions.value = [
        // {
        //     "columnId": "1090",
        //     "showType": "1",
        //     "showName": "预计采购总费用",
        //     "columnName": "planProcurementTotalMoney",
        //     "columnType": "Double",
        //     "fixedDownBoxValue": ""
        // },
    ];

    if((route.query.name || '').indexOf("请假") !== -1) {
        conditions.value.push({
            "columnId": 2,
            "showType": "3",
            "showName": "假期类型",
            "columnName": "type",
            "columnType": "String",
            "fixedDownBoxValue": `
                {
                    "1":{"key":"1","value":"年假","type":"1"},
                    "2":{"key":"2","value":"事假","type":"2"},
                    "3":{"key":"3","value":"病假","type":"3"},
                    "4":{"key":"4","value":"调休","type":"4"},
                    "5":{"key":"5","value":"产假","type":"5"},
                    "6":{"key":"6","value":"婚假","type":"6"},
                    "7":{"key":"7","value":"丧假","type":"7"},
                    "8":{"key":"8","value":"陪产假","type":"8"},
                    "9":{"key":"9","value":"哺乳假","type":"9"}
                }
            `
        })
        conditions.value.push({
            "columnId": 3,
            "showType": "3",
            "showName": "请假时长",
            "columnName": "lengthOfLeave",
            "columnType": "Double",
            "fixedDownBoxValue": ""
        })
    }else{
        conditions.value.push({
            "columnId": 3,
            "showType": "3",
            "showName": "加班时长",
            "columnName": "overtimeHours",
            "columnType": "Double",
            "fixedDownBoxValue": ""
        })
    }
    
    if (conditionConfig.value.conditionList) {
        for (var i = 0; i < conditionConfig.value.conditionList.length; i++) {
            var { columnId } = conditionConfig.value.conditionList[i]
            if (columnId == 0) {
                conditionList.value.push({ columnId: 0 })
            } else {
                conditionList.value.push(conditions.value.filter(item => { return item.columnId == columnId; })[0])
            }
        }
    }
}

const sureCondition = () => {
    //1.弹窗有，外面无+
    //2.弹窗有，外面有不变
    conditionConfig.value.conditionList = conditionConfig.value.conditionList || [];
    for (var i = 0; i < conditionList.value.length; i++) {
        var { columnId, showName, columnName, showType, columnType, fixedDownBoxValue } = conditionList.value[i];
        if ($func.toggleClass(conditionConfig.value.conditionList, conditionList.value[i], "columnId")) {
            continue;
        }
        if (columnId == 0) {
            conditionConfig.value.nodeUserList = [];
            conditionConfig.value.conditionList.push({
                "type": 1,
                "columnId": columnId,
                "showName": '发起人',
                "columnName": "initiator",
            });
        } else {
            if (columnType == "Double") {
                conditionConfig.value.conditionList.push({
                    "showType": showType,
                    "columnId": columnId,
                    "type": 2,
                    "showName": showName,
                    "optType": "1",
                    "zdy1": "2",
                    "opt1": "<",
                    "zdy2": "",
                    "opt2": "<",
                    "columnDbname": columnName,
                    "columnType": columnType,
                })
            } else if (columnType == "String" && showType == "3") {
                conditionConfig.value.conditionList.push({
                    "showType": showType,
                    "columnId": columnId,
                    "type": 2,
                    "showName": showName,
                    "zdy1": "",
                    "columnDbname": columnName,
                    "columnType": columnType,
                    "fixedDownBoxValue": fixedDownBoxValue
                })
            }
        }
    }
    //3.弹窗无，外面有-
    for (let i = conditionConfig.value.conditionList.length - 1; i >= 0; i--) {
        if (!$func.toggleClass(conditionList.value, conditionConfig.value.conditionList[i], "columnId")) {
            conditionConfig.value.conditionList.splice(i, 1);
        }
    }
    conditionConfig.value.conditionList.sort(function (a, b) { return a.columnId - b.columnId; });
    conditionVisible.value = false;
}
const saveCondition = () => {
    closeDrawer()
    var a = conditionsConfig.value.conditionNodes.splice(PriorityLevel.value - 1, 1)//截取旧下标
    conditionsConfig.value.conditionNodes.splice(conditionConfig.value.priorityLevel - 1, 0, a[0])//填充新下标
    conditionsConfig.value.conditionNodes.map((item, index) => {
        // item.priorityLevel = index + 1
    });
    for (var i = 0; i < conditionsConfig.value.conditionNodes.length; i++) {
        conditionsConfig.value.conditionNodes[i].error = $func.conditionStr(conditionsConfig.value, i) == "请设置条件" && i != conditionsConfig.value.conditionNodes.length - 1
    }
    setConditionsConfig({
        value: conditionsConfig.value,
        flag: true,
        id: conditionsConfig1.value.id
    })
}
const addConditionRole = () => {
    conditionRoleVisible.value = true;
    checkedList.value = conditionConfig.value.nodeUserList
}
const sureConditionRole = (data) => {
    conditionConfig.value.nodeUserList = data;
    conditionRoleVisible.value = false;
}
const closeDrawer = (val) => {
    setCondition(false)
}
</script>

<style lang="less">
.condition_copyer {
    .priority_level {
        position: absolute;
        top: 11px;
        right: 30px;
        width: 100px;
        height: 32px;
        background: rgba(255, 255, 255, 1);
        border-radius: 4px;
        border: 1px solid rgba(217, 217, 217, 1);
        font-size: 12px;
    }

    .condition_content {
        padding: 20px 20px 0;

        p.tip {
            margin: 20px 0;
            width: 510px;
            text-indent: 17px;
            line-height: 45px;
            background: rgba(241, 249, 255, 1);
            border: 1px solid rgba(64, 163, 247, 1);
            color: #46a6fe;
            font-size: 14px;
        }

        ul {
            max-height: 500px;
            overflow-y: scroll;
            margin-bottom: 20px;

            li {
                &>span {
                    float: left;
                    margin-right: 8px;
                    width: 70px;
                    line-height: 32px;
                    text-align: right;
                }

                &>div {
                    display: inline-block;
                    width: 370px;

                    &>p:not(:last-child) {
                        margin-bottom: 10px;
                    }
                }

                &:not(:last-child)>div>p {
                    margin-bottom: 20px;
                }

                &>a {
                    float: right;
                    margin-right: 10px;
                    margin-top: 7px;
                }

                select,
                input {
                    width: 100%;
                    height: 32px;
                    background: rgba(255, 255, 255, 1);
                    border-radius: 4px;
                    border: 1px solid rgba(217, 217, 217, 1);
                }

                select+input {
                    width: 260px;
                }

                select {
                    margin-right: 10px;
                    width: 100px;
                }

                p.selected_list {
                    padding-left: 10px;
                    border-radius: 4px;
                    min-height: 32px;
                    border: 1px solid rgba(217, 217, 217, 1);
                    word-break: break-word;
                }

                p.check_box {
                    line-height: 32px;
                }
            }
        }

        .el-button {
            margin-bottom: 20px;
        }
    }
}

.condition_list {
    .el-dialog__body {
        padding: 16px 26px;
    }

    p {
        color: #666666;
        margin-bottom: 10px;

        &>.check_box {
            margin-bottom: 0;
            line-height: 36px;
        }
    }
}
</style>