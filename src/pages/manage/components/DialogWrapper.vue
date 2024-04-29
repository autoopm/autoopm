<template>
  <div
      v-if="isReady"
      class="dialog-wrapper"
      :class="wrapperClass"
      @drop.prevent="chatPasteDrag($event, 'drag')"
      @dragover.prevent="chatDragOver(true, $event)"
      @dragleave.prevent="chatDragOver(false, $event)"
      @touchstart="onTouchStart"
      @touchmove="onTouchMove"
      @touchend="onTouchEnd"
  >
    <!--顶部导航-->
    <div ref="nav" class="dialog-nav">
      <slot name="head">
        <div class="nav-wrapper" :class="navClass">
          <div class="dialog-back" @click="onBack">
            <i class="taskfont">&#xe676;</i>
            <div v-if="msgUnreadOnly" class="back-num">{{ msgUnreadOnly }}</div>
          </div>

          <div class="dialog-block">
            <div class="dialog-avatar" @click="onViewAvatar">
              <template v-if="dialogData.type == 'group'">
                <EAvatar
                    v-if="dialogData.avatar"
                    class="img-avatar"
                    :src="dialogData.avatar"
                    :size="42"
                ></EAvatar>

                <i v-else-if="dialogData.group_type == 'department'" class="taskfont icon-avatar department"
                >&#xe75c;</i>
                <i v-else-if="dialogData.group_type == 'project'"  class="taskfont icon-avatar project"
                >&#xe6f9;</i>
                <i v-else-if="dialogData.group_type == 'task'" class="taskfont icon-avatar task"
                >&#xe6f4;</i>
                <i v-else-if="dialogData.group_type == 'okr'" class="taskfont icon-avatar task"
                >&#xe6f4;</i>
                <Icon v-else class="icon-avatar" type="ios-people" />
              </template>
              <!--会员-->
              <div v-else-if="dialogData.dialog_user" class="user-avatar">
                <UserAvatarTip
                    :online.sync="dialogData.online_state"
                    :userid="dialogData.dialog_user.userid"
                    :size="42"
                >
                  <p v-if="dialogData.type === 'user' && dialogData.online_state !== true" slot="end">
                    {{ $L(dialogData.online_state) }}
                  </p>
                </UserAvatarTip>
              </div>
              <Icon v-else class="icon-avatar" type="md-person" />
            </div>
            <div class="dialog-title">
              <div class="main-title">
                <template
                    v-for="tag in $A.dialogTags(dialogData)"
                    v-if="tag.color != 'success'"
                >
                  <Tag :color="tag.color" :fade="false">{{ $L(tag.text) }}</Tag>
                </template>
                <h2>{{ dialogData.name }}</h2>
                <em v-if="peopleNum > 0" @click="onDialogMenu('groupInfo')"
                >({{ peopleNum }})</em>
                <Tag v-if="dialogData.bot" class="after" :fade="false">{{ $L("机器人")}}</Tag>
                <Tag v-if="dialogData.type === 'user' && approvaUserStatus"  class="after" color="red" :fade="false"
                >{{ $L(approvaUserStatus) }}</Tag>
                <Tag
                    v-if="dialogData.group_type == 'all'"
                    class="after pointer"
                    :fade="false"
                    @on-click="onDialogMenu('groupInfo')"
                >{{ $L("全员") }}</Tag
                >
                <Tag
                    v-else-if="dialogData.group_type == 'department'"
                    class="after pointer"
                    :fade="false"
                    @on-click="onDialogMenu('groupInfo')"
                >{{ $L("部门") }}</Tag
                >
                <div v-if="msgLoadIng > 0" class="load"><Loading /></div>
              </div>
              <ul class="title-desc">
                <li v-if="dialogData.type === 'user'" :class="[dialogData.online_state === true ? 'online' : 'offline',
                  ]">
                  {{$L( dialogData.online_state === true ? "在线": dialogData.online_state)}}
                </li>
              </ul>
            </div>
          </div>
        </div>
      </slot>
    </div>

    <!--消息部分-->
    <div ref="msgs" class="">
      <!--新的代码块-->
      <div class="message-box">
        <div class="message-list" @scroll="handleScroll" ref="chatRef">
          <div v-for="m in messages">
            <div class="message right" v-if="m.send" :id="m.clientMsgNo">
              <div class="status" v-if="m.status != 1">发送中</div>
              <div class="bubble right">
                <div class="text">{{ getMessageText(m) }}</div>
              </div>

              <div class="avatar">
                <div class="user-avatar">

                  <!--TODO 用户在线状态-->
                  <UserAvatarTip
                      :userid= m.fromUID
                      :size="42"
                  >
<!--                    <p v-if="dialogData.type === 'user' && dialogData.online_state !== true" slot="end">-->
<!--                      {{ $L(dialogData.online_state) }}-->
<!--                    </p>-->
                  </UserAvatarTip>
                </div>


<!--                <img-->
<!--                    :src="`https://api.multiavatar.com/${m.fromUID}.png`"-->
<!--                    style="width: 40px; height: 40px"-->
<!--                />-->
              </div>
            </div>
            <div class="message" v-if="!m.send" :id="m.clientMsgNo">
              <div class="avatar">
                <div class="user-avatar">

                  <!--TODO 用户在线状态-->
                  <UserAvatarTip
                      :userid= m.fromUID
                      :size="42"
                  >
                    <!--                    <p v-if="dialogData.type === 'user' && dialogData.online_state !== true" slot="end">-->
                    <!--                      {{ $L(dialogData.online_state) }}-->
                    <!--                    </p>-->
                  </UserAvatarTip>
                </div>
              </div>
              <div class="bubble">
                <div class="text">{{ getMessageText(m) }}</div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!--新的代码块结束-->
    </div>

    <!--底部输入-->
    <div ref="footer" class="dialog-footer" @click="onActive">
      <div class="chat-input-wrapper">
        <input
            v-model="text"
            class="chat-input-box2"
            @keydown.enter="onEnter"
            placeholder="请输入消息..."
        />
        <button v-on:click="onSend" class="chat—send—btn">发送</button>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapState } from "vuex";
import DialogItem from "./DialogItem";
import DialogUpload from "./DialogUpload";
import DrawerOverlay from "../../../components/DrawerOverlay";
import DialogGroupInfo from "./DialogGroupInfo";
import DialogRespond from "./DialogRespond";
import ChatInput from "./ChatInput";

import VirtualList from "vue-virtual-scroll-list-hi";
import { Store } from "le5le-store";
import ImgUpload from "../../../components/ImgUpload.vue";
import { choiceEmojiOne } from "./ChatInput/one";

import ApproveDetails from "../../../pages/manage/approve/details.vue";
import UserSelect from "../../../components/UserSelect.vue";
import UserAvatarTip from "../../../components/UserAvatar/tip.vue";
import DialogGroupWordChain from "./DialogGroupWordChain";
import DialogGroupVote from "./DialogGroupVote";

import {
  WKSDK,
  Message,
  StreamItem,
  MessageText,
  Channel,
  ChannelTypePerson,
  ChannelTypeGroup,
  MessageStatus,
  SyncOptions,
  PullMode,
  MessageContent,
  MessageContentType,
  Setting
} from "wukongimjssdk";
import { Buffer } from "buffer";

