import { getCurrentInstance } from "vue";
import {switchLanguage as $L} from "../language";
const proxy = {
    $L : (lang)=>{
       return $L(lang)
    }
};

function All() {}
All.prototype = {
    timer: "",
    debounce(fn, delay = 500) {
        var _this = this;
        return function(arg) {
            //获取函数的作用域和变量
            let that = this;
            let args = arg;
            clearTimeout(_this.timer) // 清除定时器
            _this.timer = setTimeout(function() {
                fn.call(that, args)
            }, delay)
        }
    },
    setCookie(val) { //cookie设置[{key:value}]、获取key、清除['key1','key2']
        for (var i = 0, len = val.length; i < len; i++) {
            for (var key in val[i]) {
                document.cookie = key + '=' + encodeURIComponent(val[i][key]) + "; path=/";
            }
        }
    },
    getCookie(name) {
        var strCookie = document.cookie;
        var arrCookie = strCookie.split("; ");
        for (var i = 0, len = arrCookie.length; i < len; i++) {
            var arr = arrCookie[i].split("=");
            if (name == arr[0]) {
                return decodeURIComponent(arr[1]);
            }
        }
    },
    clearCookie(name) {
        var myDate = new Date();
        myDate.setTime(-1000); //设置时间    
        for (var i = 0, len = name.length; i < len; i++) {
            document.cookie = "" + name[i] + "=''; path=/; expires=" + myDate.toGMTString();
        }
    },
    arrToStr(arr) {
        if (arr) {
            return arr.map(item => { return item.name }).toString()
        }
    },
    toggleClass(arr, elem, key = 'id') {
        return arr.some(item => { return item[key] == elem[key] });
    },
    toChecked(arr, elem, key = 'id') {
        var isIncludes = this.toggleClass(arr, elem, key);
        !isIncludes ? arr.push(elem) : this.removeEle(arr, elem, key);
    },
    removeEle(arr, elem, key = 'id') {
        var includesIndex;
        arr.map((item, index) => {
            if (item[key] == elem[key]) {
                includesIndex = index
            }
        });
        arr.splice(includesIndex, 1);
    },
    setApproverStr(nodeConfig) {
        if (nodeConfig.settype == 1) {
            if (nodeConfig.nodeUserList?.length == 1) {
                return nodeConfig.nodeUserList[0].name
            } else if (nodeConfig.nodeUserList?.length > 1) {
                if (nodeConfig.examineMode == 1) {
                    return this.arrToStr(nodeConfig.nodeUserList)
                } else if (nodeConfig.examineMode == 2) {
                    return nodeConfig.nodeUserList.length + proxy.$L("人会签")
                }
            }
        } else if (nodeConfig.settype == 2) {
            let level = nodeConfig.directorLevel == 1 ? proxy.$L('直接主管') : proxy.$L('第' + nodeConfig.directorLevel + '级主管')
            if (nodeConfig.examineMode == 1) {
                return level
            } else if (nodeConfig.examineMode == 2) {
                return level + proxy.$L("会签")
            }
        }  else if (nodeConfig.settype == 3) {
            return proxy.$L("从直接主管到通讯录中级别最高的第") + nodeConfig.examineEndDirectorLevel + proxy.$L("个层级主管")
        }
    },
    dealStr(str, obj) {
        let arr = [];
        let list = str.split(",");
        for (var elem in obj) {
            list.map(item => {
                if (item == elem) {
                    arr.push(obj[elem].value)
                }
            })
        }
        return arr.join("或")
    },  
    conditionStr(nodeConfig, index) {
        var { conditionList, nodeUserList } = nodeConfig.conditionNodes[index];
        conditionList = conditionList || [];
        nodeUserList = nodeUserList || [];
        if (!conditionList || conditionList.length == 0) {
            return (index == nodeConfig.conditionNodes.length - 1) && nodeConfig.conditionNodes[0].conditionList.length != 0 ? proxy.$L("其他条件进入此流程") : proxy.$L("请设置条件")
        }else {
            let str = ""
            for (var i = 0; i < conditionList.length; i++) {
                var { columnId, columnType, showType, showName, optType, zdy1, opt1, zdy2, opt2, fixedDownBoxValue } = conditionList[i];
                if (columnId == 0) {
                    if (nodeUserList.length != 0) {
                        str += proxy.$L('发起人属于：') 
                        str += nodeUserList.map(item => { return item.name }).join("或") + " 并且 "
                    }
                }
                if (fixedDownBoxValue && columnType == "String" && showType == "3") {
                    if (zdy1) {
                        str += showName + '属于：' + this.dealStr(zdy1, JSON.parse(fixedDownBoxValue)) + " 并且 "
                    }
                }
                if (columnType == "Double") {
                    if (optType != 6 && zdy1) {
                        var optTypeStr = ["", "<", ">", "≤", "=", "≥"][optType]
                        str += `${showName} ${optTypeStr} ${zdy1} 并且 `
                    } else if (optType == 6 && zdy1 && zdy2) {
                        str += `${zdy1} ${opt1} ${showName} ${opt2} ${zdy2} 并且 `
                    }
                }
            }
            return str ? str.substring(0, str.length - 4) : proxy.$L('请设置条件')
        }
    },
    copyerStr(nodeConfig) {
        if (nodeConfig.nodeUserList?.length != 0) {
            return this.arrToStr(nodeConfig.nodeUserList)
        } else {
            if (nodeConfig.ccSelfSelectFlag == 1) {
                return proxy.$L("发起人自选")
            }
        }
    }, 
    toggleStrClass(item, key) {
        let a = item.zdy1 ? item.zdy1.split(",") : []
        return a.some(item => { return item == key });
    },
}

export default new All();