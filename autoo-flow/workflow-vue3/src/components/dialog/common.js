/*
 * @Date: 2022-08-25 14:05:59
 * @LastEditors: StavinLi 495727881@qq.com
 * @LastEditTime: 2022-09-21 14:36:34
 * @FilePath: /Workflow-Vue3/src/components/dialog/common.js
 */
import { getRoles, getDepartments, getEmployees } from '@/plugins/api.js'
import $func from '@/plugins/preload.js'
import { ref } from 'vue'
export let searchVal = ref('')
export let departments = ref({
    titleDepartments: [],
    childDepartments: [],
    employees: [],
})

export let roles = ref({})
export let getRoleList = async () => {
    let { data: { list } } = await getRoles()
    roles.value = list;
}

export let getDepartmentList = async (parentId = 0) => {
    let titleDepartments = departments.value.titleDepartments;
    let isDel = false;
    titleDepartments.forEach((h,index) => {
        if(isDel){
            titleDepartments.splice(index, 1);
        }
        if(h.id == parentId){
            isDel = true;
        }
    });
    if(parentId===0){
        titleDepartments = [];
    }
    let { data } = await getDepartments({ parentId })
    data.titleDepartments = titleDepartments
    data.childDepartments = data.childDepartments.map(h => {
        h.parentId = h.parent_id;
        h.departmentName = h.name;
        h.departmentNames = h.name;
        h.departmentKey = h.name;
        return h;
    });
    data.employees = data.employees.map(h => {
        h.id = h.userid;
        h.isLeave = 0;
        h.open = false;
        h.employeeName = h.nickname || h.email;
        return h;
    });
    departments.value = data;
}

export let getDebounceData = (event, type = 1) => {
    $func.debounce(async () => {
        if (event.target.value) {
            let data = {
                searchName: event.target.value,
                pageNum: 1,
                pageSize: 50
            }
            if (type == 1) {
                departments.value.childDepartments = [];
                let res = await getEmployees(data)
                departments.value.employees = res.data.list.map(h =>{
                    h.id = h.userid;
                    h.employeeName = h.nickname || h.email;
                    // "departmentName": "招商事业部",
                    // "employeeDepartmentId": "121",
                    // "departmentNames": "招商事业部"
                    return h;
                });
            } else {
                let res = await getRoles(data)
                roles.value = res.data.list
            }
        } else {
            type == 1 ? await getDepartmentList() : await getRoleList();
        }
    })()
}