export default {
  name: "DialogWrapper",
  components: {
    UserAvatarTip,
    UserSelect,
    ImgUpload,
    DialogRespond,
    DialogItem,
    VirtualList,
    // ChatInput,
    DialogGroupInfo,
    DrawerOverlay,
    DialogUpload,
    ApproveDetails,
    DialogGroupWordChain,
    DialogGroupVote,
  },

  props: {
    dialogId: {
      type: String,
      default: "",
    },
    msgId: {
      type: Number,
      default: 0,
    },
    autoFocus: {
      type: Boolean,
      default: false,
    },
    isMessenger: {
      type: Boolean,
      default: false,
    },
    beforeBack: Function,
  },

  data() {
    return {
      messages: [],
      text:"",
      keeps: 25,
      msgItem: DialogItem,
      msgText: "",
      msgNew: 0,
      msgType: "",
      loadIng: 0,
      focusLazy: false,
      focusTimer: null,

      allMsgs: [],
      tempMsgs: [],
      tempId: $A.randNum(1000000000, 9999999999),
      msgLoadIng: 0,
      msgActiveIndex: -1,

      pasteShow: false,
      pasteFile: [],
      pasteItem: [],

      searchShow: false,
      searchKey: "",
      searchLoad: 0,
      searchLocation: 1,
      searchResult: [],

      createGroupShow: false,
      createGroupData: {},
      createGroupLoad: 0,

      modifyShow: false,
      modifyData: {},
      modifyLoad: 0,

      forwardhow: false,
      forwardData: [],
      forwardLoad: 0,
      forwardMessage: "",
      forwardSource: true,

      openId: 0,
      dialogDrag: false,
      groupInfoShow: false,

      groupTransferShow: false,
      groupTransferLoad: 0,
      groupTransferData: {
        userid: [],
        disabledChoice: [],
      },

      operateClient: { x: 0, y: 0 },
      operateVisible: false,
      operatePreventScroll: 0,
      operateCopys: [],
      operateStyles: {},
      operateItem: {},

      recordState: "",
      wrapperStart: null,

      scrollOffset: 0,
      scrollTail: 0,

      preventMoreLoad: false,
      preventToBottom: false,

      replyListShow: false,
      replyListId: 0,

      respondShow: false,
      respondData: {},

      todoSettingShow: false,
      todoSettingLoad: 0,
      todoSettingData: {
        type: "all",
        userids: [],
        quick_value: [],
      },

      todoViewLoad: false,
      todoViewPosLoad: false,
      todoViewShow: false,
      todoViewData: {},
      todoViewMid: 0,
      todoViewId: 0,

      scrollDisabled: false,
      scrollDirection: null,
      scrollAction: 0,
      scrollTmp: 0,
      scrollIng: 0,

      approveDetails: { id: 0 },
      approveDetailsShow: false,
      approvaUserStatus: "",

      observers: [],

      unreadOne: 0, // 最早未读消息id
      topPosLoad: false, // 置顶跳转加载中
      positionLoad: 0, // 定位跳转加载中
      positionShow: false, // 定位跳转显示
      renderMsgNum: 0, // 渲染消息数量
      renderMsgSizes: new Map(), // 渲染消息尺寸
      msgActivityStatus: false, // 消息准备完成
      listPreparedStatus: false, // 列表准备完成
      selectedTextStatus: false, // 是否选择文本
      scrollToBottomAndRefresh: false, // 滚动到底部重新获取消息
      androidKeyboardVisible: false, // Android键盘是否可见
    };
  },

  mounted() {
    //获取地址并连接im
    //初始化数据源
    this.initDataSource();
    this.connectIM();
    //新的代码块
    //进来执行拉取数据
    this.pullLast();

    // this.initDataSource();
    // this.initIM(); //初始化聊天
    //同步最近的会话
    // console.log("mounted------------------------------")
    // this.msgSubscribe = Store.subscribe('dialogMsgChange', this.onMsgChange);
    // document.addEventListener('selectionchange', this.onSelectionchange);
  },

  beforeDestroy() {
    WKSDK.shared().chatManager.removeMessageListener(this.messageListener);
    WKSDK.shared().chatManager.removeMessageStatusListener(
        this.messageStatusListener
    );
  },

  computed: {
    ...mapState([
      "systemConfig",
      "userIsAdmin",
      "taskId",
      "dialogSearchMsgId",
      "dialogMsgs",
      "dialogTodos",
      "dialogMsgTops",
      "dialogMsgTransfer",
      "cacheDialogs",
      "wsOpenNum",
      "touchBackInProgress",
      "dialogIns",
      "cacheUserBasic",
      "fileLinks",
      "cacheEmojis",

      "readLoadNum",
      "readTimeout",
      "keyboardType",
      "keyboardHeight",
      "safeAreaBottom",
    ]),

    ...mapGetters(["isLoad"]),

    isReady() {
      return this.dialogId !== "";
      // return this.dialogId > 0 && this.dialogData.id > 0  //TODO 这里是关键,不等于空和
    },

    dialogData() {
      const data = this.cacheDialogs.find(({ id }) => id == this.dialogId) || {};
      //TODO 这里猜测是未读
      if (this.unreadOne === 0) {
        this.unreadOne = data.unread_one || 0;
      }
      return data;
    },

    dialogList() {
      console.log("mounted------------------------------dialogList");
      return this.cacheDialogs
          .filter((dialog) => {
            return !(dialog.name === undefined || dialog.dialog_delete === 1);
          })
          .sort((a, b) => {
            if (a.top_at || b.top_at) {
              return $A.Date(b.top_at) - $A.Date(a.top_at);
            }
            if (a.todo_num > 0 || b.todo_num > 0) {
              return b.todo_num - a.todo_num;
            }
            return $A.Date(b.last_at) - $A.Date(a.last_at);
          });
    },

    dialogMsgList() {
      if (!this.isReady) {
        return [];
      }
      return this.dialogMsgs.filter((item) => item.dialog_id == this.dialogId);
    },

    tempMsgList() {
      if (!this.isReady) {
        return [];
      }
      return this.tempMsgs.filter((item) => item.dialog_id == this.dialogId);
    },

    loadMsg() {
      console.log("mounted------------------------------loadMsg ");
      return this.isLoad(`msg::${this.dialogId}-${this.msgId}-${this.msgType}`);
    },

    prevId() {
      if (this.allMsgs.length > 0) {
        return $A.runNum(this.allMsgs[0].prev_id);
      }
      return 0;
    },

    peopleNum() {
      return this.dialogData.type === "group"
          ? $A.runNum(this.dialogData.people)
          : 0;
    },

    pasteTitle() {
      const { pasteItem } = this;
      let hasImage = pasteItem.find(({ type }) => type == "image");
      let hasFile = pasteItem.find(({ type }) => type != "image");
      if (hasImage && hasFile) {
        return "发送文件/图片";
      } else if (hasImage) {
        return "发送图片";
      }
      return "发送文件";
    },

    msgTags({ dialogData }) {
      const array = [{ type: "", label: "消息" }];
      if (dialogData.has_tag) {
        array.push({ type: "tag", label: "标注" });
      }
      if (dialogData.has_todo) {
        array.push({ type: "todo", label: "事项" });
      }
      if (dialogData.has_image) {
        array.push({ type: "image", label: "图片" });
      }
      if (dialogData.has_file) {
        array.push({ type: "file", label: "文件" });
      }
      if (dialogData.has_link) {
        array.push({ type: "link", label: "链接" });
      }
      if (dialogData.group_type === "project") {
        array.push({ type: "project", label: "打开项目" });
      }
      if (dialogData.group_type === "task") {
        array.push({ type: "task", label: "打开任务" });
      }
      if (dialogData.group_type === "okr") {
        array.push({ type: "okr", label: "打开OKR" });
      }
      return array;
    },

    topMsg() {
      return (
          this.dialogData.top_msg_id &&
          this.dialogMsgTops.find(({ id }) => id == this.dialogData.top_msg_id)
      );
    },

    quickMsgs() {
      return this.dialogData.quick_msgs || [];
    },

    todoList() {
      if (!this.dialogData.todo_num) {
        return [];
      }
      return this.dialogTodos
          .filter((item) => !item.done_at && item.dialog_id == this.dialogId)
          .sort((a, b) => {
            return b.id - a.id;
          });
    },

    isDefaultSize() {
      return this.windowScrollY === 0 && !this.androidKeyboardVisible;
    },

    quickShow() {
      return (
          this.quickMsgs.length > 0 && this.isDefaultSize && this.quoteId === 0
      );
    },

    todoShow() {
      return (
          this.todoList.length > 0 && this.isDefaultSize && this.quoteId === 0
      );
    },

    tagShow() {
      return this.msgTags.length > 1 && this.isDefaultSize && !this.searchShow;
    },

    topShow() {
      return (
          this.topMsg &&
          this.isDefaultSize &&
          !this.searchShow &&
          this.msgType === ""
      );
    },

    wrapperClass() {
      if (["ready", "ing"].includes(this.recordState)) {
        return "record-ready";
      }
      return null;
    },

    navClass() {
      return {
        completed: $A.dialogCompleted(this.dialogData),
        tagged: this.tagShow,
      };
    },

    pasteClass() {
      if (this.pasteItem.find(({ type }) => type !== "image")) {
        return ["multiple"];
      }
      return [];
    },

    footerPaddingBottom({keyboardType,
                          keyboardHeight,
                          safeAreaBottom,
                          windowScrollY,
                          isMessenger,
                          focusLazy,
                        }) {
      if (
          windowScrollY === 0 &&
          focusLazy &&
          isMessenger &&
          keyboardType === "show" &&
          keyboardHeight > 0 &&
          keyboardHeight < 120
      ) {
        return keyboardHeight + safeAreaBottom;
      }
      return 0;
    },

    msgUnreadOnly() {
      let num = 0;
      this.cacheDialogs.some((dialog) => {
        num += $A.getDialogNum(dialog);
      });
      if (num <= 0) {
        return "";
      }
      if (num > 999) {
        num = "999+";
      }
      return String(num);
    },

    isMyDialog() {
      const { dialogData, userId } = this;
      return dialogData.dialog_user && dialogData.dialog_user.userid == userId;
    },

    isManageBot() {
      const { dialogData, userId, userIsAdmin } = this;
      if (!dialogData.bot) {
        return false;
      }
      if (dialogData.bot == userId) {
        return true;
      }
      return (
          dialogData.dialog_user &&
          dialogData.dialog_user.userid == dialogData.bot &&
          userIsAdmin
      );
    },

    isMute() {
      if (this.dialogData.group_type === "all") {
        if (this.dialogData.all_group_mute === "all") {
          return true;
        } else if (this.dialogData.all_group_mute === "user") {
          if (!this.userIsAdmin) {
            return true;
          }
        }
      }
      return false;
    },

    quoteId() {
      if (this.msgId > 0) {
        return this.msgId;
      }
      return this.dialogData.extra_quote_id || 0;
    },

    quoteUpdate() {
      return this.dialogData.extra_quote_type === "update";
    },

    quoteData() {
      return this.quoteId
          ? this.allMsgs.find(({ id }) => id === this.quoteId)
          : null;
    },

    todoViewMsg() {
      if (this.todoViewMid) {
        const msg = this.allMsgs.find((item) => item.id == this.todoViewMid);
        if (msg) {
          return msg;
        }
        if (this.todoViewData.id === this.todoViewMid) {
          return this.todoViewData;
        }
      }
      return null;
    },

    positionMsg({ msgNew, dialogData, allMsgs }) {
      const { unread, unread_one, mention, mention_ids } = dialogData;
      const not = unread - msgNew;
      const array = [];
      if (unread_one) {
        array.push({
          type: "unread",
          label: this.$L(`未读消息${not}条`),
          msg_id: unread_one,
        });
      }
      if (mention_ids && mention_ids.length > 0) {
        array.push(
            ...mention_ids.map((msg_id) => {
              return {
                type: "mention",
                label: this.$L(`@我的消息`),
                msg_id,
              };
            })
        );
      }
      if (not <= 0 || array.length === 0 || allMsgs.length === 0) {
        return null;
      }
      return (
          array.find(
              (item) => item.type === (mention === 0 ? "unread" : "mention")
          ) || array[0]
      );
    },

    operateEmojis({ cacheEmojis }) {
      const list = cacheEmojis.slice(0, 3);
      Object.values([
        "👌",
        "👍",
        "😂",
        "🎉",
        "❤️",
        "🥳️",
        "🥰",
        "😥",
        "😭",
      ]).some((item) => {
        if (!list.includes(item)) {
          list.push(item);
        }
      });
      return list;
    },

    maxSize({ systemConfig }) {
      if (systemConfig?.file_upload_limit) {
        return systemConfig.file_upload_limit * 1024;
      }
      return 1024000;
    },

    readEnabled({ msgActivityStatus, listPreparedStatus }) {
      return msgActivityStatus === 0 && listPreparedStatus;
    },
  },

  watch: {
    $route: {
      handler(data) {
        const { name, params } = data || {};
        if (name != "manage-messenger") {
          return;
        }
        if (
            params.dialog_id &&
            params.open &&
            ["word-chain", "vote"].includes(params.open)
        ) {
          this.$nextTick((_) => {
            this.$store.state[
                params.open == "word-chain"
                    ? "dialogDroupWordChain"
                    : "dialogGroupVote"
                ] = {
              type: "create",
              dialog_id: params.dialog_id,
            };
            params.open = "";
          });
        }
      },
      immediate: true,
    },
    dialogId: {
      handler(dialog_id, old_id) {
        if (dialog_id) {
          this.msgNew = 0;
          this.msgType = "";
          this.unreadOne = 0;
          this.searchShow = false;
          this.positionShow = false;
          this.listPreparedStatus = false;
          this.scrollToBottomAndRefresh = false;
          // this.renderMsgNum = Math.min(
          //     this.keeps,
          //     Math.max(this.allMsgList.length, 1)
          // );
          this.renderMsgSizes.clear();
          this.allMsgs = this.allMsgList;
          console.log("请求到这里1.......")

          //TODO 这里更新信息列表
          this.messages = []
          this.pullLast();


          // this.getMsgs({
          //   dialog_id,
          //   msg_id: this.msgId,
          //   msg_type: this.msgType,
          //   save_before: (_) => this.onMarkOffset(false),
          // })
          //     .then((data) => {
          //       console.log(
          //           "mounted-------------------------------dialogId handle then22 ",
          //           data
          //       );
          //       this.openId = dialog_id;
          //       this.listPreparedStatus = true;
          //       console.log(
          //           "mounted-------------------------------dialogId handle then22 ",
          //           data
          //       );
          //       this.allMsgs = data; //TODO 这里赋值
          //       //
          //       // const tmpMsgB = this.allMsgList.map(({id, msg, emoji}) => {
          //       //     return {id, msg, emoji}
          //       // })
          //       if (JSON.stringify(tmpMsgA) != JSON.stringify(tmpMsgB)) {
          //         // this.renderMsgNum = Math.min(
          //         //     this.keeps,
          //         //     Math.max(this.allMsgList.length, 1)
          //         // );
          //       }
          //       //
          //       setTimeout((_) => {
          //         this.onSearchMsgId();
          //         this.positionShow = this.readTimeout === null;
          //       }, 100);
          //     })
          //     .catch((_) => {
          //       console.log("请求数据异常！！！");
          //     });
          //
          this.$store.dispatch("saveInDialog", {
            uid: this._uid,
            dialog_id,
          });
          //
          if (this.autoFocus) {
            this.inputFocus();
          }
        }
        this.$store.dispatch("closeDialog", old_id);
        this.getUserApproveStatus();
      },
      immediate: true,
    },

    loadMsg: {
      handler(load) {
        if (load) {
          this.loadIng++;
        } else {
          setTimeout((_) => {
            this.loadIng--;
          }, 300);
        }
      },
      immediate: true,
    },

    isReady: {
      handler(ready) {
        console.log("mounted------------------------------isReady ");
        if (!ready) {
          return;
        }
        this.$nextTick((_) => {
          if (this.$refs.msgs) {
            if (!this.observers.find(({ key }) => key === "scroller")) {
              const scrollerObserver = new ResizeObserver(this.onResizeEvent);
              scrollerObserver.observe(this.$refs.msgs);
              this.observers.push({
                key: "scroller",
                observer: scrollerObserver,
              });
            }
          }
          if (this.$refs.footer) {
            if (!this.observers.find(({ key }) => key === "footer")) {
              const footerObserver = new ResizeObserver(this.onResizeEvent);
              footerObserver.observe(this.$refs.footer);
              this.observers.push({ key: "footer", observer: footerObserver });
            }
          }
        });
      },
      immediate: true,
    },

    msgType() {
      console.log("请求到这里2.......")
      this.getMsgs({
        dialog_id: this.dialogId,
        msg_id: this.msgId,
        msg_type: this.msgType,
        clear_before: true,
      }).catch((_) => {});
    },

    searchKey(key) {
      if (!key) {
        return;
      }
      this.searchLoad++;
      setTimeout((_) => {
        if (this.searchKey === key) {
          this.searchLoad++;
          this.searchResult = [];
          this.searchLocation = 0;
          this.$store
              .dispatch("call", {
                url: "dialog/msg/search",
                data: {
                  dialog_id: this.dialogId,
                  key,
                },
              })
              .then(({ data }) => {
                if (this.searchKey !== key) {
                  return;
                }
                this.searchResult = data.data;
                this.searchLocation = this.searchResult.length;
              })
              .finally((_) => {
                this.searchLoad--;
              });
        }
        this.searchLoad--;
      }, 600);
    },

    searchLocation(position) {
      if (position === 0) {
        return;
      }
      const id = this.searchResult[position - 1];
      if (id) {
        this.onPositionId(id);
      }
    },

    dialogSearchMsgId() {
      this.onSearchMsgId();
    },

    dialogMsgTransfer: {
      handler({ time, msgFile, msgRecord, msgText, dialogId }) {
        if (time > $A.Time() && dialogId == this.dialogId) {
          this.$store.state.dialogMsgTransfer.time = 0;
          this.$nextTick(() => {
            if ($A.isArray(msgFile) && msgFile.length > 0) {
              this.sendFileMsg(msgFile);
            } else if ($A.isJson(msgRecord) && msgRecord.duration > 0) {
              this.sendRecord(msgRecord);
            } else if (msgText) {
              console.log("sendMsg--------------1");
              this.sendMsg(msgText);
            }
          });
        }
      },
      immediate: true,
    },

    allMsgList(newList, oldList) {
      if (JSON.stringify(newList) == JSON.stringify(oldList)) {
        return;
      }
      const { tail } = this.scrollInfo();
      if ($A.isIos() && newList.length !== oldList.length) {
        // 隐藏区域，让iOS断触
        const scrollEl = this.$refs.scroller.$el;
        scrollEl.style.visibility = "hidden";
        this.allMsgs = newList;
        this.$nextTick((_) => {
          scrollEl.style.visibility = "visible";
        });
      } else {
        this.allMsgs = newList;
      }
      //
      if (!this.windowActive || (tail > 55 && oldList.length > 0)) {
        const lastId = oldList[oldList.length - 1]
            ? oldList[oldList.length - 1].id
            : 0;
        const tmpList = newList.filter(
            (item) => item.id && item.id > lastId && !item.read_at
        );
        this.msgNew += tmpList.length;
      } else {
        !this.preventToBottom && this.$nextTick(this.onToBottom);
      }
    },

    dialogDrag(val) {
      if (val) {
        this.operateVisible = false;
      }
    },

    msgActiveIndex(index) {
      if (index > -1) {
        setTimeout((_) => (this.msgActiveIndex = -1), 800);
      }
    },

    footerPaddingBottom(val) {
      this.$refs.footer.style.paddingBottom = `${val}px`;
      requestAnimationFrame((_) => {
        this.$refs.input.updateTools();
        this.onFooterResize();
      });
    },

    readLoadNum() {
      this.positionShow = true;
    },
  },

  methods: {
    //连接im
    connectIM() {
      //TODO 判断连接状态
      WKSDK.shared().chatManager.addMessageListener(this.messageListener);
      //添加消息发送状态监听
      WKSDK.shared().chatManager.addMessageStatusListener(this.messageStatusListener);
    },
    //数据监听
    messageListener(msg) {
      const channelId = this.dialogId;
      const channelTypeGroup = ChannelTypeGroup;
      const channel = new Channel(channelId, channelTypeGroup);
      //判断频道是否对
      if (!channel.isEqual(msg.channel)) {
        return;
      }
      if (msg.streamOn) {
        let exist = false;
        for (let i = 0; i < this.messages.length; i++) {
          if (this.messages[i].streamNo === msg.streamNo) {
            exist = true;
            if (!this.messages[i].streams) {
              this.$set(this.messages[i], "streams", []);
            }
            const newStream = {
              clientMsgNo: msg.clientMsgNo,
              streamSeq: msg.streamSeq || 0,
              content: msg.content,
            };
            console.log("this.messagesstreams.push ")
            this.messages[i].streams.push(newStream);
            break;
          }
        }
        if (!exist) {
          this.messages.push(msg);
        }
      }else {
        this.messages.push(msg);
      }
      this.scrollBottom();
    },

    /**
     * 消息发送监听
     * @param packet
     */
    messageStatusListener(packet) {
      console.log("消息packet->", packet); // 消息客户端序号用来匹配对应的发送的消息
      if (packet.reasonCode === 1) {
        console.log("消息发送成功");   // 发送成功
      } else {
        console.log("消息发送失败");  // 发送失败
      }
      this.messages.forEach((m) => {
        if (m.clientSeq === packet.clientSeq) {
          this.$set(m,"status",packet.reasonCode === 1 ? MessageStatus.Normal : MessageStatus.Fail
          );
        }
      });
    },


    /**
     * 移动到底部
     */
    scrollBottom() {
      const chat = this.$refs.chatRef;
      if (chat) {
        console.log("scrollBottom chat");
        this.$nextTick(function () {
          console.log("scrollBottom--$nextTick scrollTop");
          chat.scrollTop = chat.scrollHeight;
        });
      }
    },

    //拉取当前会话最新消息
    async pullLast() {

      // console.log("新的代码块........pullLast");
      // 设置pulldowning为true，pulldownFinished为false
      this.pulldowning = true;
      this.pulldownFinished = false;
      // 调用API获取消息信息

      const channelId = this.dialogId;
      const channelTypeGroup = ChannelTypeGroup;
      const channel = new Channel(channelId, channelTypeGroup);

      WKSDK.shared().chatManager.syncMessages(channel, {limit: 15,
        startMessageSeq: 0,endMessageSeq: 0,pullMode: PullMode.Up,})
          .then((msgs) => {
            // console.log("新的代码块225........pullLast then msgs", msgs);
            // 将消息添加到messages数组中
            if (msgs && msgs.length > 0) {
              for (let m of msgs) {
                this.messages.push(m);
                // console.log("messages-->"+m)
                // console.log(m)
                // console.log("messages-->"+m)
              }
            }

            this.pulldowning = false;   // 将pulldowning设置为false
            // 滚动到底部
            this.$nextTick(() => {
              this.scrollBottom();
            });
          });
    },

    async pullDown() {
      if (this.messages.length == 0) {
        return;
      }
      const firstMsg = this.messages[0];
      if (firstMsg.messageSeq == 1) {
        this.pulldownFinished = true;
        return;
      }

      const limit = 15;
      const channelId = this.dialogId;
      const channelTypeGroup = ChannelTypeGroup;
      const channel = new Channel(channelId, channelTypeGroup);

      const msgs = await WKSDK.shared().chatManager.syncMessages(channel, {
        limit: limit,
        startMessageSeq: firstMsg.messageSeq - 1,
        endMessageSeq: 0,
        pullMode: PullMode.Down,
      });

      if (msgs.length < limit) {
        this.pulldownFinished = true;
      }

      if (msgs && msgs.length > 0) {
        msgs.reverse().forEach((m) => {
          this.messages.unshift(m);
        });
      }

      this.$nextTick(() => {
        const chat = this.$refs.chat;
        const firstMsgEl = document.getElementById(firstMsg.clientMsgNo);
        if (firstMsgEl) {
          chat.scrollTop = firstMsgEl.offsetTop;
        }
      });
    },

    //发送消息
    onSend() {
      const channelId = this.dialogId;
      const channelTypeGroup = ChannelTypeGroup;
      const channel = new Channel(channelId, channelTypeGroup);

      if (!this.text || this.text.trim() === "") {
        this.msgCount++;
        this.text = `${this.msgCount}`;
      }
      const setting = Setting.fromUint8(0);
      if (channel && channel.channelID != "") {
        let content;
        if (this.streamNo && this.streamNo !== "") {
          setting.streamNo = this.streamNo;
        }
        content = new MessageText(this.text);
        WKSDK.shared().chatManager.send(content, channel, setting);
        this.text = "";
      } else {
        // this.showSettingPanel = true;
      }
      this.scrollBottom();
    },
    //获取消息
    getMessageText(m) {
      if (m instanceof Message) {
        const streams = m.streams;
        let text = "";
        if (m.content instanceof MessageText) {
          const messageText = m.content;
          text = messageText.text || "";
        }

        if (streams && streams.length > 0) {
          streams.forEach((stream) => {
            if (stream.content instanceof MessageText) {
              const messageText = stream.content;
              text = text + (messageText.text || "");
            }
          });
        }
        return text;
      }
      return "未知消息";
    },

    handleScroll(e) {
      e.stopPropagation(); //阻止冒泡
      const targetScrollTop = e.target.scrollTop;
      const scrollOffsetTop = e.target.scrollHeight - (targetScrollTop + e.target.clientHeight);

      if (targetScrollTop <= 250) {
        // 下拉
        if (this.pulldowning || this.pulldownFinished) {
          console.log(
              "不允许下拉",
              "pulldowning",
              this.pulldowning,
              "pulldownFinished",
              this.pulldownFinished
          );
          return;
        }
        console.log("下拉");
        this.pulldowning = true;
        this.pullDown()
            .then(() => {
              this.pulldowning = false;
            })
            .catch(() => {
              this.pulldowning = false;
            });
      }
    },

    //回车键
    onEnter() {
      this.onSend();
    },

    //数据转换
    toMessage(msgMap) {
      const message = new Message();
      if (msgMap["message_idstr"]) {
        message.messageID = msgMap["message_idstr"];
      } else {
        message.messageID = new BigNumber(msgMap["message_id"]).toString();
      }
      if (msgMap["header"]) {
        message.header.reddot =
            msgMap["header"]["red_dot"] === 1 ? true : false;
      }
      if (msgMap["setting"]) {
        message.setting = Setting.fromUint8(msgMap["setting"]);
      }
      if (msgMap["revoke"]) {
        message.remoteExtra.revoke = msgMap["revoke"] === 1 ? true : false;
      }
      if (msgMap["message_extra"]) {
        const messageExtra = msgMap["message_extra"];
        message.remoteExtra = this.toMessageExtra(messageExtra);
      }
      message.clientSeq = msgMap["client_seq"];
      message.channel = new Channel(
          msgMap["channel_id"],
          msgMap["channel_type"]
      );
      message.messageSeq = msgMap["message_seq"];
      message.clientMsgNo = msgMap["client_msg_no"];
      message.streamNo = msgMap["stream_no"];
      message.streamFlag = msgMap["stream_flag"];
      message.fromUID = msgMap["from_uid"];
      message.timestamp = msgMap["timestamp"];
      message.status = MessageStatus.Normal;
      const decodedBuffer = Buffer.from(msgMap["payload"], "base64");
      const contentObj = JSON.parse(decodedBuffer.toString("utf8"));
      let contentType = 0;
      if (contentObj) {
        contentType = contentObj.type;
      }
      const messageContent = WKSDK.shared().getMessageContent(contentType);
      if (contentObj) {
        messageContent.decode(
            this.stringToUint8Array(JSON.stringify(contentObj))
        );
      }
      message.content = messageContent;
      message.isDeleted = msgMap["is_deleted"] === 1;
      const streamMaps = msgMap["streams"];
      if (streamMaps && streamMaps.length > 0) {
        const streams = [];
        for (const streamMap of streamMaps) {
          const streamItem = new StreamItem();
          streamItem.clientMsgNo = streamMap["client_msg_no"];
          streamItem.streamSeq = streamMap["stream_seq"];

          if (streamMap["blob"] && streamMap["blob"].length > 0) {
            const blob = Buffer.from(streamMap["blob"], "base64");
            const blobObj = JSON.parse(blob.toString("utf8"));
            const blobType = blobObj.type;
            const blobContent = WKSDK.shared().getMessageContent(contentType); // 假设 WKSDK 类中有 shared 方法来获取消息内容

            if (blobObj) {
              blobContent.decode(
                  this.stringToUint8Array(JSON.stringify(blobObj))
              );
            }

            streamItem.clientMsgNo = streamMap["client_msg_no"];
            streamItem.streamSeq = streamMap["stream_seq"];
            streamItem.content = blobContent;
          }

          streams.push(streamItem);
        }

        message.streams = streams;
      }
      return message;
    },

    /**
     *
     * @param msgExtraMap
     * @returns {MessageExtra}
     */
    toMessageExtra(msgExtraMap) {
      const messageExtra = new MessageExtra();
      if (msgExtraMap["message_id_str"]) {
        messageExtra.messageID = msgExtraMap["message_id_str"];
      } else {
        messageExtra.messageID = new BigNumber(
            msgExtraMap["message_id"]
        ).toString();
      }
      messageExtra.messageSeq = msgExtraMap["message_seq"];
      messageExtra.readed = msgExtraMap["readed"] === 1;
      if (msgExtraMap["readed_at"] && msgExtraMap["readed_at"] > 0) {
        messageExtra.readedAt = new Date(msgExtraMap["readed_at"]);
      }
      messageExtra.revoke = msgExtraMap["revoke"] === 1;
      if (msgExtraMap["revoker"]) {
        messageExtra.revoker = msgExtraMap["revoker"];
      }
      messageExtra.readedCount = msgExtraMap["readed_count"] || 0;
      messageExtra.unreadCount = msgExtraMap["unread_count"] || 0;
      messageExtra.extraVersion = msgExtraMap["extra_version"] || 0;
      messageExtra.editedAt = msgExtraMap["edited_at"] || 0;
      const contentEditObj = msgExtraMap["content_edit"];
      if (contentEditObj) {
        const contentEditContentType = contentEditObj.type;
        const contentEditContent = WKSDK.shared().getMessageContent(
            contentEditContentType
        );
        const contentEditPayloadData = this.stringToUint8Array(
            JSON.stringify(contentEditObj)
        );
        contentEditContent.decode(contentEditPayloadData);
        messageExtra.contentEditData = contentEditPayloadData;
        messageExtra.contentEdit = contentEditContent;
        messageExtra.isEdit = true;
      }
      return messageExtra;
    },

    /**
     * 数据转换
     * @param str
     */
    stringToUint8Array(str) {
      const newStr = unescape(encodeURIComponent(str));
      const arr = [];
      for (let i = 0; i < newStr.length; i++) {
        arr.push(newStr.charCodeAt(i));
      }
      return new Uint8Array(arr);
    },

    /**
     * base64转string
     * @param base64String
     * @returns {string}
     */
    base64ToUtf8(base64String) {
      // 使用 atob 函数解码base64字符串
      const decodedString = atob(base64String);
      // 将解码后的字符串转换为UTF-8格式
      let utf8String = "";
      for (let i = 0; i < decodedString.length; i++) {
        utf8String += String.fromCharCode(decodedString.charCodeAt(i));
      }
      return utf8String;
    },

    //onUnmounted
    //初始化数据源
    initDataSource() {
      const syncMessagesCallback = async (channel, opts) => {
        const resultMessages = await this.getMessageList(channel, opts);
        return resultMessages;
        //
      };

      WKSDK.shared().config.provider.syncMessagesCallback =
          syncMessagesCallback;

      //同步会话列表 这里先不考虑
      //清除未读，这里也先不考虑
      //群频道 订阅者列表
      const subscribersCallback = async (channel, version) => {
        const subscribers =
            WKSDK.shared().channelManager.getSubscribes(channel);
        console.log(
            "subscribers------subscribersCallback------------------------end----",
            subscribers
        );
        return subscribers;
      };

      WKSDK.shared().config.provider.syncSubscribersCallback =
          subscribersCallback;
    },
    //获取消息
    async getMessageList(channel, opts) {
      var requestData = {
        login_uid: this.userId + "",
        channel_id: this.dialogId,
        channel_type: 2,
        start_message_seq: 0,
        end_message_seq: 0,
        pull_mode: 1,
        limit: 15, //固定每次取15条
      };

      try {
        const {data} = await this.$store.dispatch("call", {
          url: "channel/messagesync",
          method: "post",
          data: requestData,
        });
        var messageList = data.messages;
        if (messageList) {
          const resultMessages = messageList.map((msg) => this.toMessage(msg));
          return resultMessages;
        }
      } catch (error) {
        console.error("新的代码块........catch error", error);
        // 如果有错误也返回一个空数组
        return [];
      } finally {
        // console.log("新的代码块........finally");
        // 此处可以进行一些清理操作
      }
    },
    /**
     * 消息发送监听
     * @param packet
     */
    handleMessage(packet) {
      console.log("handleMessage->",packet); //消息客户端序号用来匹配对应的发送的消息
      if (packet.reasonCode === 1) {
        // 发送成功
        console.log("消息发送成功");
      } else {
        // 发送失败
        console.log("消息发送失败");
        console.log(packet);
      }
    },

    /**
     * 发送录音
     * @param msg {base64, duration}
     */
    sendRecord(msg) {
      console.log("应该不是这里吧3");
      const tempMsg = {
        id: this.getTempId(),
        dialog_id: this.dialogData.id,
        reply_id: this.quoteId,
        reply_data: this.quoteData,
        type: "loading",
        userid: this.userId,
        msg,
      };
      this.tempMsgs.push(tempMsg);
      this.msgType = "";
      this.cancelQuote();
      this.onActive();
      this.$nextTick(this.onToBottom);
      //
      this.$store
          .dispatch("call", {
            url: "dialog/msg/sendrecord",
            data: Object.assign(msg, {
              dialog_id: this.dialogId,
              reply_id: this.quoteId,
            }),
            method: "post",
          })
          .then(({ data }) => {
            this.sendSuccess(data, tempMsg.id);
          })
          .catch((error) => {
            this.$set(tempMsg, "error", true);
            this.$set(tempMsg, "errorData", {
              type: "record",
              mType: "record",
              content: error.msg,
              msg,
            });
          });
    },

    /**
     * 发送快捷消息
     * @param item
     */
    sendQuick(item) {
      console.log("sendMsg--------------sendQuick");
      this.sendMsg(
          `<p><span data-quick-key="${item.key}">${item.label}</span></p>`
      );
    },

    getTempId() {
      return this.tempId++;
    },

    onSearchMsgId() {
      if (this.dialogSearchMsgId > 0 && this.openId === this.dialogId) {
        this.onPositionId(this.dialogSearchMsgId);
        this.$store.state.dialogSearchMsgId = 0;
      }
    },

    onPositionId(position_id, msg_id = 0, loop_num = 0) {
      console.log("mounted------------------------------onPositionId");
      return new Promise((resolve, reject) => {
        if (position_id === 0) {
          $A.modalError("查看失败：参数错误");
          reject();
          return;
        }
        //
        if (this.loadMsg || this.msgType !== "") {
          this.msgType = "";
          if (loop_num === 0) {
            this.$store.dispatch("showSpinner", 600);
          } else if (loop_num > 20) {
            this.$store.dispatch("hiddenSpinner");
            $A.modalError("查看失败：请求超时");
            reject();
            return;
          }
          loop_num++;
          setTimeout((_) => {
            this.onPositionId(position_id, msg_id, loop_num)
                .then(resolve)
                .catch(reject);
          }, Math.min(800, 200 * loop_num));
          return;
        }
        if (loop_num > 0) {
          this.$store.dispatch("hiddenSpinner");
        }
        //
        const index = this.allMsgs.findIndex((item) => item.id === position_id);
        const gtpos = this.prevId > 0 ? 0 : -1; // 如果还有更多消息时定位的消息必须不是第一条是为了避免定位后又有新加载
        if (index > gtpos) {
          setTimeout((_) => {
            this.onToIndex(index);
            resolve();
          }, 200);
        } else {
          if (msg_id > 0) {
            this.$store.dispatch("setLoad", {
              key: `msg-${msg_id}`,
              delay: 600,
            });
          }
          this.preventToBottom = true;
          console.log("请求到这里3.......")
          // this.getMsgs({
          //   dialog_id: this.dialogId,
          //   msg_id: this.msgId,
          //   msg_type: this.msgType,
          //   position_id,
          //   spinner: 2000,
          // }).finally((_) => {
          //   const index = this.allMsgs.findIndex(
          //       (item) => item.id === position_id
          //   );
          //   if (index > -1) {
          //     this.onToIndex(index);
          //     resolve();
          //   }
          //   if (msg_id > 0) {
          //     this.$store.dispatch("cancelLoad", `msg-${msg_id}`);
          //   }
          //   this.preventToBottom = false;
          // });
        }
      });
    },

    onCloseTodo() {
      this.todoViewLoad = false;
      this.todoViewShow = false;
      this.todoViewData = {};
      this.todoViewMid = 0;
      this.todoViewId = 0;
      this.onFooterResize();
    },

    inputFocus() {
      this.$nextTick((_) => {
        this.$refs.input && this.$refs.input.focus();
      });
    },

    chatPasteDrag(e, type) {
      this.dialogDrag = false;
      if (
          $A.dataHasFolder(type === "drag" ? e.dataTransfer : e.clipboardData)
      ) {
        e.preventDefault();
        $A.modalWarning(`暂不支持${type === "drag" ? "拖拽" : "粘贴"}文件夹。`);
        return;
      }
      const files =
          type === "drag" ? e.dataTransfer.files : e.clipboardData.files;
      const postFiles = Array.prototype.slice.call(files);
      if (postFiles.length > 0) {
        e.preventDefault();
        this.sendFileMsg(postFiles);
      }
    },

    chatDragOver(show, e) {
      let random = (this.__dialog_drag = $A.randomString(8));
      if (!show) {
        setTimeout(() => {
          if (random === this.__dialog_drag) {
            this.dialogDrag = show;
          }
        }, 150);
      } else {
        if (e.dataTransfer.effectAllowed === "move") {
          return;
        }
        const postFiles = Array.prototype.slice.call(e.dataTransfer.files);
        if (postFiles.length === 0) {
          return;
        }
        this.dialogDrag = true;
      }
    },

    onTouchStart(e) {
      console.log("onTouchStart1------------");
      this.wrapperStart = null;
      if (this.selectedTextStatus) {
        this.wrapperStart = window.scrollY;
        return;
      }
      if (this.$refs.scroller.$el.contains(e.target)) {
        // 聊天内容区域
        this.wrapperStart = Object.assign(this.scrollInfo(), {
          clientY: e.touches[0].clientY,
        });
      } else if (this.$refs.input.$refs.editor.contains(e.target)) {
        // 输入内容区域
        const editor =
            this.$refs.input.$refs.editor.querySelector(".ql-editor");
        if (editor) {
          const clientSize = editor.clientHeight;
          const offset = editor.scrollTop;
          const scrollSize = editor.scrollHeight;
          this.wrapperStart = {
            offset, // 滚动的距离
            scale: offset / (scrollSize - clientSize), // 已滚动比例
            tail: scrollSize - clientSize - offset, // 与底部距离
            clientY: e.touches[0].clientY,
          };
        }
      }
    },

    onTouchMove(e) {
      if (
          this.footerPaddingBottom > 0 ||
          (this.windowPortrait && this.windowScrollY > 0)
      ) {
        if (typeof this.wrapperStart === "number") {
          return;
        }
        if (this.wrapperStart === null) {
          e.preventDefault();
          return;
        }
        if (this.wrapperStart.clientY > e.touches[0].clientY) {
          // 向上滑动
          if (this.wrapperStart.tail === 0) {
            e.preventDefault();
          }
        } else {
          // 向下滑动
          if (this.wrapperStart.offset === 0) {
            e.preventDefault();
          }
        }
      }
    },

    onTouchEnd() {
      if (typeof this.wrapperStart === "number" && $A.isIos()) {
        $A.scrollToView(this.$refs.footer, false);
      }
    },

    forgetTempMsg(tempId) {
      this.tempMsgs = this.tempMsgs.filter(({ id }) => id != tempId);
    },

    setQuote(id, type) {
      this.$refs.input?.setQuote(id, type);
    },

    cancelQuote() {
      this.$refs.input?.cancelQuote();
    },

    onCallTel() {
      this.$store
          .dispatch("call", {
            url: "dialog/tel",
            data: {
              dialog_id: this.dialogId,
            },
            spinner: 600,
          })
          .then(({ data }) => {
            if (data.tel) {
              $A.eeuiAppSendMessage({
                action: "callTel",
                tel: data.tel,
              });
            }
            if (data.add) {
              this.$store.dispatch("saveDialogMsg", data.add);
              this.$store.dispatch("updateDialogLastMsg", data.add);
              this.onActive();
            }
          })
          .catch(({ msg }) => {
            $A.modalError(msg);
          });
    },

    onAnon() {
      if (this.dialogData.type !== "user" || this.dialogData.bot) {
        $A.modalWarning("匿名消息仅允许发送给个人");
        return;
      }
      $A.modalInput({
        title: `发送匿名消息`,
        placeholder: `匿名消息将通过匿名消息（机器人）发送给对方，不会记录你的任何身份信息`,
        inputProps: {
          type: "textarea",
          rows: 3,
          autosize: { minRows: 3, maxRows: 6 },
          maxlength: 2000,
        },
        okText: "匿名发送",
        onOk: (value) => {
          if (!value) {
            return `请输入消息内容`;
          }
          return new Promise((resolve, reject) => {
            this.$store
                .dispatch("call", {
                  url: "dialog/msg/sendanon",
                  data: {
                    userid: this.dialogData.dialog_user.userid,
                    text: value,
                  },
                  method: "post",
                })
                .then(({ msg }) => {
                  resolve(msg);
                })
                .catch(({ msg }) => {
                  reject(msg);
                });
          });
        },
      });
    },

    onResizeEvent(entries) {
      // entries.some(({target, contentRect}) => {
      //     if (target === this.$refs.msgs) {
      //         this.onMsgsResize(contentRect)
      //     } else if (target === this.$refs.footer) {
      //         this.onFooterResize()
      //     }
      // })
    },

    onMsgsResize({ height }) {
      console.log("onMsgsResize---------");
      this.$refs.scroller.$el.style.height = `${height}px`;
      //
      if (typeof this.__msgs_height !== "undefined") {
        const size = this.__msgs_height - height;
        if (size !== 0) {
          const { offset, tail } = this.scrollInfo();
          if (tail > 0) {
            this.onToOffset(offset + size);
          }
        }
      }
      this.__msgs_height = height;
    },

    onFooterResize() {
      if (!this.$refs.footer) {
        return;
      }
      const footer = this.$refs.footer;
      const marginSize =
          parseInt($A.css(footer, "marginTop")) +
          parseInt($A.css(footer, "marginBottom"));
      if (this.$refs.msgs) {
        this.$refs.msgs.style.marginBottom = `${
            footer.getBoundingClientRect().height + marginSize
        }px`;
      }
    },

    onActive() {
      this.$emit("on-active");
    },

    onToBottom() {
      this.msgNew = 0;
      const scroller = this.$refs.scroller;
      if (scroller) {
        scroller.scrollToBottom();
        requestAnimationFrame((_) => scroller.scrollToBottom()); // 确保滚动到
      }
    },

    onToIndex(index) {
      console.log("onTouchStart1------------onToIndex");
      const scroller = this.$refs.scroller;
      if (scroller) {
        scroller.stopToBottom();
        scroller.scrollToIndex(index, -100);
        requestAnimationFrame((_) => scroller.scrollToIndex(index, -100)); // 确保滚动到
      }
      requestAnimationFrame((_) => (this.msgActiveIndex = index));
    },

    onToOffset(offset) {
      console.log("onTouchStart1------------offset");
      const scroller = this.$refs.scroller;
      if (scroller) {
        scroller.stopToBottom();
        scroller.scrollToOffset(offset);
        setTimeout((_) => {
          scroller.scrollToOffset(offset);
          scroller.virtual.handleFront();
          // scroller.virtual.handleBehind()
        }, 10); // 预防出现白屏的情况
      }
    },

    onMarkOffset(recovery = false) {
      const scroller = this.$refs.scroller;
      if (!scroller) {
        return false;
      }
      if (recovery) {
        if (this.__mark_offset === undefined) {
          return false;
        }
        this.onToOffset(
            scroller.getScrollSize() -
            scroller.getClientSize() -
            this.__mark_offset
        );
        this.__mark_offset = undefined;
      } else {
        this.__mark_offset =
            scroller.getScrollSize() -
            scroller.getClientSize() -
            scroller.getOffset();
      }
      return true;
    },

    scrollInfo() {
      const scroller = this.$refs.scroller;
      if (scroller) {
        return scroller.scrollInfo();
      } else {
        return {
          offset: 0,
          scale: 0,
          tail: 0,
        };
      }
    },

    openProject() {
      if (!this.dialogData.group_info) {
        return;
      }
      if (this.windowPortrait) {
        this.$store.dispatch("openDialog", 0);
      }
      this.goForward({
        name: "manage-project",
        params: { projectId: this.dialogData.group_info.id },
      });
    },

    openTask() {
      if (!this.dialogData.group_info) {
        return;
      }
      if (this.taskId > 0) {
        // 如果当前打开着任务窗口则关闭对话窗口
        this.$store.dispatch("openDialog", 0);
      }
      this.$store.dispatch("openTask", {
        id: this.dialogData.group_info.id,
        deleted_at: this.dialogData.group_info.deleted_at,
        archived_at: this.dialogData.group_info.archived_at,
      });
    },

    openOkr() {
      if (!this.dialogData.link_id) {
        return;
      }
      //临时屏蔽掉
      // this.$store.dispatch("openOkr", this.dialogData.link_id);
    },

    onReGetMsg() {
      this.scrollToBottomAndRefresh = false;
      console.log("请求到这里4.......")
      // this.getMsgs({
      //   dialog_id: this.dialogId,
      //   msg_id: this.msgId,
      //   msg_type: this.msgType,
      // }).catch((_) => {});
    },

    onPrevPage() {
      console.log("获取列表--------------------------------------");
      console.log("获取列表数据来这里");
      if (this.prevId === 0) {
        return;
      }
      console.log("获取列表数据来这里，开始请求");
      console.log("请求到这里5.......")
      // this.getMsgs({
      //   dialog_id: this.dialogId,
      //   msg_id: this.msgId,
      //   msg_type: this.msgType,
      //   prev_id: this.prevId,
      //   save_before: (_) => (this.scrollDisabled = true),
      //   save_after: (_) => (this.scrollDisabled = false),
      // })
      //     .then(({ data }) => {
      //       console.log("执行了这里3....");
      //       const ids = data.list.map((item) => item.id); //TODO 重新位置
      //       this.$nextTick(() => {
      //         const scroller = this.$refs.scroller;
      //         const reducer = ids.reduce((previousValue, currentId) => {
      //           const previousSize =
      //               typeof previousValue === "object"
      //                   ? previousValue.size
      //                   : scroller.getSize(previousValue);
      //           return { size: previousSize + scroller.getSize(currentId) };
      //         });
      //         let offset = scroller.getOffset() + reducer.size;
      //         if (this.prevId === 0) {
      //           offset -= 36;
      //         }
      //         this.onToOffset(offset);
      //       });
      //     })
      //     .catch(() => {});
    },

    onDialogMenu(cmd) {
      switch (cmd) {
        case "searchMsg":
          this.searchShow = true;
          this.$nextTick((_) => {
            this.$refs.searchInput.focus();
          });
          break;

        case "openCreate":
          const userids = [this.userId];
          if (
              this.dialogData.dialog_user &&
              this.userId != this.dialogData.dialog_user.userid
          ) {
            userids.push(this.dialogData.dialog_user.userid);
          }
          this.createGroupData = { userids, uncancelable: [this.userId] };
          this.createGroupShow = true;
          break;

        case "modifyNormal":
          this.modifyData = {
            dialog_id: this.dialogData.id,
            avatar: this.dialogData.avatar,
            name: this.dialogData.name,
          };
          if (this.dialogData.type === "user") {
            // 机器人
            this.modifyData = Object.assign(this.modifyData, {
              userid: this.dialogData.dialog_user.userid,
              avatar: this.cacheUserBasic.find(
                  (item) => item.userid === this.dialogData.dialog_user.userid
              )?.userimg,
              clear_day: 0,
              webhook_url: "",
              system_name: "",
            });
            this.modifyLoad++;
            this.$store
                .dispatch("call", {
                  url: "users/bot/info",
                  data: {
                    id: this.dialogData.dialog_user.userid,
                  },
                })
                .then(({ data }) => {
                  this.modifyData.clear_day = data.clear_day;
                  this.modifyData.webhook_url = data.webhook_url;
                  this.modifyData.system_name = data.system_name;
                })
                .finally(() => {
                  this.modifyLoad--;
                });
          }
          this.modifyShow = true;
          break;

        case "modifyAdmin":
          this.modifyData = {
            dialog_id: this.dialogData.id,
            avatar: this.dialogData.avatar,
            admin: 1,
          };
          this.modifyShow = true;
          break;

        case "groupInfo":
          this.groupInfoShow = true;
          break;

        case "transfer":
          this.groupTransferData = {
            dialog_id: this.dialogId,
            userid: [],
            disabledChoice: [this.userId],
          };
          this.groupTransferShow = true;
          break;

        case "transferConfirm":
          this.onTransferGroup();
          break;

        case "disband":
          this.onDisbandGroup();
          break;

        case "exit":
          this.onExitGroup();
          break;
      }
    },

    onTransferGroup() {
      if (this.groupTransferData.userid.length === 0) {
        $A.messageError("请选择新的群主");
        return;
      }
      this.groupTransferLoad++;
      this.$store
          .dispatch("call", {
            url: "dialog/group/transfer",
            data: {
              dialog_id: this.dialogId,
              userid: this.groupTransferData.userid[0],
            },
          })
          .then(({ data, msg }) => {
            $A.messageSuccess(msg);
            this.$store.dispatch("saveDialog", data);
          })
          .catch(({ msg }) => {
            $A.modalError(msg);
          })
          .finally((_) => {
            this.groupTransferLoad--;
            this.groupTransferShow = false;
          });
    },

    onDisbandGroup() {
      $A.modalConfirm({
        content: `你确定要解散【${this.dialogData.name}】群组吗？`,
        loading: true,
        okText: "解散",
        onOk: () => {
          return new Promise((resolve, reject) => {
            this.$store
                .dispatch("call", {
                  url: "dialog/group/disband",
                  data: {
                    dialog_id: this.dialogId,
                  },
                })
                .then(({ msg }) => {
                  resolve(msg);
                  this.$store.dispatch("forgetDialog", this.dialogId);
                  this.goForward({ name: "manage-messenger" });
                })
                .catch(({ msg }) => {
                  reject(msg);
                });
          });
        },
      });
    },

    onExitGroup() {
      $A.modalConfirm({
        content: "你确定要退出群组吗？",
        loading: true,
        onOk: () => {
          return new Promise((resolve, reject) => {
            this.$store
                .dispatch("call", {
                  url: "dialog/group/deluser",
                  data: {
                    dialog_id: this.dialogId,
                  },
                })
                .then(({ msg }) => {
                  resolve(msg);
                  this.$store.dispatch("forgetDialog", this.dialogId);
                  this.goForward({ name: "manage-messenger" });
                })
                .catch(({ msg }) => {
                  reject(msg);
                });
          });
        },
      });
    },

    onCreateGroup() {
      this.createGroupLoad++;
      this.$store
          .dispatch("call", {
            url: "dialog/group/add",
            data: this.createGroupData,
          })
          .then(({ data, msg }) => {
            $A.messageSuccess(msg);
            this.createGroupShow = false;
            this.createGroupData = {};
            this.$store.dispatch("saveDialog", data);
            this.$store.dispatch("openDialog", data.id);
          })
          .catch(({ msg }) => {
            $A.modalError(msg);
          })
          .finally((_) => {
            this.createGroupLoad--;
          });
    },

    onModify() {
      if (this.modifyData.userid) {
        // 个人头像（机器人）
        this.modifyLoad++;
        this.$store
            .dispatch("call", {
              url: "users/bot/edit",
              data: {
                id: this.modifyData.userid,
                avatar: this.modifyData.avatar,
                name: this.modifyData.name,
                clear_day: this.modifyData.clear_day,
                webhook_url: this.modifyData.webhook_url,
              },
              method: "post",
            })
            .then(({ data, msg }) => {
              $A.messageSuccess(msg);
              this.$store.dispatch("saveUserBasic", {
                userid: this.modifyData.userid,
                nickname: data.name,
                userimg: data.avatar,
              });
              this.$store.dispatch("saveDialog", {
                id: this.modifyData.dialog_id,
                name: data.name,
              });
              this.modifyShow = false;
              this.modifyData = {};
            })
            .catch(({ msg }) => {
              $A.modalError(msg);
            })
            .finally((_) => {
              this.modifyLoad--;
            });
      } else {
        // 群组头像
        this.modifyLoad++;
        this.$store
            .dispatch("call", {
              url: "dialog/group/edit",
              data: this.modifyData,
            })
            .then(({ data, msg }) => {
              $A.messageSuccess(msg);
              this.$store.dispatch("saveDialog", data);
              this.modifyShow = false;
              this.modifyData = {};
            })
            .catch(({ msg }) => {
              $A.modalError(msg);
            })
            .finally((_) => {
              this.modifyLoad--;
            });
      }
    },

    onForwardBefore() {
      return new Promise((resolve, reject) => {
        this.forwardData = this.$refs.forwardSelect.formatSelect(
            this.$refs.forwardSelect.selects
        );
        if (this.forwardData.length === 0) {
          $A.messageError("请选择转发对话或成员");
        } else {
          this.forwardMessage = "";
          this.forwardSource = true;
          this.forwardhow = true;
        }
        reject();
      });
    },

    onForwardAffirm() {
      const selects = this.$refs.forwardSelect.selects;
      if (selects.length === 0) {
        $A.messageError("请选择转发对话或成员");
        return;
      }
      const dialogids = selects
          .filter((value) => $A.leftExists(value, "d:"))
          .map((value) => value.replace("d:", ""));
      const userids = selects.filter((value) => !$A.leftExists(value, "d:"));
      this.forwardLoad++;
      this.$store
          .dispatch("call", {
            url: "dialog/msg/forward",
            data: {
              dialogids,
              userids,
              msg_id: this.operateItem.id,
              show_source: this.forwardSource ? 1 : 0,
              leave_message: this.forwardMessage,
            },
          })
          .then(({ data, msg }) => {
            this.$store.dispatch("saveDialogMsg", data.msgs);
            this.$store.dispatch("updateDialogLastMsg", data.msgs);
            $A.messageSuccess(msg);
            this.$refs.forwardSelect.hide();
            this.forwardhow = false;
          })
          .catch(({ msg }) => {
            $A.modalError(msg);
          })
          .finally((_) => {
            this.forwardLoad--;
          });
    },

    onActivity(activity) {
      if (this.msgActivityStatus === false) {
        if (activity) {
          this.msgActivityStatus = 1;
        }
        return;
      }
      if (activity) {
        this.msgActivityStatus++;
      } else {
        this.msgActivityStatus--;
      }
    },

    onScroll(event) {
      console.log("onTouchStart1------------scrollAction onScroll");
      if (this.operatePreventScroll === 0) {
        this.operateVisible = false;
      }
      //
      const { offset, tail } = this.scrollInfo();
      this.scrollOffset = offset;
      this.scrollTail = tail;
      if (this.scrollTail <= 55) {
        this.msgNew = 0;
        this.scrollToBottomAndRefresh && this.onReGetMsg();
      }
      //
      console.log("onTouchStart1------------scrollAction scrollTop");
      this.scrollAction = event.target.scrollTop;
      this.scrollDirection =
          this.scrollTmp <= this.scrollAction ? "down" : "up";
      setTimeout((_) => (this.scrollTmp = this.scrollAction), 0);
      //
      this.scrollIng++;
      setTimeout((_) => this.scrollIng--, 100);
    },

    onRange(range) {
      if (this.preventMoreLoad) {
        return;
      }
      const key = this.scrollDirection === "down" ? "next_id" : "prev_id";
      for (let i = range.start; i <= range.end; i++) {
        const rangeValue = this.allMsgs[i][key];
        if (rangeValue) {
          const nearMsg = this.allMsgs[i + (key === "next_id" ? 1 : -1)];
          if (nearMsg && nearMsg.id != rangeValue) {
            this.preventMoreLoad = true;
            console.log("请求到这里6.......")
            // this.getMsgs({
            //   dialog_id: this.dialogId,
            //   msg_id: this.msgId,
            //   msg_type: this.msgType,
            //   [key]: rangeValue,
            // }).finally((_) => {
            //   console.log("执行了这里2....");
            //   this.preventMoreLoad = false;
            // });
          }
        }
      }
    },

    onBack() {
      if (!this.beforeBack) {
        return this.handleBack();
      }
      const before = this.beforeBack();
      if (before && before.then) {
        before.then(() => {
          this.handleBack();
        });
      } else {
        this.handleBack();
      }
    },

    handleBack() {
      const { name, params } = this.$store.state.routeHistoryLast;
      if (name === this.$route.name && /^\d+$/.test(params.dialogId)) {
        this.goForward({ name: this.$route.name });
      } else {
        this.goBack();
      }
    },

    onMsgType(type) {
      switch (type) {
        case "project":
          this.openProject();
          break;

        case "task":
          this.openTask();
          break;

        case "okr":
          this.openOkr();
          break;

        default:
          if (this.loadMsg) {
            $A.messageWarning("正在加载，请稍后再试...");
          } else {
            this.msgType = type;
          }
          break;
      }
    },

    onMention(data) {
      const user = this.cacheUserBasic.find(
          ({ userid }) => userid == data.userid
      );
      if (user) {
        this.$refs.input.addMention({
          denotationChar: "@",
          id: user.userid,
          value: user.nickname,
        });
      }
    },

    onLongpress({ event, el, msgData }) {
      this.operateVisible = this.operateItem.id === msgData.id;
      this.operateItem = $A.isJson(msgData) ? msgData : {};
      this.operateCopys = [];
      if (event.target.nodeName === "IMG" && this.$Electron) {
        this.operateCopys.push({
          type: "image",
          icon: "&#xe7cd;",
          label: "复制图片",
          value: $A.thumbRestore(event.target.currentSrc),
        });
      } else if (event.target.nodeName === "A") {
        if (
            event.target.classList.contains("mention") &&
            event.target.classList.contains("file")
        ) {
          this.findOperateFile(this.operateItem.id, event.target.href);
        }
        this.operateCopys.push({
          type: "link",
          icon: "&#xe7cb;",
          label: "复制链接",
          value: event.target.href,
        });
      }
      if (msgData.type === "text") {
        if (event.target.nodeName === "IMG") {
          this.operateCopys.push({
            type: "imagedown",
            icon: "&#xe7a8;",
            label: "下载图片",
            value: $A.thumbRestore(event.target.currentSrc),
          });
        }
        const selectText = this.getSelectedTextInElement(el);
        if (selectText.length > 0) {
          this.operateCopys.push({
            type: "selected",
            icon: "&#xe7df;",
            label: "复制选择",
            value: selectText,
          });
        }
        if (msgData.msg.text.replace(/<[^>]+>/g, "").length > 0) {
          let label = this.operateCopys.length > 0 ? "复制文本" : "复制";
          if (selectText.length > 0) {
            label = "复制全部";
          }
          this.operateCopys.push({
            type: "text",
            icon: "&#xe77f;",
            label,
            value: "",
          });
        }
      }
      this.$nextTick(() => {
        const projectRect = el.getBoundingClientRect();
        const wrapRect = this.$el.getBoundingClientRect();
        this.operateStyles = {
          left: `${event.clientX - wrapRect.left}px`,
          top: `${projectRect.top + this.windowScrollY}px`,
          height: projectRect.height + "px",
        };
        this.operateClient = { x: event.clientX, y: event.clientY };
        this.operateVisible = true;
      });
    },

    onOperate(action, value = null) {
      this.operateVisible = false;
      this.$nextTick((_) => {
        switch (action) {
          case "reply":
            this.onReply();
            break;

          case "update":
            this.onUpdate();
            break;

          case "copy":
            this.onCopy(value);
            break;

          case "forward":
            this.$refs.forwardSelect.onSelection();
            break;

          case "withdraw":
            this.onWithdraw();
            break;

          case "view":
            this.onViewFile();
            break;

          case "down":
            this.onDownFile();
            break;

          case "tag":
            this.onTag();
            break;

          case "newTask":
            let content = $A.formatMsgBasic(this.operateItem.msg.text);
            content = content.replace(
                /<img[^>]*?src=(["'])(.*?)(_thumb\.jpg)*\1[^>]*?>/g,
                `<img src="$2">`
            );
            Store.set("addTask", { owner: [this.userId], content });
            break;

          case "todo":
            this.onTodo();
            break;

          case "pos":
            this.onPositionId(this.operateItem.id);
            break;

          case "emoji":
            if (value === "more") {
              choiceEmojiOne().then(this.onEmoji);
            } else {
              this.onEmoji(value);
            }
            break;

          case "top":
            this.onTopOperate();
            break;
        }
      });
    },

    onReply(type) {
      this.setQuote(this.operateItem.id, type);
      this.inputFocus();
    },

    onUpdate() {
      const { type } = this.operateItem;
      this.onReply(type === "text" ? "update" : "reply");
      if (type === "text") {
        let { text, type } = this.operateItem.msg;
        this.$refs.input.setPasteMode(false);
        if (type === "md") {
          this.$refs.input.setText(text);
        } else {
          if (text.indexOf("mention") > -1) {
            text = text.replace(
                /<a class="mention file" href="([^'"]*)"([^>]*)>~([^>]*)<\/a>/g,
                '<span class="mention" data-denotation-char="~" data-id="$1" data-value="$3">&#xFEFF;<span contenteditable="false"><span class="ql-mention-denotation-char">~</span>$3</span>&#xFEFF;</span>'
            );
            text = text.replace(
                /<span class="mention ([^'"]*)" data-id="(\d+)">([@#])([^>]*)<\/span>/g,
                '<span class="mention" data-denotation-char="$3" data-id="$2" data-value="$4">&#xFEFF;<span contenteditable="false"><span class="ql-mention-denotation-char">$3</span>$4</span>&#xFEFF;</span>'
            );
          }
          text = text.replace(/<img[^>]*>/gi, (match) => {
            return match.replace(/(width|height)="\d+"\s*/gi, "");
          });
          this.msgText = $A.formatMsgBasic(text);
        }
        this.$nextTick((_) => this.$refs.input.setPasteMode(true));
      }
    },

    onCopy(data) {
      if (!$A.isJson(data)) {
        return;
      }
      const { type, value } = data;
      switch (type) {
        case "image":
          if (this.$Electron) {
            this.getBase64Image(value).then((base64) => {
              this.$Electron.sendMessage("copyBase64Image", { base64 });
            });
          }
          break;

        case "imagedown":
          if (this.$Electron) {
            this.$Electron.sendMessage("saveImageAt", {
              params: {},
              url: value,
            });
          } else {
            this.$store.dispatch("downUrl", {
              url: value,
              token: false,
            });
          }
          break;

        case "filepos":
          this.$store.dispatch("filePos", value);
          break;

        case "link":
          this.$copyText(value)
              .then((_) => $A.messageSuccess("复制成功"))
              .catch((_) => $A.messageError("复制失败"));
          break;

        case "selected":
          this.$copyText(value)
              .then((_) => $A.messageSuccess("复制成功"))
              .catch((_) => $A.messageError("复制失败"));
          break;

        case "text":
          const copyEl = $A(this.$refs.scroller.$el)
              .find(`[data-id="${this.operateItem.id}"]`)
              .find(".dialog-content");
          if (copyEl.length > 0) {
            const text = copyEl[0].innerText
                .replace(/\n\n/g, "\n")
                .replace(/(^\s*)|(\s*$)/g, "");
            this.$copyText(text)
                .then((_) => $A.messageSuccess("复制成功"))
                .catch((_) => $A.messageError("复制失败"));
          } else {
            $A.messageWarning("不可复制的内容");
          }
          break;
      }
    },

    onWithdraw() {
      $A.modalConfirm({
        content: `确定撤回此信息吗？`,
        okText: "撤回",
        loading: true,
        onOk: () => {
          return new Promise((resolve, reject) => {
            this.$store
                .dispatch("call", {
                  url: "dialog/msg/withdraw",
                  data: {
                    msg_id: this.operateItem.id,
                  },
                })
                .then(() => {
                  resolve("消息已撤回");
                  this.$store.dispatch("forgetDialogMsg", this.operateItem.id);
                })
                .catch(({ msg }) => {
                  reject(msg);
                });
          });
        },
      });
    },

    onViewFile(data) {
      if (this.operateVisible) {
        return;
      }
      if (!$A.isJson(data)) {
        data = this.operateItem;
      }
      const { msg } = data;
      if (["jpg", "jpeg", "webp", "gif", "png"].includes(msg.ext)) {
        this.onViewPicture(msg.path);
        return;
      }
      const path = `/single/file/msg/${data.id}`;
      if (this.$Electron) {
        this.$Electron.sendMessage("windowRouter", {
          name: `file-msg-${data.id}`,
          path: path,
          userAgent: "/hideenOfficeTitle/",
          force: false,
          config: {
            title: `${msg.name} (${$A.bytesToSize(msg.size)})`,
            titleFixed: true,
            parent: null,
            width: Math.min(window.screen.availWidth, 1440),
            height: Math.min(window.screen.availHeight, 900),
          },
          webPreferences: {
            nodeIntegrationInSubFrames: msg.ext === "drawio",
          },
        });
      } else if (this.$isEEUiApp) {
        $A.eeuiAppOpenPage({
          pageType: "app",
          pageTitle: `${msg.name} (${$A.bytesToSize(msg.size)})`,
          url: "web.js",
          params: {
            titleFixed: true,
            allowAccess: true,
            url:
                $A.rightDelete(window.location.href, window.location.hash) +
                `#${path}`,
          },
        });
      } else {
        window.open($A.apiUrl(`..${path}`));
      }
    },

    onViewPicture(currentUrl) {
      const data = this.allMsgs.filter((item) => {
        if (item.type === "file") {
          return ["jpg", "jpeg", "webp", "gif", "png"].includes(item.msg.ext);
        } else if (item.type === "text") {
          return item.msg.text.match(/<img\s+class="browse"[^>]*?>/);
        }
        return false;
      });
      //
      const list = [];
      data.some(({ type, msg }) => {
        if (type === "file") {
          list.push({
            src: msg.path,
            width: msg.width,
            height: msg.height,
          });
        } else if (type === "text") {
          list.push(...$A.getTextImagesInfo(msg.text));
        }
      });
      //
      const index = list.findIndex(({ src }) => src === currentUrl);
      if (index > -1) {
        this.$store.dispatch("previewImage", { index, list });
      } else {
        this.$store.dispatch("previewImage", currentUrl);
      }
    },

    onDownFile(data) {
      if (this.operateVisible) {
        return;
      }
      if (!$A.isJson(data)) {
        data = this.operateItem;
      }
      $A.modalConfirm({
        title: "下载文件",
        content: `${data.msg.name} (${$A.bytesToSize(data.msg.size)})`,
        okText: "立即下载",
        onOk: () => {
          this.$store.dispatch(
              "downUrl",
              $A.apiUrl(`dialog/msg/download?msg_id=${data.id}`)
          );
        },
      });
    },

    onReplyList(data) {
      if (this.operateVisible) {
        return;
      }
      this.replyListId = data.msg_id;
      this.replyListShow = true;
    },

    onError(data) {
      if (data.error !== true) {
        return;
      }
      const { type, mType, content, msg } = data.errorData;
      const config = {
        icon: "error",
        title: "发送失败",
        content,
        cancelText: "取消发送",
        onCancel: (_) => {
          this.forgetTempMsg(data.id);
        },
      };
      if (type === "text") {
        config.okText = "重新发送";
        config.onOk = () => {
          this.forgetTempMsg(data.id);
          console.log("sendMsg--------------2");
          this.sendMsg(msg, mType);
        };
      } else if (type === "record") {
        config.okText = "重新发送";
        config.onOk = () => {
          this.forgetTempMsg(data.id);
          this.sendRecord(msg);
        };
      } else {
        return;
      }
      $A.modalConfirm(config);
    },

    onEmoji(data) {
      if (!$A.isJson(data)) {
        data = {
          msg_id: this.operateItem.id,
          symbol: data,
        };
      }
      //
      const cacheEmojis = this.cacheEmojis.filter(
          (item) => item !== data.symbol
      );
      cacheEmojis.unshift(data.symbol);
      $A.IDBSave(
          "cacheEmojis",
          (this.$store.state.cacheEmojis = cacheEmojis.slice(0, 3))
      );
      //
      this.$store.dispatch("setLoad", {
        key: `msg-${data.msg_id}`,
        delay: 600,
      });
      this.$store
          .dispatch("call", {
            url: "dialog/msg/emoji",
            data,
          })
          .then(({ data: resData }) => {
            const index = this.dialogMsgs.findIndex(
                (item) => item.id == resData.id
            );
            if (index > -1) {
              this.$store.dispatch("saveDialogMsg", resData);
            } else if (this.todoViewData.id === resData.id) {
              this.todoViewData = Object.assign(this.todoViewData, resData);
            }
          })
          .catch(({ msg }) => {
            $A.messageError(msg);
          })
          .finally((_) => {
            this.$store.dispatch("cancelLoad", `msg-${data.msg_id}`);
          });
    },

    onShowEmojiUser(data) {
      if (this.operateVisible) {
        return;
      }
      this.respondData = data;
      this.respondShow = true;
    },

    onTag() {
      if (this.operateVisible) {
        return;
      }
      const data = {
        msg_id: this.operateItem.id,
      };
      //
      this.$store.dispatch("setLoad", {
        key: `msg-${data.msg_id}`,
        delay: 600,
      });
      this.$store
          .dispatch("call", {
            url: "dialog/msg/tag",
            data,
          })
          .then(({ data }) => {
            this.tagOrTodoSuccess(data);
          })
          .catch(({ msg }) => {
            $A.messageError(msg);
          })
          .finally((_) => {
            this.$store.dispatch("cancelLoad", `msg-${data.msg_id}`);
          });
    },

    onTypeChange(val) {
      if (val === "user") {
        if (
            this.todoSettingData.userids.length === 0 &&
            this.todoSettingData.quick_value.length > 0
        ) {
          this.todoSettingData.userids = this.todoSettingData.quick_value;
        }
        this.$nextTick((_) => {
          this.$refs.userSelect.onSelection();
        });
      }
      if (val !== "quick_select") {
        this.todoSettingData.quick_value = [];
      }
    },

    onQuickChange(val) {
      this.todoSettingData.type = val.length === 0 ? "all" : "quick_select";
    },

    onTodo(type) {
      if (this.operateVisible) {
        return;
      }
      if (type === "submit") {
        const todoData = $A.cloneJSON(this.todoSettingData);
        if (todoData.type === "quick_select") {
          todoData.type = "user";
          todoData.userids = todoData.quick_value;
        } else if (
            todoData.type === "user" &&
            $A.arrayLength(todoData.userids) === 0
        ) {
          $A.messageWarning("选择指定成员");
          return;
        }
        this.todoSettingLoad++;
        this.onTodoSubmit(todoData)
            .then((msg) => {
              $A.messageSuccess(msg);
              this.todoSettingShow = false;
            })
            .catch((e) => {
              $A.messageError(e);
            })
            .finally((_) => {
              this.todoSettingLoad--;
            });
      } else {
        const quickList = {};
        quickList[this.userId] = this.userId;
        const userid = this.dialogData.dialog_user?.userid;
        if (userid && userid != this.userId && !this.dialogData.bot) {
          quickList[userid] = userid;
        }
        if (this.operateItem.type === "text") {
          const atReg =
              /<span class="mention user" data-id="(\d+)">([^<]+)<\/span>/g;
          const atList = this.operateItem.msg.text.match(atReg);
          if (atList) {
            atList.forEach((item) => {
              const userid = parseInt(item.replace(atReg, "$1"));
              if (userid && userid != this.userId) {
                quickList[userid] = userid;
              }
            });
          }
        }
        this.todoSettingData = {
          type: "all",
          userids: [],
          msg_id: this.operateItem.id,
          quick_value: [],
          quick_list: Object.values(quickList),
        };
        if (this.operateItem.todo) {
          $A.modalConfirm({
            content: "你确定取消待办吗？",
            cancelText: "取消",
            okText: "确定",
            loading: true,
            onOk: () => this.onTodoSubmit(this.todoSettingData),
          });
        } else {
          this.todoSettingShow = true;
        }
      }
    },

    onTodoSubmit(data) {
      return new Promise((resolve, reject) => {
        this.$store.dispatch("setLoad", {
          key: `msg-${data.msg_id}`,
          delay: 600,
        });
        this.$store
            .dispatch("call", {
              url: "dialog/msg/todo",
              data,
            })
            .then(({ data, msg }) => {
              resolve(msg);
              this.tagOrTodoSuccess(data);
              this.onActive();
            })
            .catch(({ msg }) => {
              reject(msg);
            })
            .finally((_) => {
              this.$store.dispatch("cancelLoad", `msg-${data.msg_id}`);
            });
      });
    },

    tagOrTodoSuccess(data) {
      this.$store.dispatch("saveDialogMsg", data.update);
      if (data.add) {
        this.$store.dispatch("saveDialogMsg", data.add);
        this.$store.dispatch("updateDialogLastMsg", data.add);
      }
    },

    onSearchSwitch(type) {
      if (this.searchResult.length === 0) {
        return;
      }
      if (this.searchLocation === 1 && this.searchResult.length === 1) {
        this.onPositionId(this.searchResult[0]);
        return;
      }
      if (type === "prev") {
        if (this.searchLocation <= 1) {
          this.searchLocation = this.searchResult.length;
        } else {
          this.searchLocation--;
        }
      } else {
        if (this.searchLocation >= this.searchResult.length) {
          this.searchLocation = 1;
        } else {
          this.searchLocation++;
        }
      }
    },

    onSearchKeyup(e) {
      if (e === null || e.keyCode === 27) {
        this.searchShow = false;
        this.searchKey = "";
        this.searchResult = [];
      }
    },

    onPositionMark(id) {
      if (this.positionLoad > 0) {
        return;
      }
      this.positionLoad++;
      //
      this.onPositionId(id).finally((_) => {
        this.positionLoad--;
      });
    },

    findOperateFile(msgId, link) {
      const file = this.fileLinks.find((item) => item.link === link);
      if (file) {
        this.addFileMenu(msgId, file);
        return;
      }
      this.$store
          .dispatch("searchFiles", {
            link,
          })
          .then(({ data }) => {
            if (data.length === 1) {
              const file = {
                link,
                id: data[0].id,
                pid: data[0].pid,
              };
              this.fileLinks.push(file);
              this.addFileMenu(msgId, file);
            }
          })
          .catch((_) => {});
    },

    addFileMenu(msgId, data) {
      if (this.operateItem.id != msgId) {
        return;
      }
      if (
          this.operateCopys.findIndex((item) => item.type === "filepos") !== -1
      ) {
        return;
      }
      const index = Math.max(
          0,
          this.operateCopys.findIndex((item) => item.type === "link") - 1
      );
      this.operateCopys.splice(index, 0, {
        type: "filepos",
        icon: "&#xe6f3;",
        label: "显示文件",
        value: {
          folderId: data.pid,
          fileId: null,
          shakeId: data.id,
        },
      });
    },

    getBase64Image(url) {
      return new Promise((resolve) => {
        let canvas = document.createElement("CANVAS"),
            ctx = canvas.getContext("2d"),
            img = new Image();
        img.crossOrigin = "Anonymous";
        img.onload = () => {
          canvas.height = img.height;
          canvas.width = img.width;
          ctx.drawImage(img, 0, 0);
          let format = "png";
          if ($A.rightExists(url, "jpg") || $A.rightExists(url, "jpeg")) {
            format = "jpeg";
          } else if ($A.rightExists(url, "webp")) {
            format = "webp";
          } else if ($A.rightExists(url, "git")) {
            format = "git";
          }
          resolve(canvas.toDataURL(`image/${format}`));
          canvas = null;
        };
        img.src = url;
      });
    },

    getSelectedTextInElement(element) {
      let selectedText = "";
      if (window.getSelection) {
        let selection = window.getSelection();
        if (selection.rangeCount > 0) {
          const range = selection.getRangeAt(0);
          if (element.contains(range.commonAncestorContainer)) {
            selectedText = range.toString();
          }
        }
      }
      return selectedText;
    },

    onViewAvatar(e) {
      let src = null;
      if (e.target.tagName === "IMG") {
        src = e.target.src;
      } else {
        src = $A(e.target).find("img").attr("src");
      }
      if (src) {
        this.$store.dispatch("previewImage", src);
      }
    },

    onTopOperate() {
      if (this.operateVisible) {
        return;
      }
      if (this.operateItem.top_at) {
        this.onCancelTop(this.operateItem);
      } else {
        this.onTopSubmit(this.operateItem);
      }
    },

    onTopSubmit(data) {
      return new Promise((resolve, reject) => {
        this.$store.dispatch("setLoad", {
          key: `msg-${data.msg_id}`,
          delay: 600,
        });
        this.$store
            .dispatch("call", {
              url: "dialog/msg/top",
              data: {
                msg_id: data.id,
              },
            })
            .then(({ data, msg }) => {
              resolve(msg);
              // 取消置顶
              this.$store.dispatch("saveDialog", {
                id: this.dialogId,
                top_msg_id: data.update?.top_msg_id || 0,
                top_userid: data.update?.top_userid || 0,
              });
              // 置顶
              if (data.update?.top_msg_id) {
                const index = this.dialogMsgs.findIndex(
                    ({ id }) => id == data.update.top_msg_id
                );
                if (index > -1) {
                  this.$store.dispatch(
                      "saveDialogMsgTop",
                      Object.assign({}, this.dialogMsgs[index])
                  );
                }
              }
              // 添加消息
              if (data.add) {
                this.$store.dispatch("saveDialogMsg", data.add);
                this.$store.dispatch("updateDialogLastMsg", data.add);
                this.onActive();
              }
            })
            .catch(({ msg }) => {
              reject(msg);
            })
            .finally((_) => {
              this.$store.dispatch("cancelLoad", `msg-${data.msg_id}`);
            });
      });
    },

    onPosTop() {
      if (!this.topMsg) {
        return;
      }
      this.topPosLoad = true;
      this.onPositionId(this.topMsg.id).finally((_) => {
        this.topPosLoad = false;
      });
    },

    onCancelTop(info) {
      $A.modalConfirm({
        content: "你确定取消置顶吗？",
        cancelText: "取消",
        okText: "确定",
        loading: true,
        onOk: () => this.onTopSubmit(info),
      });
    },

    getUserApproveStatus() {
      console.log(
          "111112进到这里2..getUserApproveStatus..IN........................"
      );
      this.approvaUserStatus = "";
      if (this.dialogData.type !== "user" || this.dialogData.bot) {
        return;
      }
      this.$store
          .dispatch("call", {
            url: "approve/user/status",
            data: {
              userid: this.dialogData.dialog_user.userid,
            },
          })
          .then(({ data }) => {
            this.approvaUserStatus = data;
          })
          .catch(({ msg }) => {
            $A.messageError(msg);
          });
    },
  },
};
</script>
<style scoped>
.chat {
  width: 100%;
  height: 100vh;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  position: relative;
}

