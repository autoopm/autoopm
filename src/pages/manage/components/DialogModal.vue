<template>
    <Modal
        :value="visible"
        :mask="false"
        :mask-closable="false"
        :footer-hide="true"
        :transition-names="['mobile-dialog', '']"
        :beforeClose="onBeforeClose"
        class-name="dialog-modal"
        fullscreen>
        <DialogWrapper v-if="windowPortrait && dialogId !== ''" :dialogId="dialogId" :beforeBack="onBeforeClose"/>
    </Modal>
</template>

<style lang="scss">
body {
    .ivu-modal-wrap {
        &.dialog-modal {
            position: absolute;
            overflow: hidden;

            .ivu-modal {
                margin: 0;
                padding: 0;

                .ivu-modal-content {
                    background: transparent;

                    .ivu-modal-close {
                        display: none;
                    }

                    .ivu-modal-body {
                        padding: 0;
                        display: flex;
                        flex-direction: column;
                        overflow: hidden;
                    }
                }
            }
        }
    }
}
</style>

<script>
import {mapState} from "vuex";
import DialogWrapper from "./DialogWrapper";

export default {
    name: "DialogModal",
    components: {DialogWrapper},

    data() {
        return {
            timer: null,
        }
    },

    computed: {
        ...mapState(['dialogId']),

        visible() {
            // console.log('111112进到这里2..visible..........................'+this.dialogId)
            return this.dialogId !== '' && this.windowPortrait
        }
    },

    methods: {
        onBeforeClose() {
            return new Promise(_ => {
                this.$store.dispatch("openDialog", 0)
            })
        },
    }
}
</script>
