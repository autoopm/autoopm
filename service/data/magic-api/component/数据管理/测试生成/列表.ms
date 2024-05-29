{
  "properties" : { },
  "id" : "b35e1c055131478d8ebabb7a64eb721d",
  "script" : null,
  "groupId" : "eb5dbed949de4f50ba4bf59f483252a5",
  "name" : "列表",
  "createTime" : 1716867162847,
  "updateTime" : 1709100179824,
  "lock" : null,
  "createBy" : null,
  "updateBy" : null,
  "path" : "/list",
  "description" : null
}
================================
<template>
    <mb-list ref="magicList" v-bind="listOptions" />
    <mb-dialog ref="formDialog" :title="magicFormTitle" @confirm-click="magicForm.save($event)" width="50%">
        <template #content>
            <mb-form ref="magicForm" @reload="magicList.reload" v-bind="formOptions" />
        </template>
    </mb-dialog>
</template>
<script setup>
    import { ref, reactive, getCurrentInstance, nextTick } from 'vue'
    const { proxy } = getCurrentInstance()
    const formDialog = ref()
    const magicList = ref()
    const magicForm = ref()
    const magicFormTitle = ref()
    const listOptions = reactive({
        tools: [{
            type: 'add',
            permission: 'data:test:save',
            click: () => {
                magicFormTitle.value = '添加'
                formDialog.value.show()
            }
        }],
        table: {
            url: '/data/test/list',
            where: {
                name: {
                    label: '名字'
                },
                sex: {
                    label: '性别'
                },
                headPortrait: {
                    label: '头像'
                },
                remarks: {
                    label: '备注'
                }
            },
            cols: [
                {
                    field: 'name',
                    label: '名字'
                },
                {
                    field: 'sex',
                    label: '性别',
                    dictType: 'sex'
                },
                {
                    field: 'headPortrait',
                    label: '头像',
                    type: 'image'
                },
                {
                    field: 'remarks',
                    label: '备注'
                },{
                    label: '操作',
                    type: 'btns',
                    width: 140,
                    fixed: 'right',
                    btns: [
                        {
                            permission: 'data:test:save',
                            label: '修改',
                            type: 'primary',
                            link: true,
                            icon: 'ElEdit',
                            click: (row) => {
                                magicFormTitle.value = '修改'
                                formDialog.value.show(() => magicForm.value.getDetail(row.id))
                            }
                        }, {
                            permission: 'data:test:delete',
                            label: '删除',
                            type: 'primary',
                            link: true,
                            icon: 'ElDelete',
                            click: (row) => {
                                proxy.$common.handleDelete({
                                    url: '/data/test/delete',
                                    id: row.id,
                                    done: () => magicList.value.reload()
                                })
                            }
                        }
                    ]
                }
            ]
        }
    })

    const formOptions = reactive({
        detail: {
            request: {
              url: '/data/test/get'
            }
        },
        form: {
            request: {
                url: "/data/test/save"
            },
            rows: [{
                gutter: 24,
                cols: [{
                    span: 12,
                    name: 'name',
                    label: '名字',
                    component: 'input',
                    rules: [{ required: true, message: '请输入名字', trigger: 'change' }]
                },{
                    span: 12,
                    name: 'sex',
                    label: '性别',
                    component: 'radio-group',
                    props: {
                        type: 'sex'
                    }
                },{
                    span: 12,
                    name: 'headPortrait',
                    label: '头像',
                    component: 'upload-image',
                    rules: [{ required: true, message: '请选择头像', trigger: 'change' }]
                },{
                    span: 12,
                    name: 'remarks',
                    label: '备注',
                    component: 'input',
                    props: {
                        type: 'textarea'
                    }

                }]
            }]
        }
    })
</script>