.header {
  height: 60px;
  background-color: #f5f5f5;
  display: flex;
  align-items: center;
  justify-content: center;
  border-bottom: 1px;
  position: fixed;
  top: env(safe-area-inset-top);
  left: 0;
  right: 0;
  z-index: 9999;
  width: 100%;
}

@media (prefers-color-scheme: dark) {
  .header {
    background-color: #000;
  }
}

.header .left {
  display: flex;
}

.header .left button {
  margin-left: 10px;
  height: 40px;
  display: flex;
  align-items: center;
  font-size: 15px;
  background-color: transparent;
}

.header .center {
  flex: 1;
  font-size: 18px;
  font-weight: bold;
}

.header .right button {
  margin-right: 10px;
  height: 40px;
  display: flex;
  align-items: center;
  font-size: 15px;
  background-color: transparent;
  color: rgb(228, 98, 64);
}

.content {
  background-color: #f5f5f5;
  position: relative;
  display: flex;
  height: calc(100vh - 60px);
  /* header + footer */
  /* header height */
  padding-top: calc(60px + env(safe-area-inset-top));
  /* padding-top: 60px; */
  /* padding-bottom: 60px; */
  /* overflow-y: auto; */
  /* footer height */
}

@media (prefers-color-scheme: dark) {
  .content {
    background-color: #000;
  }
}

.message {
  display: flex;
  margin: 10px;
}

.message.right {
  justify-content: flex-end;
}

.message .bubble {
  background-color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 0px 10px 10px 10px;
  padding: 10px;
  color: black;
  margin-left: 10px;
}

.bubble.right {
  border-radius: 10px 0px 10px 10px;
  background-color: #5b8ff9;
  color: white;
  margin-right: 10px;
}

.message .avatar {
  width: 40px;
  height: 40px;
  background-color: green;
  border-radius: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 16px;
  color: white;
}

.message .status {
  font-size: 12px;
  color: rgb(228, 98, 64);
  margin-left: 10px;
  margin-bottom: 5px;
  display: flex;
  align-items: center;
}

.message .bubble .text {
  display: flex;
  text-align: left;
  font-size: 14px;
  max-width: 250px;
  word-break: break-all;
}

.footer {
  height: 60px;
  background-color: white;
  display: flex;
  bottom: env(safe-area-inset-bottom);
  width: 100%;
  align-items: center;
}

@media (prefers-color-scheme: dark) {
  .footer {
    background-color: #333;
  }
}

.footer button {
  width: 80px;
  height: 40px;
  margin: 5px;
  border: none;
  outline: none;
  background-color: rgb(228, 98, 64);
  color: white;
  font-size: 15px;
}

.footer input {
  flex: 1;
  border: none;
  outline: none;
  margin-left: 10px;
}

.message-box {
  width: 100%;
  height: 100%;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.message-list {
  position: absolute;
  width: 100%;
  overflow-y: auto;
  height: calc(100% - 259px);
  padding: 16px 32px 0px;
}

.chat-input-box2 {
  font-size: 14px;
  margin: 4px 12px;
  line-height: 22px;
  border: none;
  outline: none;
  color: #303133;
  flex: 1;
  background: transparent;
}

.chat-input-box2:focus {
  caret-color: #ccc;
}
.chat-input-box2::placeholder {
  color: #ccc; /* 设置提示文本的颜色 */
}
.chat-input-wrapper {
  background-color: #f4f5f7;
  padding: 8px 2px;
  border-radius: 10px;
  position: relative;
  vertical-align: middle;
  width: 100%;
  display: flex; /* 使用 Flexbox 布局 */
  align-items: center; /* 垂直居中对齐 */
}

.chat—send—btn {
  height: 38px;
  width: 58px;
  background: #4b70f3;
  color: white;
  border: 0;
  margin-right: 8px;
  border-radius: 5px;
}
.chat—send—btn:hover {
  background-color: #5b8ff9; /* hover时的背景颜色 */
}

.dialog-footer {
  background: #fff;
  padding: 5px 24px 12px;
  margin-bottom: 0;
}
</style>
