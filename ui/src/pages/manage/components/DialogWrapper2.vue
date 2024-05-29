<!--<template>-->
<!--    &lt;!&ndash;备份&ndash;&gt;-->
<!--    <div-->
<!--        v-if="isReady"-->
<!--        class="dialog-wrapper"-->
<!--        :class="wrapperClass"-->
<!--        @drop.prevent="chatPasteDrag($event, 'drag')"-->
<!--        @dragover.prevent="chatDragOver(true, $event)"-->
<!--        @dragleave.prevent="chatDragOver(false, $event)"-->
<!--        @touchstart="onTouchStart"-->
<!--        @touchmove="onTouchMove"-->
<!--        @touchend="onTouchEnd">-->
<!--        &lt;!&ndash;顶部导航&ndash;&gt;-->
<!--        <div ref="nav" class="dialog-nav">-->
<!--            <slot name="head">-->
<!--                <div class="nav-wrapper" :class="navClass">-->
<!--                    <div class="dialog-back" @click="onBack">-->
<!--                        <i class="taskfont">&#xe676;</i>-->
<!--                        <div v-if="msgUnreadOnly" class="back-num">{{msgUnreadOnly}}</div>-->
<!--                    </div>-->

<!--                    <div class="dialog-block">-->
<!--                        <div class="dialog-avatar" @click="onViewAvatar">-->
<!--                            <template v-if="dialogData.type=='group'">-->
<!--                                <EAvatar v-if="dialogData.avatar" class="img-avatar" :src="dialogData.avatar" :size="42"></EAvatar>-->
<!--                                <i v-else-if="dialogData.group_type=='department'" class="taskfont icon-avatar department">&#xe75c;</i>-->
<!--                                <i v-else-if="dialogData.group_type=='project'" class="taskfont icon-avatar project">&#xe6f9;</i>-->
<!--                                <i v-else-if="dialogData.group_type=='task'" class="taskfont icon-avatar task">&#xe6f4;</i>-->
<!--                                <i v-else-if="dialogData.group_type=='okr'" class="taskfont icon-avatar task">&#xe6f4;</i>-->
<!--                                <Icon v-else class="icon-avatar" type="ios-people" />-->
<!--                            </template>-->
<!--                            <div v-else-if="dialogData.dialog_user" class="user-avatar">-->
<!--                                <UserAvatarTip :online.sync="dialogData.online_state" :userid="dialogData.dialog_user.userid" :size="42">-->
<!--                                    <p v-if="dialogData.type === 'user' && dialogData.online_state !== true" slot="end">-->
<!--                                        {{$L(dialogData.online_state)}}-->
<!--                                    </p>-->
<!--                                </UserAvatarTip>-->
<!--                            </div>-->
<!--                            <Icon v-else class="icon-avatar" type="md-person" />-->
<!--                        </div>-->
<!--                        <div class="dialog-title">-->
<!--                            <div class="main-title">-->
<!--                                <template v-for="tag in $A.dialogTags(dialogData)" v-if="tag.color != 'success'">-->
<!--                                    <Tag :color="tag.color" :fade="false">{{$L(tag.text)}}</Tag>-->
<!--                                </template>-->
<!--                                <h2>{{dialogData.name}}</h2>-->
<!--                                <em v-if="peopleNum > 0" @click="onDialogMenu('groupInfo')">({{peopleNum}})</em>-->
<!--                                <Tag v-if="dialogData.bot" class="after" :fade="false">{{$L('机器人')}}</Tag>-->
<!--                                <Tag v-if="dialogData.type === 'user' && approvaUserStatus" class="after" color="red" :fade="false">{{$L(approvaUserStatus)}}</Tag>-->
<!--                                <Tag v-if="dialogData.group_type=='all'" class="after pointer" :fade="false" @on-click="onDialogMenu('groupInfo')">{{$L('全员')}}</Tag>-->
<!--                                <Tag v-else-if="dialogData.group_type=='department'" class="after pointer" :fade="false" @on-click="onDialogMenu('groupInfo')">{{$L('部门')}}</Tag>-->
<!--                                <div v-if="msgLoadIng > 0" class="load"><Loading/></div>-->
<!--                            </div>-->
<!--                            <ul class="title-desc">-->
<!--                                <li v-if="dialogData.type === 'user'" :class="[dialogData.online_state === true ? 'online' : 'offline']">-->
<!--                                    {{$L(dialogData.online_state === true ? '在线' : dialogData.online_state)}}-->
<!--                                </li>-->
<!--                            </ul>-->
<!--                            <ul v-if="tagShow" class="title-tags scrollbar-hidden">-->
<!--                                <li-->
<!--                                    v-for="item in msgTags"-->
<!--                                    :key="item.type"-->
<!--                                    :class="{-->
<!--                                        [item.type || 'msg']: true,-->
<!--                                        active: msgType === item.type,-->
<!--                                    }"-->
<!--                                    @click="onMsgType(item.type)">-->
<!--                                    <i class="no-dark-content"></i>-->
<!--                                    <span>{{$L(item.label)}}</span>-->
<!--                                </li>-->
<!--                            </ul>-->
<!--                        </div>-->
<!--                    </div>-->

<!--                    <EDropdown-->
<!--                        trigger="click"-->
<!--                        class="dialog-menu"-->
<!--                        @command="onDialogMenu">-->
<!--                        <i class="taskfont dialog-menu-icon">&#xe6e9;</i>-->
<!--                        <EDropdownMenu slot="dropdown">-->
<!--                            <EDropdownItem command="searchMsg">-->
<!--                                <div>{{$L('搜索消息')}}</div>-->
<!--                            </EDropdownItem>-->
<!--                            <template v-if="dialogData.type === 'user'">-->
<!--                                <EDropdownItem v-if="isManageBot" command="modifyNormal">-->
<!--                                    <div>{{$L('修改资料')}}</div>-->
<!--                                </EDropdownItem>-->
<!--                                <EDropdownItem command="openCreate">-->
<!--                                    <div>{{$L('创建群组')}}</div>-->
<!--                                </EDropdownItem>-->
<!--                            </template>-->
<!--                            <template v-else>-->
<!--                                <EDropdownItem command="groupInfo">-->
<!--                                    <div>{{$L('群组设置')}}</div>-->
<!--                                </EDropdownItem>-->
<!--                                <template v-if="dialogData.owner_id != userId">-->
<!--                                    <EDropdownItem v-if="dialogData.group_type === 'all' && userIsAdmin" command="modifyAdmin">-->
<!--                                        <div>{{$L('修改资料')}}</div>-->
<!--                                    </EDropdownItem>-->
<!--                                    <EDropdownItem command="exit">-->
<!--                                        <div style="color:#f00">{{$L('退出群组')}}</div>-->
<!--                                    </EDropdownItem>-->
<!--                                </template>-->
<!--                                <template v-else-if="dialogData.group_type === 'user'">-->
<!--                                    <EDropdownItem command="modifyNormal">-->
<!--                                        <div>{{$L('修改资料')}}</div>-->
<!--                                    </EDropdownItem>-->
<!--                                    <EDropdownItem command="transfer">-->
<!--                                        <div>{{$L('转让群主')}}</div>-->
<!--                                    </EDropdownItem>-->
<!--                                    <EDropdownItem command="disband">-->
<!--                                        <div style="color:#f00">{{$L('解散群组')}}</div>-->
<!--                                    </EDropdownItem>-->
<!--                                </template>-->
<!--                            </template>-->
<!--                        </EDropdownMenu>-->
<!--                    </EDropdown>-->

<!--                    &lt;!&ndash;搜索框&ndash;&gt;-->
<!--                    <div v-if="searchShow" class="dialog-search">-->
<!--                        <div class="search-location">-->
<!--                            <i class="taskfont" @click="onSearchSwitch('prev')">&#xe702;</i>-->
<!--                            <i class="taskfont" @click="onSearchSwitch('next')">&#xe705;</i>-->
<!--                        </div>-->
<!--                        <div class="search-input">-->
<!--                            <Input ref="searchInput" v-model="searchKey" :placeholder="$L('搜索消息')" @on-keyup="onSearchKeyup" clearable>-->
<!--                                <div class="search-pre" slot="prefix">-->
<!--                                    <Loading v-if="searchLoad > 0"/>-->
<!--                                    <Icon v-else type="ios-search" />-->
<!--                                </div>-->
<!--                            </Input>-->
<!--                            <div v-if="searchLoad === 0 && searchResult.length > 0" class="search-total" slot="append">{{searchLocation}}/{{searchResult.length}}</div>-->
<!--                        </div>-->
<!--                        <div class="search-cancel" @click="onSearchKeyup(null)">{{$L('取消')}}</div>-->
<!--                    </div>-->
<!--                </div>-->
<!--            </slot>-->
<!--        </div>-->

<!--        &lt;!&ndash;置顶消息&ndash;&gt;-->
<!--        <div v-if="topShow" class="dialog-top-message" @click="onPosTop">-->
<!--            <div class="dialog-top-message-warp">-->
<!--                <div class="dialog-top-message-font">-->
<!--                    <i class="taskfont">&#xe7e6;</i>-->
<!--                </div>-->
<!--                <div class="dialog-top-message-content">-->
<!--                    <p class="content">-->
<!--                        <UserAvatar :userid="topMsg.userid" showName :showIcon="false"/>:-->
<!--                        <span>{{$A.getMsgSimpleDesc(topMsg)}}</span>-->
<!--                    </p>-->
<!--                    <p class="personnel">-->
<!--                        {{ $L('置顶人员') }}-->
<!--                        <UserAvatar :userid="dialogData.top_userid" showName :showIcon="false"/>-->
<!--                    </p>-->
<!--                </div>-->
<!--                <div class="dialog-top-message-btn">-->
<!--                    <Loading v-if="topPosLoad" type="pure"/>-->
<!--                    <i v-else class="taskfont">&#xee15;</i>-->
<!--                    <i class="taskfont" @click.stop="onCancelTop(topMsg)">&#xe6e5;</i>-->
<!--                </div>-->
<!--            </div>-->
<!--        </div>-->

<!--        &lt;!&ndash;消息部分&ndash;&gt;-->
<!--        <div ref="msgs" class="dialog-msgs">-->
<!--            &lt;!&ndash;定位提示&ndash;&gt;-->
<!--&lt;!&ndash;           <p>1231313</p>&ndash;&gt;-->

<!--            <div v-if="positionShow && positionMsg" class="dialog-position">-->
<!--                <div class="position-label" @click="onPositionMark(positionMsg.msg_id)">-->
<!--                    <Icon v-if="positionLoad > 0" type="ios-loading" class="icon-loading"></Icon>-->
<!--                    <i v-else class="taskfont">&#xe624;</i>-->
<!--                    {{positionMsg.label}}-->
<!--                </div>-->
<!--            </div>-->

<!--            &lt;!&ndash;消息列表&ndash;&gt;-->
<!--            <VirtualList-->
<!--                ref="scroller"-->
<!--                class="dialog-scroller scrollbar-virtual"-->
<!--                active-prefix="item"-->
<!--                :data-key="'id'"-->
<!--                :data-sources="allMsgs"-->
<!--                :data-component="msgItem"-->
<!--                :item-class-add="itemClassAdd"-->
<!--                :extra-props="{dialogData, operateVisible, operateItem, isMyDialog, msgId, unreadOne, scrollIng, readEnabled}"-->
<!--                :estimate-size="dialogData.type=='group' ? 105 : 77"-->
<!--                :keeps="keeps"-->
<!--                :disabled="scrollDisabled"-->
<!--                @activity="onActivity"-->
<!--                @scroll="onScroll"-->
<!--                @range="onRange"-->
<!--                @totop="onPrevPage"-->
<!--                @resized="onItemRendered"-->

<!--                @on-mention="onMention"-->
<!--                @on-longpress="onLongpress"-->
<!--                @on-view-reply="onViewReply"-->
<!--                @on-view-text="onViewText"-->
<!--                @on-view-file="onViewFile"-->
<!--                @on-down-file="onDownFile"-->
<!--                @on-reply-list="onReplyList"-->
<!--                @on-error="onError"-->
<!--                @on-emoji="onEmoji"-->
<!--                @on-show-emoji-user="onShowEmojiUser">-->
<!--                <template #header>-->
<!--                  <p>1231313</p>-->
<!--&lt;!&ndash;                    <div v-if="(allMsgs.length === 0 && loadIng) || prevId > 0" class="dialog-item loading">&ndash;&gt;-->
<!--&lt;!&ndash;                        <div v-if="scrollOffset < 100" class="dialog-wrapper-loading"></div>&ndash;&gt;-->
<!--&lt;!&ndash;                    </div>&ndash;&gt;-->
<!--&lt;!&ndash;                    <div v-else-if="allMsgs.length === 0" class="dialog-item nothing">{{$L('暂无消息')}}</div>&ndash;&gt;-->
<!--                </template>-->
<!--            </VirtualList>-->
<!--        </div>-->

<!--        &lt;!&ndash;底部输入&ndash;&gt;-->
<!--        <div ref="footer" class="dialog-footer" @click="onActive">-->
<!--            <div-->
<!--                v-if="scrollTail > 500 || (msgNew > 0 && allMsgs.length > 0)"-->
<!--                class="dialog-goto"-->
<!--                @click="onToBottom">-->
<!--                <Badge :overflow-count="999" :count="msgNew">-->
<!--                    <i class="taskfont">&#xe72b;</i>-->
<!--                </Badge>-->
<!--            </div>-->
<!--            <DialogUpload-->
<!--                ref="chatUpload"-->
<!--                class="chat-upload"-->
<!--                :dialog-id="dialogId"-->
<!--                :maxSize="maxSize"-->
<!--                @on-progress="chatFile('progress', $event)"-->
<!--                @on-success="chatFile('success', $event)"-->
<!--                @on-error="chatFile('error', $event)"/>-->
<!--            <div v-if="todoShow" class="chat-bottom-menu">-->
<!--                <div class="bottom-menu-label">{{$L('待办')}}:</div>-->
<!--                <ul class="scrollbar-hidden">-->
<!--                    <li v-for="item in todoList" @click.stop="onViewTodo(item)">-->
<!--                        <div class="bottom-menu-desc no-dark-content">{{$A.getMsgSimpleDesc(item.msg_data)}}</div>-->
<!--                    </li>-->
<!--                </ul>-->
<!--            </div>-->
<!--            <div v-else-if="quickShow" class="chat-bottom-menu">-->
<!--                <ul class="scrollbar-hidden">-->
<!--                    <li v-for="item in quickMsgs" @click.stop="sendQuick(item)">-->
<!--                        <div class="bottom-menu-desc no-dark-content" :style="item.style || null">{{item.label}}</div>-->
<!--                    </li>-->
<!--                </ul>-->
<!--            </div>-->
<!--            <div v-if="isMute" class="chat-mute">-->
<!--                {{$L('禁言发言')}}-->
<!--            </div>-->
<!--            <ChatInput-->
<!--                v-else-->
<!--                ref="input"-->
<!--                v-model="msgText"-->
<!--                :dialog-id="dialogId"-->
<!--                :emoji-bottom="windowPortrait"-->
<!--                :maxlength="200000"-->
<!--                :placeholder="$L('输入消息...')"-->
<!--                @on-focus="onEventFocus"-->
<!--                @on-blur="onEventBlur"-->
<!--                @on-more="onEventMore"-->
<!--                @on-file="sendFileMsg"-->
<!--                @on-send="sendMsg"-->
<!--                @on-record="sendRecord"-->
<!--                @on-record-state="onRecordState"/>-->
<!--        </div>-->

<!--        &lt;!&ndash;长按、右键&ndash;&gt;-->
<!--        <div class="operate-position" :style="operateStyles" v-show="operateVisible">-->
<!--            <Dropdown-->
<!--                trigger="custom"-->
<!--                placement="top"-->
<!--                :visible="operateVisible"-->
<!--                @on-clickoutside="operateVisible = false"-->
<!--                transferClassName="dialog-wrapper-operate"-->
<!--                transfer>-->
<!--                <div :style="{userSelect:operateVisible ? 'none' : 'auto', height: operateStyles.height}"></div>-->
<!--                <DropdownMenu slot="list">-->
<!--                    <DropdownItem name="action">-->
<!--                        <ul class="operate-action">-->
<!--                            <li v-if="msgId === 0" @click="onOperate('reply')">-->
<!--                                <i class="taskfont">&#xe6eb;</i>-->
<!--                                <span>{{ $L('回复') }}</span>-->
<!--                            </li>-->
<!--                            <li v-if="operateItem.userid == userId && operateItem.type === 'text'" @click="onOperate('update')">-->
<!--                                <i class="taskfont">&#xe779;</i>-->
<!--                                <span>{{ $L('编辑') }}</span>-->
<!--                            </li>-->
<!--                            <li v-for="item in operateCopys" @click="onOperate('copy', item)">-->
<!--                                <i class="taskfont" v-html="item.icon"></i>-->
<!--                                <span>{{ $L(item.label) }}</span>-->
<!--                            </li>-->
<!--                            <li v-if="operateItem.type !== 'word-chain' && operateItem.type !== 'vote'" @click="onOperate('forward')">-->
<!--                                <i class="taskfont">&#xe638;</i>-->
<!--                                <span>{{ $L('转发') }}</span>-->
<!--                            </li>-->
<!--                            <li v-if="operateItem.userid == userId" @click="onOperate('withdraw')">-->
<!--                                <i class="taskfont">&#xe637;</i>-->
<!--                                <span>{{ $L('撤回') }}</span>-->
<!--                            </li>-->
<!--                            <template v-if="operateItem.type === 'file'">-->
<!--                                <li @click="onOperate('view')">-->
<!--                                    <i class="taskfont">&#xe77b;</i>-->
<!--                                    <span>{{ $L('查看') }}</span>-->
<!--                                </li>-->
<!--                                <li @click="onOperate('down')">-->
<!--                                    <i class="taskfont">&#xe7a8;</i>-->
<!--                                    <span>{{ $L('下载') }}</span>-->
<!--                                </li>-->
<!--                            </template>-->
<!--                            <li @click="onOperate('tag')">-->
<!--                                <i class="taskfont">&#xe61e;</i>-->
<!--                                <span>{{ $L(operateItem.tag ? '取消标注' : '标注') }}</span>-->
<!--                            </li>-->
<!--                            <li v-if="operateItem.type === 'text'" @click="onOperate('newTask')">-->
<!--                                <i class="taskfont">&#xe7b8;</i>-->
<!--                                <span>{{ $L('新任务') }}</span>-->
<!--                            </li>-->
<!--                            <li @click="onOperate('todo')">-->
<!--                                <i class="taskfont">&#xe7b7;</i>-->
<!--                                <span>{{ $L(operateItem.todo ? '取消待办' : '设待办') }}</span>-->
<!--                            </li>-->
<!--                            <li @click="onOperate('top')">-->
<!--                                <i class="taskfont" v-html="dialogData.top_msg_id == operateItem.id ? '&#xe7e3;' : '&#xe7e6;'"></i>-->
<!--                                <span>{{ $L(dialogData.top_msg_id == operateItem.id ? '取消置顶' : '置顶') }}</span>-->
<!--                            </li>-->
<!--                            <li v-if="msgType !== ''" @click="onOperate('pos')">-->
<!--                                <i class="taskfont">&#xee15;</i>-->
<!--                                <span>{{ $L('完整对话') }}</span>-->
<!--                            </li>-->
<!--                        </ul>-->
<!--                    </DropdownItem>-->
<!--                    <DropdownItem name="emoji" class="dropdown-emoji">-->
<!--                        <ul class="operate-emoji scrollbar-hidden">-->
<!--                            <li-->
<!--                                v-for="(emoji, key) in operateEmojis"-->
<!--                                :key="key"-->
<!--                                v-html="emoji"-->
<!--                                class="no-dark-content"-->
<!--                                @click="onOperate('emoji', emoji)"></li>-->
<!--                            <li></li>-->
<!--                            <li class="more-emoji" @click="onOperate('emoji', 'more')">-->
<!--                                <i class="taskfont">&#xe790;</i>-->
<!--                            </li>-->
<!--                        </ul>-->
<!--                    </DropdownItem>-->
<!--                </DropdownMenu>-->
<!--            </Dropdown>-->
<!--        </div>-->

<!--        &lt;!&ndash;拖动提示&ndash;&gt;-->
<!--        <div v-if="dialogDrag" class="drag-over" @click="dialogDrag=false">-->
<!--            <div class="drag-text">{{$L('拖动到这里发送')}}</div>-->
<!--        </div>-->

<!--        &lt;!&ndash;拖动发送提示&ndash;&gt;-->
<!--        <Modal-->
<!--            v-model="pasteShow"-->
<!--            :title="$L(pasteTitle)"-->
<!--            :cancel-text="$L('取消')"-->
<!--            :ok-text="$L('发送')"-->
<!--            :enter-ok="true"-->
<!--            :closable="false"-->
<!--            :mask-closable="false"-->
<!--            @on-ok="pasteSend">-->
<!--            <ul class="dialog-wrapper-paste" :class="pasteClass">-->
<!--                <li v-for="item in pasteItem">-->
<!--                    <img v-if="item.type == 'image'" :src="item.result"/>-->
<!--                    <div v-else>{{$L('文件')}}: {{item.name}} ({{$A.bytesToSize(item.size)}})</div>-->
<!--                </li>-->
<!--            </ul>-->
<!--        </Modal>-->

<!--        &lt;!&ndash;创建群组&ndash;&gt;-->
<!--        <Modal-->
<!--            v-model="createGroupShow"-->
<!--            :title="$L('创建群组')"-->
<!--            :mask-closable="false">-->
<!--            <Form :model="createGroupData" label-width="auto" @submit.native.prevent>-->
<!--                <FormItem prop="avatar" :label="$L('群头像')">-->
<!--                    <ImgUpload v-model="createGroupData.avatar" :num="1" :width="512" :height="512" :whcut="1"/>-->
<!--                </FormItem>-->
<!--                <FormItem prop="userids" :label="$L('群成员')">-->
<!--                    <UserSelect v-model="createGroupData.userids" :uncancelable="createGroupData.uncancelable" :multiple-max="100" show-bot :title="$L('选择项目成员')"/>-->
<!--                </FormItem>-->
<!--                <FormItem prop="chat_name" :label="$L('群名称')">-->
<!--                    <Input v-model="createGroupData.chat_name" :placeholder="$L('输入群名称（选填）')"/>-->
<!--                </FormItem>-->
<!--            </Form>-->
<!--            <div slot="footer" class="adaption">-->
<!--                <Button type="default" @click="createGroupShow=false">{{$L('取消')}}</Button>-->
<!--                <Button type="primary" :loading="createGroupLoad > 0" @click="onCreateGroup">{{$L('创建')}}</Button>-->
<!--            </div>-->
<!--        </Modal>-->

<!--        &lt;!&ndash;修改资料&ndash;&gt;-->
<!--        <Modal-->
<!--            v-model="modifyShow"-->
<!--            :title="$L('修改资料')"-->
<!--            :mask-closable="false">-->
<!--            <Form :model="modifyData" label-width="auto" @submit.native.prevent>-->
<!--                <Alert v-if="modifyData.system_name" type="error" style="margin-bottom:18px">{{$L(`正在修改系统机器人：${modifyData.system_name}`)}}</Alert>-->
<!--                <FormItem prop="avatar" :label="$L('头像')">-->
<!--                    <ImgUpload v-model="modifyData.avatar" :num="1" :width="512" :height="512" :whcut="1"/>-->
<!--                </FormItem>-->
<!--                <FormItem v-if="typeof modifyData.name !== 'undefined'" prop="name" :label="$L('名称')">-->
<!--                    <Input v-model="modifyData.name" :maxlength="20" />-->
<!--                </FormItem>-->
<!--                <template v-if="dialogData.bot == userId">-->
<!--                    <FormItem v-if="typeof modifyData.clear_day !== 'undefined'" prop="clear_day" :label="$L('消息保留')">-->
<!--                        <Input v-model="modifyData.clear_day" :maxlength="3" type="number">-->
<!--                            <div slot="append">{{$L('天')}}</div>-->
<!--                        </Input>-->
<!--                    </FormItem>-->
<!--                    <FormItem v-if="typeof modifyData.webhook_url !== 'undefined'" prop="webhook_url" label="Webhook">-->
<!--                        <Input v-model="modifyData.webhook_url" :maxlength="255" />-->
<!--                    </FormItem>-->
<!--                </template>-->
<!--            </Form>-->
<!--            <div slot="footer" class="adaption">-->
<!--                <Button type="default" @click="modifyShow=false">{{$L('取消')}}</Button>-->
<!--                <Button type="primary" :loading="modifyLoad > 0" @click="onModify">{{$L('保存')}}</Button>-->
<!--            </div>-->
<!--        </Modal>-->

<!--        &lt;!&ndash; 转发选择 &ndash;&gt;-->
<!--        <UserSelect-->
<!--            ref="forwardSelect"-->
<!--            :multiple-max="50"-->
<!--            :title="$L('转发')"-->
<!--            :before-submit="onForwardBefore"-->
<!--            :show-select-all="false"-->
<!--            show-dialog-->
<!--            module/>-->

<!--        &lt;!&ndash; 转发确认 &ndash;&gt;-->
<!--        <Modal-->
<!--            v-model="forwardhow"-->
<!--            :title="$L('转发给:')"-->
<!--            class-name="common-user-select-modal dialog-forward-message-modal"-->
<!--            :mask-closable="false"-->
<!--            width="420">-->
<!--            <div class="user-modal-search">-->
<!--                <Scrollbar class="search-selected" enable-x :enable-y="false">-->
<!--                    <ul>-->
<!--                        <li v-for="item in forwardData" :data-id="item.userid">-->
<!--                            <div v-if="item.type=='group'" class="user-modal-avatar">-->
<!--                                <EAvatar v-if="item.avatar" class="img-avatar" :src="item.avatar" :size="32"></EAvatar>-->
<!--                                <i v-else-if="item.group_type=='department'" class="taskfont icon-avatar department">&#xe75c;</i>-->
<!--                                <i v-else-if="item.group_type=='project'" class="taskfont icon-avatar project">&#xe6f9;</i>-->
<!--                                <i v-else-if="item.group_type=='task'" class="taskfont icon-avatar task">&#xe6f4;</i>-->
<!--                                <i v-else-if="item.group_type=='okr'" class="taskfont icon-avatar task">&#xe6f4;</i>-->
<!--                                <Icon v-else class="icon-avatar" type="ios-people" />-->
<!--                                <div v-if="forwardData.length == 1" class="avatar-name">-->
<!--                                    <span>{{item.name}}</span>-->
<!--                                </div>-->
<!--                            </div>-->
<!--                            <UserAvatar v-else :userid="item.userid" :size="32" :show-name="forwardData.length == 1"/>-->
<!--                        </li>-->
<!--                    </ul>-->
<!--                </Scrollbar>-->
<!--            </div>-->
<!--            <div class="twice-affirm-body-extend">-->
<!--                <div class="dialog-wrapper-forward-body">-->
<!--                    <div class="dialog-wrapper">-->
<!--                        <div class="dialog-scroller">-->
<!--                            <DialogItem :source="operateItem" simpleView :dialogAvatar="false"/>-->
<!--                        </div>-->
<!--                    </div>-->
<!--                    <div class="leave-message">-->
<!--                        <Input type="textarea" :autosize="{minRows: 1,maxRows: 3}" v-model="forwardMessage" :placeholder="$L('留言')" clearable />-->
<!--                    </div>-->
<!--                </div>-->
<!--            </div>-->
<!--            <template #footer>-->
<!--                <div class="dialog-wrapper-forward-footer" :class="{selected: !forwardSource}" @click="forwardSource = !forwardSource">-->
<!--                    <Icon class="user-modal-icon" :type="forwardSource ? 'ios-radio-button-off' : 'ios-checkmark-circle'" />-->
<!--                    {{$L('不显示原发送者信息')}}-->
<!--                </div>-->
<!--                <Button type="primary" :loading="forwardLoad > 0" @click="onForwardAffirm">-->
<!--                    {{$L('确定')}}-->
<!--                    <template v-if="forwardData.length > 0">({{forwardData.length}})</template>-->
<!--                </Button>-->
<!--            </template>-->
<!--        </Modal>-->


<!--        &lt;!&ndash; 设置待办 &ndash;&gt;-->
<!--        <Modal-->
<!--            v-model="todoSettingShow"-->
<!--            :title="$L('设置待办')"-->
<!--            :mask-closable="false">-->
<!--            <Form ref="todoSettingForm" :model="todoSettingData" label-width="auto" @submit.native.prevent>-->
<!--                <FormItem prop="type" :label="$L('当前会话')">-->
<!--                    <RadioGroup v-model="todoSettingData.type" @on-change="onTypeChange">-->
<!--                        <Radio label="all">{{$L('所有成员')}}</Radio>-->
<!--                        <Radio label="user">{{$L('指定成员')}}</Radio>-->
<!--                        <Radio label="quick_select" v-show="false"></Radio>-->
<!--                    </RadioGroup>-->
<!--                    <CheckboxGroup v-model="todoSettingData.quick_value" @on-change="onQuickChange">-->
<!--                        <Checkbox v-for="userid in todoSettingData.quick_list" :key="userid" :label="userid">-->
<!--                            <div class="dialog-wrapper-todo">-->
<!--                                <div>-->
<!--                                    <UserAvatar :userid="userid" :show-icon="false" :show-name="true"/>-->
<!--                                    <Tag v-if="userid==userId">{{$L('自己')}}</Tag>-->
<!--                                </div>-->
<!--                            </div>-->
<!--                        </Checkbox>-->
<!--                    </CheckboxGroup>-->
<!--                </FormItem>-->
<!--                <FormItem prop="userids" :label="$L('指定成员')" v-if="todoSettingData.type === 'user'">-->
<!--                    <UserSelect ref="userSelect" v-model="todoSettingData.userids" :dialog-id="dialogId" :title="$L('选择指定成员')"/>-->
<!--                </FormItem>-->
<!--            </Form>-->
<!--            <div slot="footer" class="adaption">-->
<!--                <Button type="default" @click="todoSettingShow=false">{{$L('取消')}}</Button>-->
<!--                <Button type="primary" :loading="todoSettingLoad > 0" @click="onTodo('submit')">{{$L('确定')}}</Button>-->
<!--            </div>-->
<!--        </Modal>-->

<!--        &lt;!&ndash;群设置&ndash;&gt;-->
<!--        <DrawerOverlay-->
<!--            v-model="groupInfoShow"-->
<!--            placement="right"-->
<!--            :size="400">-->
<!--            <DialogGroupInfo v-if="groupInfoShow" :dialogId="dialogId" @on-close="groupInfoShow=false"/>-->
<!--        </DrawerOverlay>-->

<!--        &lt;!&ndash;群转让&ndash;&gt;-->
<!--        <Modal-->
<!--            v-model="groupTransferShow"-->
<!--            :title="$L('转让群主身份')"-->
<!--            :mask-closable="false">-->
<!--            <Form :model="groupTransferData" label-width="auto" @submit.native.prevent>-->
<!--                <FormItem prop="userid" :label="$L('新的群主')">-->
<!--                    <UserSelect v-model="groupTransferData.userid" :disabledChoice="groupTransferData.disabledChoice" :multiple-max="1" :title="$L('选择新的群主')"/>-->
<!--                </FormItem>-->
<!--            </Form>-->
<!--            <div slot="footer" class="adaption">-->
<!--                <Button type="default" @click="groupTransferShow=false">{{$L('取消')}}</Button>-->
<!--                <Button type="primary" :loading="groupTransferLoad > 0" @click="onDialogMenu('transferConfirm')">{{$L('确定转让')}}</Button>-->
<!--            </div>-->
<!--        </Modal>-->

<!--        &lt;!&ndash;回复列表&ndash;&gt;-->
<!--        <DrawerOverlay-->
<!--            v-model="replyListShow"-->
<!--            placement="right"-->
<!--            class-name="dialog-wrapper-drawer-list"-->
<!--            :size="500">-->
<!--            <DialogWrapper-->
<!--                v-if="replyListShow"-->
<!--                :dialogId="dialogId"-->
<!--                :msgId="replyListId"-->
<!--                class="drawer-list">-->
<!--                <div slot="head" class="drawer-title">{{$L('回复消息')}}</div>-->
<!--            </DialogWrapper>-->
<!--        </DrawerOverlay>-->

<!--        &lt;!&ndash;回应详情&ndash;&gt;-->
<!--        <DrawerOverlay-->
<!--            v-model="respondShow"-->
<!--            placement="right"-->
<!--            :size="400">-->
<!--            <DialogRespond v-if="respondShow" :respond-data="respondData" @on-close="respondShow=false"/>-->
<!--        </DrawerOverlay>-->

<!--        &lt;!&ndash;待办完成&ndash;&gt;-->
<!--        <DrawerOverlay-->
<!--            v-model="todoViewShow"-->
<!--            placement="right"-->
<!--            class-name="dialog-wrapper-drawer-list"-->
<!--            :size="500">-->
<!--            <div class="dialog-wrapper drawer-list">-->
<!--                <div class="dialog-nav">-->
<!--                    <div class="drawer-title">{{$L('待办消息')}}</div>-->
<!--                </div>-->
<!--                <Scrollbar class-name="dialog-scroller">-->
<!--                    <DialogItem-->
<!--                        v-if="todoViewMsg"-->
<!--                        :source="todoViewMsg"-->
<!--                        @on-view-text="onViewText"-->
<!--                        @on-view-file="onViewFile"-->
<!--                        @on-down-file="onDownFile"-->
<!--                        @on-emoji="onEmoji"-->
<!--                        simpleView/>-->
<!--                    <Button class="original-button" icon="md-exit" type="text" :loading="todoViewPosLoad" @click="onPosTodo">{{ $L("回到原文") }}</Button>-->
<!--                </Scrollbar>-->
<!--                <div class="todo-button">-->
<!--                    <Button type="primary" size="large" icon="md-checkbox-outline" @click="onDoneTodo" :loading="todoViewLoad" long>{{ $L("完成") }}</Button>-->
<!--                </div>-->
<!--            </div>-->
<!--        </DrawerOverlay>-->

<!--        &lt;!&ndash;审批详情&ndash;&gt;-->
<!--        <DrawerOverlay v-model="approveDetailsShow" placement="right" :size="600">-->
<!--            <ApproveDetails v-if="approveDetailsShow" :data="approveDetails" style="height: 100%;border-radius: 10px;"></ApproveDetails>-->
<!--        </DrawerOverlay>-->

<!--        &lt;!&ndash; 群接龙 &ndash;&gt;-->
<!--        <DialogGroupWordChain/>-->

<!--        &lt;!&ndash; 群投票 &ndash;&gt;-->
<!--        <DialogGroupVote/>-->

<!--    </div>-->
<!--</template>-->

<!--<script>-->
<!--import {mapGetters, mapState} from "vuex";-->
<!--import DialogItem from "./DialogItem";-->
<!--import DialogUpload from "./DialogUpload";-->
<!--import DrawerOverlay from "../../../components/DrawerOverlay";-->
<!--import DialogGroupInfo from "./DialogGroupInfo";-->
<!--import DialogRespond from "./DialogRespond";-->
<!--import ChatInput from "./ChatInput";-->

<!--import VirtualList from 'vue-virtual-scroll-list-hi'-->
<!--import {Store} from "le5le-store";-->
<!--import ImgUpload from "../../../components/ImgUpload.vue";-->
<!--import {choiceEmojiOne} from "./ChatInput/one";-->

<!--import ApproveDetails from "../../../pages/manage/approve/details.vue";-->
<!--import UserSelect from "../../../components/UserSelect.vue";-->
<!--import UserAvatarTip from "../../../components/UserAvatar/tip.vue";-->
<!--import DialogGroupWordChain from "./DialogGroupWordChain";-->
<!--import DialogGroupVote from "./DialogGroupVote";-->
<!--import { Message,MessageText,Channel,WKSDK,ChannelTypeGroup,Setting,SyncOptions } from "wukongimjssdk";-->



<!--export default {-->
<!--    name: "DialogWrapper",-->
<!--    components: {-->
<!--        UserAvatarTip,-->
<!--        UserSelect,-->
<!--        ImgUpload,-->
<!--        DialogRespond,-->
<!--        DialogItem,-->
<!--        VirtualList,-->
<!--        ChatInput,-->
<!--        DialogGroupInfo,-->
<!--        DrawerOverlay,-->
<!--        DialogUpload,-->
<!--        ApproveDetails,-->
<!--        DialogGroupWordChain,-->
<!--        DialogGroupVote,-->
<!--    },-->

<!--    props: {-->
<!--        dialogId: {-->
<!--            type: String,-->
<!--            default: ''-->
<!--        },-->
<!--        msgId: {-->
<!--            type: Number,-->
<!--            default: 0-->
<!--        },-->
<!--        autoFocus: {-->
<!--            type: Boolean,-->
<!--            default: false-->
<!--        },-->
<!--        isMessenger: {-->
<!--            type: Boolean,-->
<!--            default: false-->
<!--        },-->
<!--        beforeBack: Function-->
<!--    },-->

<!--    data() {-->
<!--        return {-->
<!--            keeps: 25,-->
<!--            msgItem: DialogItem,-->
<!--            msgText: '',-->
<!--            msgNew: 0,-->
<!--            msgType: '',-->
<!--            loadIng: 0,-->

<!--            focusLazy: false,-->
<!--            focusTimer: null,-->

<!--            allMsgs: [],-->
<!--            tempMsgs: [],-->
<!--            tempId: $A.randNum(1000000000, 9999999999),-->
<!--            msgLoadIng: 0,-->
<!--            msgActiveIndex: -1,-->

<!--            pasteShow: false,-->
<!--            pasteFile: [],-->
<!--            pasteItem: [],-->

<!--            searchShow: false,-->
<!--            searchKey: '',-->
<!--            searchLoad: 0,-->
<!--            searchLocation: 1,-->
<!--            searchResult: [],-->

<!--            createGroupShow: false,-->
<!--            createGroupData: {},-->
<!--            createGroupLoad: 0,-->

<!--            modifyShow: false,-->
<!--            modifyData: {},-->
<!--            modifyLoad: 0,-->

<!--            forwardhow: false,-->
<!--            forwardData: [],-->
<!--            forwardLoad: 0,-->
<!--            forwardMessage: '',-->
<!--            forwardSource: true,-->

<!--            openId: 0,-->
<!--            dialogDrag: false,-->
<!--            groupInfoShow: false,-->

<!--            groupTransferShow: false,-->
<!--            groupTransferLoad: 0,-->
<!--            groupTransferData: {-->
<!--                userid: [],-->
<!--                disabledChoice: []-->
<!--            },-->

<!--            operateClient: {x: 0, y: 0},-->
<!--            operateVisible: false,-->
<!--            operatePreventScroll: 0,-->
<!--            operateCopys: [],-->
<!--            operateStyles: {},-->
<!--            operateItem: {},-->

<!--            recordState: '',-->
<!--            wrapperStart: null,-->

<!--            scrollOffset: 0,-->
<!--            scrollTail: 0,-->

<!--            preventMoreLoad: false,-->
<!--            preventToBottom: false,-->

<!--            replyListShow: false,-->
<!--            replyListId: 0,-->

<!--            respondShow: false,-->
<!--            respondData: {},-->

<!--            todoSettingShow: false,-->
<!--            todoSettingLoad: 0,-->
<!--            todoSettingData: {-->
<!--                type: 'all',-->
<!--                userids: [],-->
<!--                quick_value: [],-->
<!--            },-->

<!--            todoViewLoad: false,-->
<!--            todoViewPosLoad: false,-->
<!--            todoViewShow: false,-->
<!--            todoViewData: {},-->
<!--            todoViewMid: 0,-->
<!--            todoViewId: 0,-->

<!--            scrollDisabled: false,-->
<!--            scrollDirection: null,-->
<!--            scrollAction: 0,-->
<!--            scrollTmp: 0,-->
<!--            scrollIng: 0,-->

<!--            approveDetails: {id: 0},-->
<!--            approveDetailsShow: false,-->
<!--            approvaUserStatus: '',-->

<!--            observers: [],-->

<!--            unreadOne: 0,                       // 最早未读消息id-->
<!--            topPosLoad: false,                  // 置顶跳转加载中-->
<!--            positionLoad: 0,                    // 定位跳转加载中-->
<!--            positionShow: false,                // 定位跳转显示-->
<!--            renderMsgNum: 0,                    // 渲染消息数量-->
<!--            renderMsgSizes: new Map(),          // 渲染消息尺寸-->
<!--            msgActivityStatus: false,           // 消息准备完成-->
<!--            listPreparedStatus: false,          // 列表准备完成-->
<!--            selectedTextStatus: false,          // 是否选择文本-->
<!--            scrollToBottomAndRefresh: false,    // 滚动到底部重新获取消息-->
<!--            androidKeyboardVisible: false,      // Android键盘是否可见-->
<!--        }-->
<!--    },-->

<!--    mounted() {-->
<!--        this.initDataSource();-->
<!--        this.initIM(); //初始化聊天-->
<!--        //同步最近的会话-->
<!--        console.log("mounted&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;")-->
<!--        this.msgSubscribe = Store.subscribe('dialogMsgChange', this.onMsgChange);-->
<!--        document.addEventListener('selectionchange', this.onSelectionchange);-->
<!--    },-->

<!--    beforeDestroy() {-->
<!--        this.$store.dispatch('forgetInDialog', this._uid)-->
<!--        this.$store.dispatch('closeDialog', this.dialogId)-->
<!--        //-->
<!--        if (this.msgSubscribe) {-->
<!--            this.msgSubscribe.unsubscribe();-->
<!--            this.msgSubscribe = null;-->
<!--        }-->
<!--        this.observers.forEach(({observer}) => observer.disconnect())-->
<!--        this.observers = []-->
<!--        //-->
<!--        document.removeEventListener('selectionchange', this.onSelectionchange);-->
<!--    },-->

<!--    computed: {-->
<!--        ...mapState([-->
<!--            'systemConfig',-->
<!--            'userIsAdmin',-->
<!--            'taskId',-->
<!--            'dialogSearchMsgId',-->
<!--            'dialogMsgs',-->
<!--            'dialogTodos',-->
<!--            'dialogMsgTops',-->
<!--            'dialogMsgTransfer',-->
<!--            'cacheDialogs',-->
<!--            'wsOpenNum',-->
<!--            'touchBackInProgress',-->
<!--            'dialogIns',-->
<!--            'cacheUserBasic',-->
<!--            'fileLinks',-->
<!--            'cacheEmojis',-->

<!--            'readLoadNum',-->
<!--            'readTimeout',-->
<!--            'keyboardType',-->
<!--            'keyboardHeight',-->
<!--            'safeAreaBottom'-->
<!--        ]),-->

<!--        ...mapGetters(['isLoad']),-->

<!--        isReady() {-->
<!--          return this.dialogId !== ''-->
<!--            // return this.dialogId > 0 && this.dialogData.id > 0  //TODO 这里是关键,不等于空和-->
<!--        },-->

<!--        dialogData() {-->
<!--            console.log("mounted&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;dialogData")-->
<!--            //TODO 从缓存中提取聊天 这里改成从悟空im中提取-->
<!--            const data = this.cacheDialogs.find(({id}) => id == this.dialogId) || {}-->
<!--            //TODO 这里猜测是未读-->
<!--            if (this.unreadOne === 0) {-->
<!--                this.unreadOne = data.unread_one || 0-->
<!--            }-->
<!--            return data-->
<!--        },-->

<!--        dialogList() {-->
<!--          console.log("mounted&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;dialogList")-->
<!--            return this.cacheDialogs.filter(dialog => {-->
<!--                return !(dialog.name === undefined || dialog.dialog_delete === 1);-->
<!--            }).sort((a, b) => {-->
<!--                if (a.top_at || b.top_at) {-->
<!--                    return $A.Date(b.top_at) - $A.Date(a.top_at);-->
<!--                }-->
<!--                if (a.todo_num > 0 || b.todo_num > 0) {-->
<!--                    return b.todo_num - a.todo_num;-->
<!--                }-->
<!--                return $A.Date(b.last_at) - $A.Date(a.last_at);-->
<!--            });-->
<!--        },-->

<!--        dialogMsgList() {-->
<!--            if (!this.isReady) {-->
<!--                return [];-->
<!--            }-->
<!--            return this.dialogMsgs.filter(item => item.dialog_id == this.dialogId);-->
<!--        },-->

<!--        tempMsgList() {-->
<!--            if (!this.isReady) {-->
<!--                return [];-->
<!--            }-->
<!--            return this.tempMsgs.filter(item => item.dialog_id == this.dialogId);-->
<!--        },-->

<!--       async allMsgList() {-->
<!--          // console.log("mounted&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;allMsgList ")-->
<!--          // return new Promise((resolve, reject) => {-->
<!--          //   this.$store.dispatch("call", {-->
<!--          //     url: 'channel/messagesync',-->
<!--          //     method: 'post',-->
<!--          //     data: {-->
<!--          //       login_uid: this.userId + '',-->
<!--          //       channel_id: this.dialogId,-->
<!--          //       channel_type: 2,-->
<!--          //       start_message_seq: 0,-->
<!--          //       end_message_seq: 0,-->
<!--          //       pull_mode: 1,-->
<!--          //       limit: 50  //固定每次取50条-->
<!--          //     }-->
<!--          //   }).then(({data}) => {-->
<!--          //     console.log("初始化进来的...进行请求&#45;&#45;&#45;&#45; then&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;", data);-->
<!--          //     console.log(data.messages)-->
<!--          //     resolve(data.messages);-->
<!--          //     //在这里返回信息-->
<!--          //   }).catch(({msg}) => {-->
<!--          //     console.log("初始化进来的...进行请求&#45;&#45;&#45;&#45; catch&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;", msg);-->
<!--          //     reject([]);-->
<!--          //   }).finally(_ => {-->
<!--          //     console.log("初始化进来的...进行请求&#45;&#45;&#45;&#45; finally&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;");-->
<!--          //     resolve([]);-->
<!--          //   });-->
<!--          // })-->
<!--           const array = [];-->
<!--           array.push(...this.dialogMsgList.filter(item => this.msgFilter(item)));-->
<!--           //这个地方就不想打开了-->

<!--           // if (this.msgId > 0) {-->
<!--           //     const msgItem = this.dialogMsgs.find(item => item.id == this.msgId)-->
<!--           //     if (msgItem) {-->
<!--           //         array.unshift(msgItem)-->
<!--           //     }-->
<!--           // }-->
<!--           if (this.tempMsgList.length > 0) {-->
<!--               const ids = array.map(({id}) => id)-->
<!--               const tempMsgList = this.tempMsgList.filter(item => !ids.includes(item.id) && this.msgFilter(item))-->
<!--               if (tempMsgList.length > 0) {-->
<!--                   array.push(...tempMsgList)-->
<!--               }-->
<!--           }-->
<!--           return array.sort((a, b) => {-->
<!--               return a.id - b.id;-->
<!--           })-->
<!--       },-->
<!--        //获取所有信息-->


<!--        loadMsg() {-->
<!--             console.log("mounted&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;loadMsg ")-->
<!--            return this.isLoad(`msg::${this.dialogId}-${this.msgId}-${this.msgType}`)-->
<!--        },-->

<!--        prevId() {-->
<!--            if (this.allMsgs.length > 0) {-->
<!--                return $A.runNum(this.allMsgs[0].prev_id)-->
<!--            }-->
<!--            return 0-->
<!--        },-->

<!--        peopleNum() {-->
<!--            return this.dialogData.type === 'group' ? $A.runNum(this.dialogData.people) : 0;-->
<!--        },-->

<!--        pasteTitle() {-->
<!--            const {pasteItem} = this;-->
<!--            let hasImage = pasteItem.find(({type}) => type == 'image')-->
<!--            let hasFile = pasteItem.find(({type}) => type != 'image')-->
<!--            if (hasImage && hasFile) {-->
<!--                return '发送文件/图片'-->
<!--            } else if (hasImage) {-->
<!--                return '发送图片'-->
<!--            }-->
<!--            return '发送文件'-->
<!--        },-->

<!--        msgTags({dialogData}) {-->
<!--            const array = [-->
<!--                {type: '', label: '消息'},-->
<!--            ];-->
<!--            if (dialogData.has_tag) {-->
<!--                array.push({type: 'tag', label: '标注'})-->
<!--            }-->
<!--            if (dialogData.has_todo) {-->
<!--                array.push({type: 'todo', label: '事项'})-->
<!--            }-->
<!--            if (dialogData.has_image) {-->
<!--                array.push({type: 'image', label: '图片'})-->
<!--            }-->
<!--            if (dialogData.has_file) {-->
<!--                array.push({type: 'file', label: '文件'})-->
<!--            }-->
<!--            if (dialogData.has_link) {-->
<!--                array.push({type: 'link', label: '链接'})-->
<!--            }-->
<!--            if (dialogData.group_type === 'project') {-->
<!--                array.push({type: 'project', label: '打开项目'})-->
<!--            }-->
<!--            if (dialogData.group_type === 'task') {-->
<!--                array.push({type: 'task', label: '打开任务'})-->
<!--            }-->
<!--            if (dialogData.group_type === 'okr') {-->
<!--                array.push({type: 'okr', label: '打开OKR'})-->
<!--            }-->
<!--            return array-->
<!--        },-->

<!--        topMsg() {-->
<!--            return this.dialogData.top_msg_id && this.dialogMsgTops.find(({id}) => id == this.dialogData.top_msg_id)-->
<!--        },-->

<!--        quickMsgs() {-->
<!--            return this.dialogData.quick_msgs || []-->
<!--        },-->

<!--        todoList() {-->
<!--            if (!this.dialogData.todo_num) {-->
<!--                return []-->
<!--            }-->
<!--            return this.dialogTodos.filter(item => !item.done_at && item.dialog_id == this.dialogId).sort((a, b) => {-->
<!--                return b.id - a.id;-->
<!--            });-->
<!--        },-->

<!--        isDefaultSize() {-->
<!--            return this.windowScrollY === 0 && !this.androidKeyboardVisible-->
<!--        },-->

<!--        quickShow() {-->
<!--            return this.quickMsgs.length > 0 && this.isDefaultSize && this.quoteId === 0-->
<!--        },-->

<!--        todoShow() {-->
<!--            return this.todoList.length > 0 && this.isDefaultSize && this.quoteId === 0-->
<!--        },-->

<!--        tagShow() {-->
<!--            return this.msgTags.length > 1 && this.isDefaultSize && !this.searchShow-->
<!--        },-->

<!--        topShow() {-->
<!--            return this.topMsg && this.isDefaultSize && !this.searchShow && this.msgType === ''-->
<!--        },-->

<!--        wrapperClass() {-->
<!--            if (['ready', 'ing'].includes(this.recordState)) {-->
<!--                return 'record-ready'-->
<!--            }-->
<!--            return null-->
<!--        },-->

<!--        navClass() {-->
<!--            return {-->
<!--                'completed': $A.dialogCompleted(this.dialogData),-->
<!--                'tagged': this.tagShow-->
<!--            }-->
<!--        },-->

<!--        pasteClass() {-->
<!--            if (this.pasteItem.find(({type}) => type !== 'image')) {-->
<!--                return ['multiple'];-->
<!--            }-->
<!--            return [];-->
<!--        },-->

<!--        footerPaddingBottom({keyboardType, keyboardHeight, safeAreaBottom, windowScrollY, isMessenger, focusLazy}) {-->
<!--            if (windowScrollY === 0-->
<!--                && focusLazy-->
<!--                && isMessenger-->
<!--                && keyboardType === "show"-->
<!--                && keyboardHeight > 0-->
<!--                && keyboardHeight < 120) {-->
<!--                return keyboardHeight + safeAreaBottom;-->
<!--            }-->
<!--            return 0;-->
<!--        },-->

<!--        msgUnreadOnly() {-->
<!--            let num = 0;-->
<!--            this.cacheDialogs.some(dialog => {-->
<!--                num += $A.getDialogNum(dialog);-->
<!--            })-->
<!--            if (num <= 0) {-->
<!--                return '';-->
<!--            }-->
<!--            if (num > 999) {-->
<!--                num = "999+"-->
<!--            }-->
<!--            return String(num);-->
<!--        },-->

<!--        isMyDialog() {-->
<!--            const {dialogData, userId} = this;-->
<!--            return dialogData.dialog_user && dialogData.dialog_user.userid == userId-->
<!--        },-->

<!--        isManageBot() {-->
<!--            const {dialogData, userId, userIsAdmin} = this;-->
<!--            if (!dialogData.bot) {-->
<!--                return false-->
<!--            }-->
<!--            if (dialogData.bot == userId) {-->
<!--                return true-->
<!--            }-->
<!--            return dialogData.dialog_user && dialogData.dialog_user.userid == dialogData.bot && userIsAdmin-->
<!--        },-->

<!--        isMute() {-->
<!--            if (this.dialogData.group_type === 'all') {-->
<!--                if (this.dialogData.all_group_mute === 'all') {-->
<!--                    return true-->
<!--                } else if (this.dialogData.all_group_mute === 'user') {-->
<!--                    if (!this.userIsAdmin) {-->
<!--                        return true-->
<!--                    }-->
<!--                }-->
<!--            }-->
<!--            return false-->
<!--        },-->

<!--        quoteId() {-->
<!--            if (this.msgId > 0) {-->
<!--                return this.msgId-->
<!--            }-->
<!--            return this.dialogData.extra_quote_id || 0-->
<!--        },-->

<!--        quoteUpdate() {-->
<!--            return this.dialogData.extra_quote_type === 'update'-->
<!--        },-->

<!--        quoteData() {-->
<!--            return this.quoteId ? this.allMsgs.find(({id}) => id === this.quoteId) : null-->
<!--        },-->

<!--        todoViewMsg() {-->
<!--            if (this.todoViewMid) {-->
<!--                const msg = this.allMsgs.find(item => item.id == this.todoViewMid)-->
<!--                if (msg) {-->
<!--                    return msg-->
<!--                }-->
<!--                if (this.todoViewData.id === this.todoViewMid) {-->
<!--                    return this.todoViewData-->
<!--                }-->
<!--            }-->
<!--            return null-->
<!--        },-->

<!--        positionMsg({msgNew, dialogData, allMsgs}) {-->
<!--            const {unread, unread_one, mention, mention_ids} = dialogData-->
<!--            const not = unread - msgNew-->
<!--            const array = []-->
<!--            if (unread_one) {-->
<!--                array.push({-->
<!--                    type: 'unread',-->
<!--                    label: this.$L(`未读消息${not}条`),-->
<!--                    msg_id: unread_one-->
<!--                })-->
<!--            }-->
<!--            if (mention_ids && mention_ids.length > 0) {-->
<!--                array.push(...mention_ids.map(msg_id => {-->
<!--                    return {-->
<!--                        type: 'mention',-->
<!--                        label: this.$L(`@我的消息`),-->
<!--                        msg_id-->
<!--                    }-->
<!--                }))-->
<!--            }-->
<!--            if (not <= 0 || array.length === 0 || allMsgs.length === 0) {-->
<!--                return null-->
<!--            }-->
<!--            return array.find(item => item.type === (mention === 0 ? 'unread' : 'mention')) || array[0]-->
<!--        },-->

<!--        operateEmojis({cacheEmojis}) {-->
<!--            const list = cacheEmojis.slice(0, 3)-->
<!--            Object.values(['👌', '👍', '😂', '🎉', '❤️', '🥳️', '🥰', '😥', '😭']).some(item => {-->
<!--                if (!list.includes(item)) {-->
<!--                    list.push(item)-->
<!--                }-->
<!--            })-->
<!--            return list-->
<!--        },-->

<!--        maxSize({systemConfig}) {-->
<!--            if(systemConfig?.file_upload_limit){-->
<!--                return systemConfig.file_upload_limit * 1024-->
<!--            }-->
<!--            return 1024000-->
<!--        },-->

<!--        readEnabled({msgActivityStatus, listPreparedStatus}) {-->
<!--            return msgActivityStatus === 0 && listPreparedStatus-->
<!--        },-->
<!--    },-->

<!--    watch: {-->
<!--        '$route': {-->
<!--            handler(data) {-->
<!--                const { name, params } = data || {}-->
<!--                if (name != 'manage-messenger') {-->
<!--                    return-->
<!--                }-->
<!--                if (params.dialog_id && params.open && ['word-chain', 'vote'].includes(params.open)) {-->
<!--                    this.$nextTick(_ => {-->
<!--                        this.$store.state[params.open == 'word-chain' ? 'dialogDroupWordChain' : 'dialogGroupVote'] = {-->
<!--                            type: 'create',-->
<!--                            dialog_id: params.dialog_id-->
<!--                        }-->
<!--                        params.open = "";-->
<!--                    })-->
<!--                }-->
<!--            },-->
<!--            immediate: true-->
<!--        },-->
<!--        dialogId: {-->
<!--            handler(dialog_id, old_id) {-->
<!--                if (dialog_id) {-->
<!--                    this.msgNew = 0-->
<!--                    this.msgType = ''-->
<!--                    this.unreadOne = 0-->
<!--                    this.searchShow = false-->
<!--                    this.positionShow = false-->
<!--                    this.listPreparedStatus = false-->
<!--                    this.scrollToBottomAndRefresh = false-->
<!--                    this.renderMsgNum = Math.min(this.keeps, Math.max(this.allMsgList.length, 1))-->
<!--                    this.renderMsgSizes.clear()-->
<!--                    console.log('mounted&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;dialogId handler 请求信息列表');-->
<!--                    this.allMsgs = this.allMsgList-->
<!--                    console.log('mounted&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;dialogId handler 请求信息列表 allMsgList',this.allMsgList);-->
<!--                    console.log('mounted&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;dialogId handler 请求信息列表 allMsgs',this.allMsgs);-->
<!--                     //TODO 不从缓存走，所以这里打算暂时去掉-->
<!--                    // const tmpMsgA = this.allMsgList.map(({id, msg, emoji}) => {-->
<!--                    //     return {id, msg, emoji}-->
<!--                    // })-->
<!--                    console.log('mounted&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;this.msgId',this.msgId);-->
<!--                    console.log('mounted&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;this.msg_type',this.msg_type);-->

<!--                  this.getMsgs({-->
<!--                        dialog_id,-->
<!--                        msg_id: this.msgId,-->
<!--                        msg_type: this.msgType,-->
<!--                        save_before: _ => this.onMarkOffset(false)-->
<!--                    }).then((data) => {-->
<!--                        console.log('mounted-&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;dialogId handle then22 ',data);-->
<!--                        this.openId = dialog_id-->
<!--                        this.listPreparedStatus = true-->
<!--                        console.log('mounted-&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;dialogId handle then22 ',data);-->
<!--                        this.allMsgs = data; //TODO 这里赋值-->
<!--                        //-->
<!--                        // const tmpMsgB = this.allMsgList.map(({id, msg, emoji}) => {-->
<!--                        //     return {id, msg, emoji}-->
<!--                        // })-->
<!--                        if (JSON.stringify(tmpMsgA) != JSON.stringify(tmpMsgB)) {-->
<!--                            this.renderMsgNum = Math.min(this.keeps, Math.max(this.allMsgList.length, 1))-->
<!--                        }-->
<!--                        //-->
<!--                        setTimeout(_ => {-->
<!--                            this.onSearchMsgId()-->
<!--                            this.positionShow = this.readTimeout === null-->
<!--                        }, 100)-->
<!--                    }).catch(_ => {-->
<!--                      console.log("请求数据异常！！！")-->
<!--                    });-->
<!--                    //-->
<!--                    this.$store.dispatch('saveInDialog', {-->
<!--                        uid: this._uid,-->
<!--                        dialog_id,-->
<!--                    })-->
<!--                    //-->
<!--                    if (this.autoFocus) {-->
<!--                        this.inputFocus()-->
<!--                    }-->
<!--                }-->
<!--                this.$store.dispatch('closeDialog', old_id)-->
<!--                this.getUserApproveStatus();-->
<!--            },-->
<!--            immediate: true-->
<!--        },-->

<!--        loadMsg: {-->
<!--            handler(load) {-->
<!--                if (load) {-->
<!--                    this.loadIng++-->
<!--                } else {-->
<!--                    setTimeout(_ => {-->
<!--                        this.loadIng&#45;&#45;-->
<!--                    }, 300)-->
<!--                }-->
<!--            },-->
<!--            immediate: true-->
<!--        },-->

<!--        isReady: {-->
<!--            handler(ready) {-->
<!--                console.log("mounted&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;isReady ")-->
<!--                if (!ready) {-->
<!--                    return-->
<!--                }-->
<!--                this.$nextTick(_ => {-->
<!--                    if (this.$refs.msgs) {-->
<!--                        if (!this.observers.find(({key}) => key === 'scroller')) {-->
<!--                            const scrollerObserver = new ResizeObserver(this.onResizeEvent)-->
<!--                            scrollerObserver.observe(this.$refs.msgs);-->
<!--                            this.observers.push({key: 'scroller', observer: scrollerObserver})-->
<!--                        }-->
<!--                    }-->
<!--                    if (this.$refs.footer) {-->
<!--                        if (!this.observers.find(({key}) => key === 'footer')) {-->
<!--                            const footerObserver = new ResizeObserver(this.onResizeEvent)-->
<!--                            footerObserver.observe(this.$refs.footer);-->
<!--                            this.observers.push({key: 'footer', observer: footerObserver})-->
<!--                        }-->
<!--                    }-->
<!--                })-->
<!--            },-->
<!--            immediate: true-->
<!--        },-->

<!--        msgType() {-->
<!--            this.getMsgs({-->
<!--                dialog_id: this.dialogId,-->
<!--                msg_id: this.msgId,-->
<!--                msg_type: this.msgType,-->
<!--                clear_before: true-->
<!--            }).catch(_ => {})-->
<!--        },-->

<!--        searchKey(key) {-->
<!--            if (!key) {-->
<!--                return-->
<!--            }-->
<!--            this.searchLoad++-->
<!--            setTimeout(_ => {-->
<!--                if (this.searchKey === key) {-->
<!--                    this.searchLoad++-->
<!--                    this.searchResult = []-->
<!--                    this.searchLocation = 0-->
<!--                    this.$store.dispatch("call", {-->
<!--                        url: 'dialog/msg/search',-->
<!--                        data: {-->
<!--                            dialog_id: this.dialogId,-->
<!--                            key,-->
<!--                        },-->
<!--                    }).then(({data}) => {-->
<!--                        if (this.searchKey !== key) {-->
<!--                            return-->
<!--                        }-->
<!--                        this.searchResult = data.data-->
<!--                        this.searchLocation = this.searchResult.length-->
<!--                    }).finally(_ => {-->
<!--                        this.searchLoad&#45;&#45;-->
<!--                    });-->
<!--                }-->
<!--                this.searchLoad&#45;&#45;-->
<!--            }, 600)-->
<!--        },-->

<!--        searchLocation(position) {-->
<!--            if (position === 0) {-->
<!--                return-->
<!--            }-->
<!--            const id = this.searchResult[position - 1]-->
<!--            if (id) {-->
<!--                this.onPositionId(id)-->
<!--            }-->
<!--        },-->

<!--        dialogSearchMsgId() {-->
<!--            this.onSearchMsgId();-->
<!--        },-->

<!--        dialogMsgTransfer: {-->
<!--            handler({time, msgFile, msgRecord, msgText, dialogId}) {-->
<!--                if (time > $A.Time() && dialogId == this.dialogId) {-->
<!--                    this.$store.state.dialogMsgTransfer.time = 0;-->
<!--                    this.$nextTick(() => {-->
<!--                        if ($A.isArray(msgFile) && msgFile.length > 0) {-->
<!--                            this.sendFileMsg(msgFile);-->
<!--                        } else if ($A.isJson(msgRecord) && msgRecord.duration > 0) {-->
<!--                            this.sendRecord(msgRecord);-->
<!--                        } else if (msgText) {-->
<!--                            console.log("sendMsg&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;1")-->
<!--                            this.sendMsg(msgText);-->
<!--                        }-->
<!--                    });-->
<!--                }-->
<!--            },-->
<!--            immediate: true-->
<!--        },-->

<!--        wsOpenNum(num) {-->
<!--            if (num <= 1) {-->
<!--                return-->
<!--            }-->
<!--            // 判断是否最后一条消息可见才重新获取消息-->
<!--            const lastMsg = this.allMsgs[this.allMsgs.length - 1]-->
<!--            const lastEl = $A(this.$refs.scroller.$el).find(`[data-id="${lastMsg.id}"]`)-->
<!--            if (lastEl.length === 0) {-->
<!--                this.scrollToBottomAndRefresh = true-->
<!--                return;-->
<!--            }-->
<!--            // 开始请求重新获取消息-->
<!--            this.onReGetMsg()-->
<!--        },-->

<!--        allMsgList(newList, oldList) {-->
<!--            if (JSON.stringify(newList) == JSON.stringify(oldList)) {-->
<!--                return;-->
<!--            }-->
<!--            const {tail} = this.scrollInfo();-->
<!--            if ($A.isIos() && newList.length !== oldList.length) {-->
<!--                // 隐藏区域，让iOS断触-->
<!--                const scrollEl = this.$refs.scroller.$el-->
<!--                scrollEl.style.visibility = 'hidden'-->
<!--                this.allMsgs = newList;-->
<!--                this.$nextTick(_ => {-->
<!--                    scrollEl.style.visibility = 'visible'-->
<!--                })-->
<!--            } else {-->
<!--                this.allMsgs = newList;-->
<!--            }-->
<!--            //-->
<!--            if (!this.windowActive || (tail > 55 && oldList.length > 0)) {-->
<!--                const lastId = oldList[oldList.length - 1] ? oldList[oldList.length - 1].id : 0-->
<!--                const tmpList = newList.filter(item => item.id && item.id > lastId && !item.read_at)-->
<!--                this.msgNew += tmpList.length-->
<!--            } else {-->
<!--                !this.preventToBottom && this.$nextTick(this.onToBottom)-->
<!--            }-->
<!--        },-->

<!--        windowScrollY(val) {-->
<!--            if ($A.isIos() && !this.$slots.head) {-->
<!--                this.$refs.nav.style.marginTop = `${val}px`-->
<!--            }-->
<!--        },-->

<!--        windowActive(active) {-->
<!--            if (active && this.autoFocus) {-->
<!--                const lastDialog = $A.last(this.dialogIns)-->
<!--                if (lastDialog && lastDialog.uid === this._uid) {-->
<!--                    this.inputFocus()-->
<!--                }-->
<!--            }-->
<!--        },-->

<!--        windowHeight() {-->
<!--            this.androidKeyboardVisible = $A.isAndroid() && $A.eeuiAppKeyboardStatus()-->
<!--            requestAnimationFrame(this.$refs.input.updateTools)-->
<!--        },-->

<!--        dialogDrag(val) {-->
<!--            if (val) {-->
<!--                this.operateVisible = false;-->
<!--            }-->
<!--        },-->

<!--        msgActiveIndex(index) {-->
<!--            if (index > -1) {-->
<!--                setTimeout(_ => this.msgActiveIndex = -1, 800)-->
<!--            }-->
<!--        },-->

<!--        footerPaddingBottom(val) {-->
<!--            this.$refs.footer.style.paddingBottom = `${val}px`;-->
<!--            requestAnimationFrame(_ => {-->
<!--                this.$refs.input.updateTools()-->
<!--                this.onFooterResize()-->
<!--            })-->
<!--        },-->

<!--        readLoadNum() {-->
<!--            this.positionShow = true-->
<!--        },-->
<!--    },-->

<!--    methods: {-->
<!--      /**-->
<!--       * 初始化im-->
<!--       */-->
<!--      async initIM() {-->

<!--            WKSDK.shared().chatManager.removeMessageStatusListener(this.handleMessage)-->
<!--            WKSDK.shared().chatManager.addMessageStatusListener(this.handleMessage)-->

<!--            const channelId = this.dialogId;-->
<!--            console.log("sendtext2 channelId:"+channelId);-->
<!--            const channelTypeGroup = ChannelTypeGroup;-->
<!--            console.log("sendtext2 channelTypeGroup:"+channelTypeGroup);-->
<!--            const channel = new Channel(channelId, channelTypeGroup);-->

<!--            // const opt =  new SyncOptions();-->
<!--            const messages = await WKSDK.shared().chatManager.syncMessages(channel,{-->
<!--              limit: 15, startMessageSeq: 0, endMessageSeq: 0,-->
<!--              pullMode: 1});-->
<!--            console.log('conversation&#45;&#45;&#45;&#45;&#45;&#45;messages&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;'+messages);-->
<!--            // if(messages){-->
<!--            //   //处理数据-->
<!--            //   for (let i = 0; i < messages.length; i++) {-->
<!--            //     var msg = messages[i];-->
<!--            //     console.log('conversation&#45;&#45;&#45;&#45;&#45;&#45;msg&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;'+msg);-->
<!--            //     var data = this.getMessageText(msg);-->
<!--            //     console.log('conversation&#45;&#45;&#45;&#45;&#45;&#45;getMessageText&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;'+data);-->
<!--            //     console.log(data);-->
<!--            //   }-->
<!--            // }-->

<!--            // const conversations2 = await WKSDK.shared().conversationManager.sync({})-->
<!--            // console.log('conversation&#45;&#45;&#45;&#45;&#45;&#45;同步最近会话列表&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;')-->
<!--            // console.log('conversations&#45;&#45;&#45;&#45;this.channel &#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;'+channel)-->
<!--            // const conversation = WKSDK.shared().conversationManager.findConversation(channel)-->
<!--            // console.log('conversation&#45;&#45;&#45;&#45;&#45;&#45;监听最近会话&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;')-->
<!--            // console.log(conversation)-->
<!--            // 订阅者列表-->
<!--            const subscribers = WKSDK.shared().channelManager.getSubscribes(channel);-->
<!--            console.log('订阅者subscribers&#45;&#45;&#45;&#45;&#45;&#45;subscribers&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;');-->
<!--            console.log(subscribers)-->
<!--      },-->

<!--      base64ToUtf8(base64String) {-->
<!--        // 使用 atob 函数解码base64字符串-->
<!--        const decodedString = atob(base64String);-->
<!--        // 将解码后的字符串转换为UTF-8格式-->
<!--        let utf8String = '';-->
<!--        for (let i = 0; i < decodedString.length; i++) {-->
<!--          utf8String += String.fromCharCode(decodedString.charCodeAt(i));-->
<!--        }-->
<!--        return utf8String;-->
<!--      },-->

<!--      //获取消息正文-->
<!--      getMessageText(m) {-->
<!--        console.log('messageContent-&#45;&#45;&#45;&#45;&ndash;&gt;payload',m.payload);-->
<!--        const contentObj = JSON.parse(this.base64ToUtf8(m.payload))-->
<!--        console.log('messageContent-&#45;&#45;&#45;&#45;&ndash;&gt;contentObj',contentObj);-->
<!--        // let contentType = 0;-->
<!--        // if (contentObj) {-->
<!--        //     contentType = contentObj.type;-->
<!--        // }-->
<!--        // console.log('messageContent-&#45;&#45;&#45;&#45;&ndash;&gt;contentType',contentType);-->
<!--        // // const messageContent = WKSDK.shared().getMessageContent(contentType);-->
<!--        // console.log('messageContent-&#45;&#45;&#45;&#45;&ndash;&gt;messageContent',messageContent);-->
<!--        return contentObj.content-->
<!--        // const decodeBuffer = Buffer.from(m.payload,'base64');-->
<!--        // console.log('messageContent-&#45;&#45;&#45;&#45;&ndash;&gt;decodeBuffer',decodeBuffer);-->
<!--        // const contentObj = JSON.parse(decodeBuffer.toString('utf8'));-->
<!--        // console.log('messageContent-&#45;&#45;&#45;&#45;&ndash;&gt;2222222222222222222',m);-->
<!--        // let contentType = 0;-->
<!--        // if (contentObj) {-->
<!--        //     contentType = contentObj.type;-->
<!--        // }-->
<!--        // console.log('messageContent-&#45;&#45;&#45;&#45;&ndash;&gt;33333333333333333333',m);-->
<!--        // const messageContent = WKSDK.shared().getMessageContent(contentType);-->
<!--        // if (contentObj) {-->
<!--        //   console.log('messageContent-&#45;&#45;&#45;&#45;&ndash;&gt;1231313',m);-->
<!--        //     messageContent.decode(this.stringToUint8Array(JSON.stringify(contentObj)))-->
<!--        // }-->
<!--        // console.log('messageContent-&#45;&#45;&#45;&#45;&ndash;&gt;4444444444444444444444',m);-->
<!--        // console.log('messageContent-&#45;&#45;&#45;&#45;&ndash;&gt;',messageContent)-->
<!--        // return messageContent;-->

<!--        // if (m instanceof Message) {-->
<!--        //   const streams = m.streams;-->
<!--        //   let text = "";-->
<!--        //   if (m.content instanceof MessageText) {-->
<!--        //     const messageText = m.content;-->
<!--        //     text = messageText.text || "";-->
<!--        //   }-->
<!--        //   if (streams && streams.length > 0) {-->
<!--        //     for (const stream of streams) {-->
<!--        //       if (stream.content instanceof MessageText) {-->
<!--        //         const messageText = stream.content;-->
<!--        //         text = text + (messageText.text || "");-->
<!--        //       }-->
<!--        //     }-->
<!--        //   }-->
<!--        //   return text;-->
<!--        // }-->
<!--        // return "未知消息";-->
<!--      },-->

<!--      //onUnmounted-->
<!--      //初始化数据源-->
<!--       initDataSource(){-->
<!--         const syncMessagesCallback = async (channel, opts) => {-->
<!--           console.log("&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;channel里11111111111111111111111111111")-->
<!--           console.log("&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;channel",channel);-->
<!--           this.$store.dispatch("call", {-->
<!--             url: 'channel/messagesync',-->
<!--             method: 'post',-->
<!--             data: {-->
<!--               login_uid: this.userId+'',-->
<!--               channel_id: this.dialogId,-->
<!--               channel_type: 2,-->
<!--               start_message_seq: 0,-->
<!--               end_message_seq: 0,-->
<!--               pull_mode: 1,-->
<!--               limit: 50  //固定每次取50条-->
<!--             }-->
<!--           }).then(({data}) => {-->
<!--             console.log(data)-->
<!--             var messageList = data.messages-->
<!--             console.log(messageList)-->
<!--             for (let i = 0; i < messageList.length; i++) {-->
<!--               var msg = messageList[i];-->
<!--               console.log(msg);-->
<!--               var data = this.getMessageText(msg)-->
<!--               console.warn('conversation&#45;&#45;&#45;&#45;&#45;&#45;getMessageText&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;结束 &#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;'+data);-->
<!--             }-->
<!--             return messageList-->
<!--             //在这里返回信息-->
<!--           }).catch(({msg}) => {-->
<!--             console.error("&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;12121请求返回"+msg)-->
<!--           }).finally(_ => {-->
<!--             console.error("&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;12121请求返回")-->
<!--           });-->
<!--         }-->
<!--         WKSDK.shared().config.provider.syncMessagesCallback= syncMessagesCallback;-->

<!--         //群频道 订阅者列表-->
<!--         const subscribersCallback = async(channel,version) => {-->
<!--           console.log('subscribers&#45;&#45;&#45;&#45;&#45;&#45;subscribersCallback&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;begin&#45;&#45;')-->
<!--           const subscribers = WKSDK.shared().channelManager.getSubscribes(channel);-->
<!--           console.log('subscribers&#45;&#45;&#45;&#45;&#45;&#45;subscribersCallback&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;end&#45;&#45;&#45;&#45;')-->
<!--           console.log(subscribers)-->
<!--           return  subscribers;-->
<!--         }-->

<!--         WKSDK.shared().config.provider.syncSubscribersCallback = subscribersCallback;-->

<!--        //同步自己业务端的频道消息列表-->
<!--        //-->
<!--        // WKSDK.shared().config.provider.syncMessagesCallback((channel, opts)=>{-->
<!--        //-->
<!--        // })-->
<!--        // const provider = WKSDK.shared().config.provider;-->
<!--        // provider.syncMessagesCallback = async (channel, opts) => {-->
<!--        //   console.log("&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;请求到这里")-->
<!--        //   this.$store.dispatch("call", {-->
<!--        //     url: 'channel/messagesync',-->
<!--        //     method: 'post',-->
<!--        //     data: {-->
<!--        //       channelId:this.dialogId-->
<!--        //     }-->
<!--        //   }).then(({data}) => {-->
<!--        //     console.log("&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;请求返回"+data)-->
<!--        //   }).catch(({msg}) => {-->
<!--        //     console.log("&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;请求异常返回"+data)-->
<!--        //   }).finally(_ => {-->
<!--        //     console.log("&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;请求最后返回"+data)-->
<!--        //   });-->
<!--        //   // return resultMessages;-->
<!--        // }-->

<!--        // WKSDK.shared().config.provider.syncMessagesCallback(async (channel, opts) => {-->
<!--          //发起请求或者频道信息-->
<!--          // const resultMessages = await APIClient.shared.syncMessages(channel, opts);-->
<!--          // return resultMessages;-->
<!--        // })-->
<!--      },-->
<!--        /**-->
<!--         * 发送消息-->
<!--         * @param text-->
<!--         * @param type-->
<!--         */-->
<!--        sendMsg(text, type) {-->
<!--            console.log("发送的数据格式text|type"+text+"|"+type)-->
<!--            let textBody,-->
<!--                textType = "text",-->
<!--                silence = "no",-->
<!--                emptied = false;-->
<!--            if (typeof text === "string" && text) {-->
<!--                textBody = text;-->
<!--            } else {-->
<!--                textBody = this.msgText;-->
<!--                emptied = true;-->
<!--            }-->
<!--            if (type === "md") {-->
<!--                textBody = this.$refs.input.getText()-->
<!--                textType = "md"-->
<!--            } else if (type === "silence") {-->
<!--                silence = "yes"-->
<!--            }-->
<!--            if (textBody == '') {-->
<!--                this.inputFocus();-->
<!--                return;-->
<!--            }-->
<!--            if (textType === "text") {-->
<!--                textBody = textBody-->
<!--                    .replace(/<\/span> <\/p>$/, "</span></p>")-->
<!--                    .replace(/(<span\s+class="mention"(.*?)>.*?<\/span>.*?<\/span>.*?<\/span>)(\x20)?/, "$1 ")-->
<!--            }-->
<!--            //-->
<!--            if (this.quoteUpdate) {-->
<!--                // 修改-->
<!--                if (textType === "text") {-->
<!--                    textBody = textBody.replace(new RegExp(`src=(["'])${$A.apiUrl('../')}`, "g"), "src=$1{{RemoteURL}}")-->
<!--                }-->
<!--                const update_id = this.quoteId-->
<!--                this.$store.dispatch("setLoad", {-->
<!--                    key: `msg-${update_id}`,-->
<!--                    delay: 600-->
<!--                })-->
<!--                this.cancelQuote()-->
<!--                this.onActive()-->

<!--              console.log("sendtext2- 执行sendMessage1111111111111111-&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;");-->
<!--              console.log("sendtext2"+textBody)-->
<!--              const msgContent = new MessageText(textBody);-->
<!--              const setting = Setting.fromUint8(0);-->
<!--              const channelId = tempMsg.dialog_id;-->
<!--              console.log("sendtext2 channelId:"+channelId);-->
<!--              const channelTypeGroup = ChannelTypeGroup;-->
<!--              const channel = new Channel(channelId, channelTypeGroup);-->
<!--              WKSDK.shared().chatManager.send(msgContent, channel,setting);-->
<!--              console.log("sendtext2- 执行sendMessage结束-&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;");-->


<!--                // this.$store.dispatch("call", {-->
<!--                //     url: 'dialog/msg/sendtext',-->
<!--                //     data: {-->
<!--                //         dialog_id: this.dialogId,-->
<!--                //         update_id,-->
<!--                //         text: textBody,-->
<!--                //         text_type: textType,-->
<!--                //         silence,-->
<!--                //     },-->
<!--                //     method: 'post',-->
<!--                //     complete: _ => this.$store.dispatch("cancelLoad", `msg-${update_id}`)-->
<!--                // }).then(({data}) => {-->
<!--                //     this.sendSuccess(data)-->
<!--                //     this.onPositionId(update_id)-->
<!--                // }).catch(({msg}) => {-->
<!--                //     $A.modalError(msg)-->
<!--                // });-->
<!--            } else {-->
<!--                // 发送-->
<!--                const typeLoad = $A.stringLength(textBody.replace(/<img[^>]*?>/g, '')) > 5000-->
<!--                const tempMsg = {-->
<!--                    id: this.getTempId(),-->
<!--                    dialog_id: this.dialogData.id,-->
<!--                    reply_id: this.quoteId,-->
<!--                    reply_data: this.quoteData,-->
<!--                    type: typeLoad ? 'loading' : 'text',-->
<!--                    userid: this.userId,-->
<!--                    msg: {-->
<!--                        text: typeLoad ? '' : textBody,-->
<!--                        type: textType,-->
<!--                    },-->
<!--                }-->
<!--                this.tempMsgs.push(tempMsg)-->
<!--                this.msgType = ''-->
<!--                this.cancelQuote()-->
<!--                this.onActive()-->
<!--                this.$nextTick(this.onToBottom)-->
<!--                //TODO 信息发送-->
<!--                console.log("sendtext- 执行sendMessage1111111111111111-&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;");-->
<!--                console.log("sendtext"+textBody)-->
<!--                const msgContent = new MessageText(textBody);-->
<!--                const setting = Setting.fromUint8(0);-->
<!--                const channelId = this.dialogId;-->
<!--                 console.log("sendtext this.this.dialogId.id:"+this.dialogId);-->
<!--                console.log("sendtext channelId:"+channelId);-->
<!--                const channelTypeGroup = ChannelTypeGroup;-->
<!--                const channel = new Channel(channelId, channelTypeGroup);-->
<!--                WKSDK.shared().chatManager.send(msgContent, channel,setting);-->
<!--                console.log("sendtext- 执行sendMessage结束-&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;");-->


<!--                // this.$store.dispatch("call", {-->
<!--                //     url: 'dialog/msg/sendtext',-->
<!--                //     data: {-->
<!--                //         dialog_id: tempMsg.dialog_id,-->
<!--                //         reply_id: tempMsg.reply_id,-->
<!--                //         text: textBody,-->
<!--                //         text_type: textType,-->
<!--                //         silence,-->
<!--                //     },-->
<!--                //     method: 'post',-->
<!--                // }).then(({data}) => {-->
<!--                //     this.sendSuccess(data, tempMsg.id)-->
<!--                // }).catch(error => {-->
<!--                //     this.$set(tempMsg, 'error', true)-->
<!--                //     this.$set(tempMsg, 'errorData', {type: 'text', mType: type, content: error.msg, msg: textBody})-->
<!--                // });-->
<!--            }-->


<!--            if (emptied) {-->
<!--                requestAnimationFrame(_ => this.msgText = '')-->
<!--            }-->
<!--        },-->
<!--      //消息监听-->
<!--        handleMessage(packet) {-->
<!--          console.log('消息clientSeq->', packet.clientSeq); // 消息客户端序号用来匹配对应的发送的消息-->
<!--          console.log('packet->');-->
<!--          console.log(packet); // 消息客户端序号用来匹配对应的发送的消息-->

<!--          if (packet.reasonCode === 1) {-->
<!--            // 发送成功-->
<!--            console.log('消息发送成功');-->
<!--          } else {-->
<!--            // 发送失败-->
<!--            console.log('消息发送失败');-->
<!--            console.log(packet);-->
<!--          }-->
<!--        },-->

<!--        /**-->
<!--         * 发送录音-->
<!--         * @param msg {base64, duration}-->
<!--         */-->
<!--        sendRecord(msg) {-->
<!--          console.log("应该不是这里吧3")-->
<!--            const tempMsg = {-->
<!--                id: this.getTempId(),-->
<!--                dialog_id: this.dialogData.id,-->
<!--                reply_id: this.quoteId,-->
<!--                reply_data: this.quoteData,-->
<!--                type: 'loading',-->
<!--                userid: this.userId,-->
<!--                msg,-->
<!--            }-->
<!--            this.tempMsgs.push(tempMsg)-->
<!--            this.msgType = ''-->
<!--            this.cancelQuote()-->
<!--            this.onActive()-->
<!--            this.$nextTick(this.onToBottom)-->
<!--            //-->
<!--            this.$store.dispatch("call", {-->
<!--                url: 'dialog/msg/sendrecord',-->
<!--                data: Object.assign(msg, {-->
<!--                    dialog_id: this.dialogId,-->
<!--                    reply_id: this.quoteId,-->
<!--                }),-->
<!--                method: 'post',-->
<!--            }).then(({data}) => {-->
<!--                this.sendSuccess(data, tempMsg.id);-->
<!--            }).catch(error => {-->
<!--                this.$set(tempMsg, 'error', true)-->
<!--                this.$set(tempMsg, 'errorData', {type: 'record', mType: 'record', content: error.msg, msg})-->
<!--            });-->
<!--        },-->

<!--        /**-->
<!--         * 发送文件-->
<!--         * @param row-->
<!--         */-->
<!--        sendFileMsg(row) {-->
<!--            const files = $A.isArray(row) ? row : [row];-->
<!--            if (files.length > 0) {-->
<!--                this.pasteFile = [];-->
<!--                this.pasteItem = [];-->
<!--                files.some(file => {-->
<!--                    const item = {-->
<!--                        type: $A.getMiddle(file.type, null, '/'),-->
<!--                        name: file.name,-->
<!--                        size: file.size,-->
<!--                        result: null-->
<!--                    }-->
<!--                    if (item.type === 'image') {-->
<!--                        const reader = new FileReader();-->
<!--                        reader.readAsDataURL(file);-->
<!--                        reader.onload = ({target}) => {-->
<!--                            item.result = target.result-->
<!--                            this.pasteFile.push(file)-->
<!--                            this.pasteItem.push(item)-->
<!--                            this.pasteShow = true-->
<!--                        }-->
<!--                    } else {-->
<!--                        this.pasteFile.push(file)-->
<!--                        this.pasteItem.push(item)-->
<!--                        this.pasteShow = true-->
<!--                    }-->
<!--                });-->
<!--            }-->
<!--        },-->

<!--        /**-->
<!--         * 发送快捷消息-->
<!--         * @param item-->
<!--         */-->
<!--        sendQuick(item) {-->
<!--          console.log("sendMsg&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;sendQuick")-->
<!--            this.sendMsg(`<p><span data-quick-key="${item.key}">${item.label}</span></p>`)-->
<!--        },-->

<!--        onMsgChange(data) {-->
<!--            const item = this.allMsgs.find(({type, id}) => type == "text" && id == data.id)-->
<!--            if (item) {-->
<!--                const {tail} = this.scrollInfo()-->
<!--                if (data.type === 'append') {-->
<!--                    item.msg.text += data.text-->
<!--                } else if (data.type === 'replace') {-->
<!--                    item.msg.text = data.text-->
<!--                }-->
<!--                this.$nextTick(_ => {-->
<!--                    const {tail: newTail} = this.scrollInfo()-->
<!--                    if (tail <= 10 && newTail != tail) {-->
<!--                        this.operatePreventScroll++-->
<!--                        this.$refs.scroller.scrollToBottom();-->
<!--                        setTimeout(_ => {-->
<!--                            this.operatePreventScroll&#45;&#45;-->
<!--                        }, 50)-->
<!--                    }-->
<!--                })-->
<!--            }-->
<!--        },-->

<!--        onSelectionchange() {-->
<!--            const selectionType = window.getSelection().type;-->
<!--            this.selectedTextStatus = selectionType === "Range"-->
<!--        },-->

<!--        getTempId() {-->
<!--            return this.tempId++-->
<!--        },-->

<!--        /**-->
<!--         * 获取会话的数据-->
<!--         */-->
<!--        getMsgs(data) {-->
<!--          console.log('mounted&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;getMsgs',data);-->
<!--          // this.$store.dispatch('toggleProjectParameter', 'chat');-->
<!--          // reject({ msg: "Loading" });-->
<!--          return new Promise((resolve, reject) => {-->
<!--            setTimeout(_ => this.msgLoadIng++, 2000);-->
<!--            this.$store.dispatch("call", {-->
<!--              url: 'channel/messagesync',-->
<!--              method: 'post',-->
<!--              data: {-->
<!--                login_uid: this.userId + '',-->
<!--                channel_id: this.dialogId,-->
<!--                channel_type: 2,-->
<!--                start_message_seq: 0,-->
<!--                end_message_seq: 0,-->
<!--                pull_mode: 1,-->
<!--                limit: 50  //固定每次取50条-->
<!--              }-->
<!--            }).then(({data}) => {-->
<!--              console.log("mounted&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;getMsgs then ", data);-->
<!--              console.log(data.messages)-->
<!--              resolve(data.messages);-->
<!--              //在这里返回信息-->
<!--            }).catch(({msg}) => {-->
<!--              console.log("mounted&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45; getMsgs catch", msg);-->
<!--              reject([]);-->
<!--            }).finally(_ => {-->
<!--              console.log("mounted&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;getMsgs finally ");-->
<!--              resolve([]);-->
<!--            });-->
<!--          });-->
<!--          //TODO 模拟返回-->
<!--          // return new Promise((resolve, reject) => {-->
<!--          //   setTimeout(_ => this.msgLoadIng++, 2000)-->
<!--          //   //TODO  这里请求频道数据-->
<!--          //   console.log('mounted&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;请求频道数据',data);-->
<!--          //-->
<!--          //-->
<!--          //-->
<!--          //   resolve("");-->
<!--          // })-->

<!--            // return new Promise((resolve, reject) => {-->
<!--            //     setTimeout(_ => this.msgLoadIng++, 2000)-->
<!--            //   console.log("请求频道数据")-->
<!--            //     this.$store.dispatch("getDialogMsgs", data)-->
<!--            //         .then(resolve)-->
<!--            //         .catch(reject)-->
<!--            //         .finally(_ => {-->
<!--            //             this.msgLoadIng&#45;&#45;-->
<!--            //         })-->
<!--            // })-->
<!--        },-->

<!--        msgFilter(item) {-->
<!--            if (this.msgType) {-->
<!--                if (this.msgType === 'tag') {-->
<!--                    if (!item.tag) {-->
<!--                        return false-->
<!--                    }-->
<!--                } else if (this.msgType === 'todo') {-->
<!--                    if (!item.todo) {-->
<!--                        return false-->
<!--                    }-->
<!--                } else if (this.msgType === 'link') {-->
<!--                    if (!item.link) {-->
<!--                        return false-->
<!--                    }-->
<!--                } else if (this.msgType !== item.mtype) {-->
<!--                    return false-->
<!--                }-->
<!--            }-->
<!--            if (this.msgId) {-->
<!--                if (item.reply_id != this.msgId) {-->
<!--                    return false-->
<!--                }-->
<!--            }-->
<!--            return true-->
<!--        },-->

<!--        onSearchMsgId() {-->
<!--            if (this.dialogSearchMsgId > 0 && this.openId === this.dialogId) {-->
<!--                this.onPositionId(this.dialogSearchMsgId)-->
<!--                this.$store.state.dialogSearchMsgId = 0-->
<!--            }-->
<!--        },-->

<!--        onPositionId(position_id, msg_id = 0, loop_num = 0) {-->
<!--            console.log("mounted&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;onPositionId")-->
<!--            return new Promise((resolve, reject) => {-->
<!--                if (position_id === 0) {-->
<!--                    $A.modalError("查看失败：参数错误")-->
<!--                    reject()-->
<!--                    return-->
<!--                }-->
<!--                //-->
<!--                if (this.loadMsg || this.msgType !== '') {-->
<!--                    this.msgType = ''-->
<!--                    if (loop_num === 0) {-->
<!--                        this.$store.dispatch("showSpinner", 600)-->
<!--                    } else if (loop_num > 20) {-->
<!--                        this.$store.dispatch("hiddenSpinner")-->
<!--                        $A.modalError("查看失败：请求超时")-->
<!--                        reject()-->
<!--                        return;-->
<!--                    }-->
<!--                    loop_num++-->
<!--                    setTimeout(_ => {-->
<!--                        this.onPositionId(position_id, msg_id, loop_num).then(resolve).catch(reject)-->
<!--                    }, Math.min(800, 200 * loop_num))-->
<!--                    return;-->
<!--                }-->
<!--                if (loop_num > 0) {-->
<!--                    this.$store.dispatch("hiddenSpinner")-->
<!--                }-->
<!--                //-->
<!--                const index = this.allMsgs.findIndex(item => item.id === position_id)-->
<!--                const gtpos = this.prevId > 0 ? 0 : -1  // 如果还有更多消息时定位的消息必须不是第一条是为了避免定位后又有新加载-->
<!--                if (index > gtpos) {-->
<!--                    setTimeout(_ => {-->
<!--                        this.onToIndex(index)-->
<!--                        resolve()-->
<!--                    }, 200)-->
<!--                } else {-->
<!--                    if (msg_id > 0) {-->
<!--                        this.$store.dispatch("setLoad", {-->
<!--                            key: `msg-${msg_id}`,-->
<!--                            delay: 600-->
<!--                        })-->
<!--                    }-->
<!--                    this.preventToBottom = true;-->
<!--                    this.getMsgs({-->
<!--                        dialog_id: this.dialogId,-->
<!--                        msg_id: this.msgId,-->
<!--                        msg_type: this.msgType,-->
<!--                        position_id,-->
<!--                        spinner: 2000-->
<!--                    }).finally(_ => {-->

<!--                        const index = this.allMsgs.findIndex(item => item.id === position_id)-->
<!--                        if (index > -1) {-->
<!--                            this.onToIndex(index)-->
<!--                            resolve()-->
<!--                        }-->
<!--                        if (msg_id > 0) {-->
<!--                            this.$store.dispatch("cancelLoad", `msg-${msg_id}`)-->
<!--                        }-->
<!--                        this.preventToBottom = false;-->
<!--                    })-->
<!--                }-->
<!--            })-->
<!--        },-->

<!--        onViewTodo(item) {-->
<!--            if (this.operateVisible) {-->
<!--                return-->
<!--            }-->
<!--            this.todoViewId = item.id-->
<!--            this.todoViewMid = item.msg_id-->
<!--            this.todoViewShow = true-->
<!--            //-->
<!--            const index = this.allMsgs.findIndex(item => item.id === this.todoViewMid)-->
<!--            if (index === -1) {-->
<!--                this.$store.dispatch("call", {-->
<!--                    url: 'dialog/msg/one',-->
<!--                    data: {-->
<!--                        msg_id: this.todoViewMid-->
<!--                    },-->
<!--                }).then(({data}) => {-->
<!--                    this.todoViewData = data-->
<!--                })-->
<!--            }-->
<!--        },-->

<!--        onCloseTodo() {-->
<!--            this.todoViewLoad = false-->
<!--            this.todoViewShow = false-->
<!--            this.todoViewData = {}-->
<!--            this.todoViewMid = 0-->
<!--            this.todoViewId = 0-->
<!--            this.onFooterResize()-->
<!--        },-->

<!--        onPosTodo() {-->
<!--            if (!this.todoViewMid) {-->
<!--                return-->
<!--            }-->
<!--            this.todoViewPosLoad = true-->
<!--            this.onPositionId(this.todoViewMid).then(this.onCloseTodo).finally(_ => {-->
<!--                this.todoViewPosLoad = false-->
<!--            })-->
<!--        },-->

<!--        onDoneTodo() {-->
<!--            if (!this.todoViewId || this.todoViewLoad) {-->
<!--                return-->
<!--            }-->
<!--            this.todoViewLoad = true-->
<!--            //-->
<!--            this.$store.dispatch("call", {-->
<!--                url: 'dialog/msg/done',-->
<!--                data: {-->
<!--                    id: this.todoViewId,-->
<!--                },-->
<!--            }).then(({data}) => {-->
<!--                this.$store.dispatch("saveDialogTodo", {-->
<!--                    id: this.todoViewId,-->
<!--                    done_at: $A.formatDate("Y-m-d H:i:s")-->
<!--                })-->
<!--                this.$store.dispatch("saveDialog", {-->
<!--                    id: this.dialogId,-->
<!--                    todo_num: this.todoList.length-->
<!--                })-->
<!--                if (data.add) {-->
<!--                    this.sendSuccess(data.add)-->
<!--                }-->
<!--                //TODO 屏蔽不需要的请求-->
<!--                // if (this.todoList.length === 0) {-->
<!--                //     this.$store.dispatch("getDialogTodo", this.dialogId)-->
<!--                // }-->


<!--                this.onCloseTodo()-->
<!--            }).catch(({msg}) => {-->
<!--                $A.modalError(msg)-->
<!--            }).finally(_ => {-->
<!--                this.todoViewLoad = false-->
<!--            });-->
<!--        },-->

<!--        itemClassAdd(index) {-->
<!--            return index === this.msgActiveIndex ? 'common-shake' : '';-->
<!--        },-->

<!--        inputFocus() {-->
<!--            this.$nextTick(_ => {-->
<!--                this.$refs.input && this.$refs.input.focus()-->
<!--            })-->
<!--        },-->

<!--        onRecordState(state) {-->
<!--            this.recordState = state;-->
<!--        },-->

<!--        chatPasteDrag(e, type) {-->
<!--            this.dialogDrag = false;-->
<!--            if ($A.dataHasFolder(type === 'drag' ? e.dataTransfer : e.clipboardData)) {-->
<!--                e.preventDefault();-->
<!--                $A.modalWarning(`暂不支持${type === 'drag' ? '拖拽' : '粘贴'}文件夹。`)-->
<!--                return;-->
<!--            }-->
<!--            const files = type === 'drag' ? e.dataTransfer.files : e.clipboardData.files;-->
<!--            const postFiles = Array.prototype.slice.call(files);-->
<!--            if (postFiles.length > 0) {-->
<!--                e.preventDefault();-->
<!--                this.sendFileMsg(postFiles);-->
<!--            }-->
<!--        },-->

<!--        chatDragOver(show, e) {-->
<!--            let random = (this.__dialog_drag = $A.randomString(8));-->
<!--            if (!show) {-->
<!--                setTimeout(() => {-->
<!--                    if (random === this.__dialog_drag) {-->
<!--                        this.dialogDrag = show;-->
<!--                    }-->
<!--                }, 150);-->
<!--            } else {-->
<!--                if (e.dataTransfer.effectAllowed === 'move') {-->
<!--                    return;-->
<!--                }-->
<!--                const postFiles = Array.prototype.slice.call(e.dataTransfer.files);-->
<!--                if (postFiles.length === 0) {-->
<!--                    return;-->
<!--                }-->
<!--                this.dialogDrag = true;-->
<!--            }-->
<!--        },-->

<!--        onTouchStart(e) {-->
<!--            console.log("onTouchStart1&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;")-->
<!--            this.wrapperStart = null;-->
<!--            if (this.selectedTextStatus) {-->
<!--                this.wrapperStart = window.scrollY-->
<!--                return-->
<!--            }-->
<!--            if (this.$refs.scroller.$el.contains(e.target)) {-->
<!--                // 聊天内容区域-->
<!--                this.wrapperStart = Object.assign(this.scrollInfo(), {-->
<!--                    clientY: e.touches[0].clientY,-->
<!--                });-->
<!--            } else if (this.$refs.input.$refs.editor.contains(e.target)) {-->
<!--                // 输入内容区域-->
<!--                const editor = this.$refs.input.$refs.editor.querySelector(".ql-editor");-->
<!--                if (editor) {-->
<!--                    const clientSize = editor.clientHeight;-->
<!--                    const offset = editor.scrollTop;-->
<!--                    const scrollSize = editor.scrollHeight;-->
<!--                    this.wrapperStart = {-->
<!--                        offset, // 滚动的距离-->
<!--                        scale: offset / (scrollSize - clientSize), // 已滚动比例-->
<!--                        tail: scrollSize - clientSize - offset, // 与底部距离-->
<!--                        clientY: e.touches[0].clientY,-->
<!--                    }-->
<!--                }-->
<!--            }-->
<!--        },-->

<!--        onTouchMove(e) {-->
<!--            if (this.footerPaddingBottom > 0 || (this.windowPortrait && this.windowScrollY > 0)) {-->
<!--                if (typeof this.wrapperStart === 'number') {-->
<!--                    return;-->
<!--                }-->
<!--                if (this.wrapperStart === null) {-->
<!--                    e.preventDefault();-->
<!--                    return;-->
<!--                }-->
<!--                if (this.wrapperStart.clientY > e.touches[0].clientY) {-->
<!--                    // 向上滑动-->
<!--                    if (this.wrapperStart.tail === 0) {-->
<!--                        e.preventDefault();-->
<!--                    }-->
<!--                } else {-->
<!--                    // 向下滑动-->
<!--                    if (this.wrapperStart.offset === 0) {-->
<!--                        e.preventDefault();-->
<!--                    }-->
<!--                }-->
<!--            }-->
<!--        },-->

<!--        onTouchEnd() {-->
<!--            if (typeof this.wrapperStart === 'number' && $A.isIos()) {-->
<!--                $A.scrollToView(this.$refs.footer, false)-->
<!--            }-->
<!--        },-->

<!--        pasteSend() {-->
<!--            if (this.__paste_send_index) {-->
<!--                return;-->
<!--            }-->
<!--            this.__paste_send_index = 1;-->
<!--            setTimeout(() => {-->
<!--                this.__paste_send_index = 0;-->
<!--            }, 300)-->
<!--            this.pasteFile.some(file => {-->
<!--                this.$refs.chatUpload.upload(file)-->
<!--            });-->
<!--        },-->

<!--        chatFile(type, file) {-->
<!--            switch (type) {-->
<!--                case 'progress':-->
<!--                    const tempMsg = {-->
<!--                        id: file.tempId,-->
<!--                        dialog_id: this.dialogData.id,-->
<!--                        reply_id: this.quoteId,-->
<!--                        type: 'loading',-->
<!--                        userid: this.userId,-->
<!--                        msg: { },-->
<!--                    }-->
<!--                    this.tempMsgs.push(tempMsg)-->
<!--                    this.msgType = ''-->
<!--                    this.cancelQuote()-->
<!--                    this.onActive()-->
<!--                    this.$nextTick(this.onToBottom)-->
<!--                    break;-->

<!--                case 'error':-->
<!--                    this.forgetTempMsg(file.tempId)-->
<!--                    break;-->

<!--                case 'success':-->
<!--                    this.sendSuccess(file.data, file.tempId)-->
<!--                    break;-->
<!--            }-->
<!--        },-->

<!--        sendSuccess(data, tempId = 0) {-->
<!--            if ($A.isArray(data)) {-->
<!--                data.some(item => {-->
<!--                    this.sendSuccess(item, tempId)-->
<!--                })-->
<!--                return;-->
<!--            }-->
<!--            if (tempId > 0) {-->
<!--                const index = this.tempMsgs.findIndex(({id}) => id == tempId)-->
<!--                if (index > -1) {-->
<!--                    this.tempMsgs.splice(index, 1, data)-->
<!--                }-->
<!--                setTimeout(_ => {-->
<!--                    this.forgetTempMsg(tempId)-->
<!--                    this.forgetTempMsg(data.id)-->
<!--                }, 1000)-->
<!--            }-->
<!--            this.$store.dispatch("saveDialogMsg", data);-->
<!--            if (!this.quoteUpdate) {-->
<!--                this.$store.dispatch("increaseTaskMsgNum", data);-->
<!--                this.$store.dispatch("increaseMsgReplyNum", data);-->
<!--                this.$store.dispatch("updateDialogLastMsg", data);-->
<!--            }-->
<!--            this.cancelQuote();-->
<!--            this.onActive();-->
<!--        },-->

<!--        forgetTempMsg(tempId) {-->
<!--            this.tempMsgs = this.tempMsgs.filter(({id}) => id != tempId)-->
<!--        },-->

<!--        setQuote(id, type) {-->
<!--            this.$refs.input?.setQuote(id, type)-->
<!--        },-->

<!--        cancelQuote() {-->
<!--            this.$refs.input?.cancelQuote()-->
<!--        },-->

<!--        onEventFocus() {-->
<!--            this.focusTimer && clearTimeout(this.focusTimer)-->
<!--            this.focusLazy = true-->
<!--            this.$emit("on-focus")-->
<!--        },-->

<!--        onEventBlur() {-->
<!--            this.focusTimer = setTimeout(_ => this.focusLazy = false, 10)-->
<!--            this.$emit("on-blur")-->
<!--        },-->

<!--        onEventMore(e) {-->
<!--            switch (e) {-->
<!--                case 'image':-->
<!--                case 'file':-->
<!--                    this.$refs.chatUpload.handleClick()-->
<!--                    break;-->

<!--                case 'call':-->
<!--                    this.onCallTel()-->
<!--                    break;-->
<!--                case 'anon':-->
<!--                    this.onAnon()-->
<!--                    break;-->
<!--            }-->
<!--        },-->

<!--        onCallTel() {-->
<!--            this.$store.dispatch("call", {-->
<!--                url: 'dialog/tel',-->
<!--                data: {-->
<!--                    dialog_id: this.dialogId,-->
<!--                },-->
<!--                spinner: 600,-->
<!--            }).then(({data}) => {-->
<!--                if (data.tel) {-->
<!--                    $A.eeuiAppSendMessage({-->
<!--                        action: 'callTel',-->
<!--                        tel: data.tel-->
<!--                    });-->
<!--                }-->
<!--                if (data.add) {-->
<!--                    this.$store.dispatch("saveDialogMsg", data.add);-->
<!--                    this.$store.dispatch("updateDialogLastMsg", data.add);-->
<!--                    this.onActive();-->
<!--                }-->
<!--            }).catch(({msg}) => {-->
<!--                $A.modalError(msg);-->
<!--            });-->
<!--        },-->

<!--        onAnon() {-->
<!--            if (this.dialogData.type !== 'user' || this.dialogData.bot) {-->
<!--                $A.modalWarning("匿名消息仅允许发送给个人");-->
<!--                return-->
<!--            }-->
<!--            $A.modalInput({-->
<!--                title: `发送匿名消息`,-->
<!--                placeholder: `匿名消息将通过匿名消息（机器人）发送给对方，不会记录你的任何身份信息`,-->
<!--                inputProps: {-->
<!--                    type: 'textarea',-->
<!--                    rows: 3,-->
<!--                    autosize: { minRows: 3, maxRows: 6 },-->
<!--                    maxlength: 2000,-->
<!--                },-->
<!--                okText: "匿名发送",-->
<!--                onOk: (value) => {-->
<!--                    if (!value) {-->
<!--                        return `请输入消息内容`-->
<!--                    }-->
<!--                    return new Promise((resolve, reject) => {-->
<!--                        this.$store.dispatch("call", {-->
<!--                            url: 'dialog/msg/sendanon',-->
<!--                            data: {-->
<!--                                userid: this.dialogData.dialog_user.userid,-->
<!--                                text: value,-->
<!--                            },-->
<!--                            method: 'post',-->
<!--                        }).then(({msg}) => {-->
<!--                            resolve(msg)-->
<!--                        }).catch(({msg}) => {-->
<!--                            reject(msg)-->
<!--                        });-->
<!--                    })-->
<!--                }-->
<!--            });-->
<!--        },-->

<!--        onResizeEvent(entries) {-->
<!--            entries.some(({target, contentRect}) => {-->
<!--                if (target === this.$refs.msgs) {-->
<!--                    this.onMsgsResize(contentRect)-->
<!--                } else if (target === this.$refs.footer) {-->
<!--                    this.onFooterResize()-->
<!--                }-->
<!--            })-->
<!--        },-->

<!--        onMsgsResize({height}) {-->
<!--          console.log("onMsgsResize-&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;")-->
<!--            this.$refs.scroller.$el.style.height = `${height}px`-->
<!--            //-->
<!--            if (typeof this.__msgs_height !== "undefined") {-->
<!--                const size = this.__msgs_height - height;-->
<!--                if (size !== 0) {-->
<!--                    const {offset, tail} = this.scrollInfo()-->
<!--                    if (tail > 0) {-->
<!--                        this.onToOffset(offset + size)-->
<!--                    }-->
<!--                }-->
<!--            }-->
<!--            this.__msgs_height = height;-->
<!--        },-->

<!--        onFooterResize() {-->
<!--            if (!this.$refs.footer) {-->
<!--                return-->
<!--            }-->
<!--            const footer = this.$refs.footer;-->
<!--            const marginSize = parseInt($A.css(footer, 'marginTop')) + parseInt($A.css(footer, 'marginBottom'))-->
<!--            if (this.$refs.msgs) {-->
<!--                this.$refs.msgs.style.marginBottom = `${footer.getBoundingClientRect().height + marginSize}px`;-->
<!--            }-->
<!--        },-->

<!--        onActive() {-->
<!--            this.$emit("on-active");-->
<!--        },-->

<!--        onToBottom() {-->
<!--            this.msgNew = 0;-->
<!--            const scroller = this.$refs.scroller;-->
<!--            if (scroller) {-->
<!--                scroller.scrollToBottom();-->
<!--                requestAnimationFrame(_ => scroller.scrollToBottom())    // 确保滚动到-->
<!--            }-->
<!--        },-->

<!--        onToIndex(index) {-->
<!--          console.log("onTouchStart1&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;onToIndex")-->
<!--            const scroller = this.$refs.scroller;-->
<!--            if (scroller) {-->
<!--                scroller.stopToBottom();-->
<!--                scroller.scrollToIndex(index, -100);-->
<!--                requestAnimationFrame(_ => scroller.scrollToIndex(index, -100))    // 确保滚动到-->
<!--            }-->
<!--            requestAnimationFrame(_ => this.msgActiveIndex = index)-->
<!--        },-->

<!--        onToOffset(offset) {-->
<!--            console.log("onTouchStart1&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;offset")-->
<!--            const scroller = this.$refs.scroller;-->
<!--            if (scroller) {-->
<!--                scroller.stopToBottom();-->
<!--                scroller.scrollToOffset(offset);-->
<!--                setTimeout(_ => {-->
<!--                    scroller.scrollToOffset(offset)-->
<!--                    scroller.virtual.handleFront()-->
<!--                    // scroller.virtual.handleBehind()-->
<!--                }, 10)  // 预防出现白屏的情况-->
<!--            }-->
<!--        },-->

<!--        onMarkOffset(recovery = false) {-->
<!--            const scroller = this.$refs.scroller-->
<!--            if (!scroller) {-->
<!--                return false-->
<!--            }-->
<!--            if (recovery) {-->
<!--                if (this.__mark_offset === undefined) {-->
<!--                    return false-->
<!--                }-->
<!--                this.onToOffset(scroller.getScrollSize() - scroller.getClientSize() - this.__mark_offset)-->
<!--                this.__mark_offset = undefined-->
<!--            } else {-->
<!--                this.__mark_offset = scroller.getScrollSize() - scroller.getClientSize() - scroller.getOffset()-->
<!--            }-->
<!--            return true-->
<!--        },-->

<!--        scrollInfo() {-->
<!--            const scroller = this.$refs.scroller;-->
<!--            if (scroller) {-->
<!--                return scroller.scrollInfo();-->
<!--            } else {-->
<!--                return {-->
<!--                    offset: 0,-->
<!--                    scale: 0,-->
<!--                    tail: 0-->
<!--                }-->
<!--            }-->
<!--        },-->

<!--        openProject() {-->
<!--            if (!this.dialogData.group_info) {-->
<!--                return;-->
<!--            }-->
<!--            if (this.windowPortrait) {-->
<!--                this.$store.dispatch("openDialog", 0);-->
<!--            }-->
<!--            this.goForward({name: 'manage-project', params: {projectId:this.dialogData.group_info.id}});-->
<!--        },-->

<!--        openTask() {-->
<!--            if (!this.dialogData.group_info) {-->
<!--                return;-->
<!--            }-->
<!--            if (this.taskId > 0) {-->
<!--                // 如果当前打开着任务窗口则关闭对话窗口-->
<!--                this.$store.dispatch("openDialog", 0);-->
<!--            }-->
<!--            this.$store.dispatch("openTask", {-->
<!--                id: this.dialogData.group_info.id,-->
<!--                deleted_at: this.dialogData.group_info.deleted_at,-->
<!--                archived_at: this.dialogData.group_info.archived_at,-->
<!--            });-->
<!--        },-->

<!--        openOkr() {-->
<!--            if (!this.dialogData.link_id) {-->
<!--                return;-->
<!--            }-->
<!--            this.$store.dispatch("openOkr", this.dialogData.link_id);-->
<!--        },-->

<!--        onReGetMsg() {-->
<!--            this.scrollToBottomAndRefresh = false-->
<!--            this.getMsgs({-->
<!--                dialog_id: this.dialogId,-->
<!--                msg_id: this.msgId,-->
<!--                msg_type: this.msgType,-->
<!--            }).catch(_ => {});-->
<!--        },-->

<!--        onPrevPage() {-->
<!--            console.log("获取列表&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;")-->
<!--            console.log("获取列表数据来这里")-->
<!--            if (this.prevId === 0) {-->
<!--                return-->
<!--            }-->
<!--          console.log("获取列表数据来这里，开始请求")-->
<!--            this.getMsgs({-->
<!--                dialog_id: this.dialogId,-->
<!--                msg_id: this.msgId,-->
<!--                msg_type: this.msgType,-->
<!--                prev_id: this.prevId,-->
<!--                save_before: _ => this.scrollDisabled = true,-->
<!--                save_after: _ => this.scrollDisabled = false-->
<!--            }).then(({data}) => {-->
<!--                console.log("执行了这里3....")-->
<!--                const ids = data.list.map(item => item.id) //TODO 重新位置-->
<!--                this.$nextTick(() => {-->
<!--                    const scroller = this.$refs.scroller-->
<!--                    const reducer = ids.reduce((previousValue, currentId) => {-->
<!--                        const previousSize = typeof previousValue === "object" ? previousValue.size : scroller.getSize(previousValue)-->
<!--                        return {size: previousSize + scroller.getSize(currentId)}-->
<!--                    })-->
<!--                    let offset = scroller.getOffset() + reducer.size-->
<!--                    if (this.prevId === 0) {-->
<!--                        offset -= 36-->
<!--                    }-->
<!--                    this.onToOffset(offset)-->
<!--                });-->
<!--            }).catch(() => {})-->
<!--        },-->

<!--        onItemRendered(id, size) {-->
<!--            if (!this.$refs.scroller || !this.$refs.footer) {-->
<!--                return-->
<!--            }-->
<!--            if (this.renderMsgNum > 0 && this.$refs.scroller.getSizes() >= this.renderMsgNum) {-->
<!--                this.renderMsgNum = 0-->
<!--                this.onFooterResize()-->
<!--                !this.onMarkOffset(true) && this.onToBottom()-->
<!--            } else if (this.renderMsgSizes.has(id)-->
<!--                && size > this.renderMsgSizes.get(id)-->
<!--                && size - this.renderMsgSizes.get(id) === this.scrollInfo().tail) {-->
<!--                this.onToBottom()-->
<!--            }-->
<!--            this.renderMsgSizes.set(id, size)-->
<!--        },-->

<!--        onDialogMenu(cmd) {-->
<!--            switch (cmd) {-->
<!--                case "searchMsg":-->
<!--                    this.searchShow = true-->
<!--                    this.$nextTick(_ => {-->
<!--                        this.$refs.searchInput.focus()-->
<!--                    })-->
<!--                    break;-->

<!--                case "openCreate":-->
<!--                    const userids = [this.userId]-->
<!--                    if (this.dialogData.dialog_user && this.userId != this.dialogData.dialog_user.userid) {-->
<!--                        userids.push(this.dialogData.dialog_user.userid)-->
<!--                    }-->
<!--                    this.createGroupData = {userids, uncancelable: [this.userId]}-->
<!--                    this.createGroupShow = true-->
<!--                    break;-->

<!--                case "modifyNormal":-->
<!--                    this.modifyData = {-->
<!--                        dialog_id: this.dialogData.id,-->
<!--                        avatar: this.dialogData.avatar,-->
<!--                        name: this.dialogData.name-->
<!--                    }-->
<!--                    if (this.dialogData.type === 'user') {-->
<!--                        // 机器人-->
<!--                        this.modifyData = Object.assign(this.modifyData, {-->
<!--                            userid: this.dialogData.dialog_user.userid,-->
<!--                            avatar: this.cacheUserBasic.find(item => item.userid === this.dialogData.dialog_user.userid)?.userimg,-->
<!--                            clear_day: 0,-->
<!--                            webhook_url: '',-->
<!--                            system_name: '',-->
<!--                        })-->
<!--                        this.modifyLoad++;-->
<!--                        this.$store.dispatch("call", {-->
<!--                            url: 'users/bot/info',-->
<!--                            data: {-->
<!--                                id: this.dialogData.dialog_user.userid-->
<!--                            },-->
<!--                        }).then(({data}) => {-->
<!--                            this.modifyData.clear_day = data.clear_day-->
<!--                            this.modifyData.webhook_url = data.webhook_url-->
<!--                            this.modifyData.system_name = data.system_name-->
<!--                        }).finally(() => {-->
<!--                            this.modifyLoad&#45;&#45;;-->
<!--                        })-->
<!--                    }-->
<!--                    this.modifyShow = true-->
<!--                    break;-->

<!--                case "modifyAdmin":-->
<!--                    this.modifyData = {-->
<!--                        dialog_id: this.dialogData.id,-->
<!--                        avatar: this.dialogData.avatar,-->
<!--                        admin: 1-->
<!--                    }-->
<!--                    this.modifyShow = true-->
<!--                    break;-->

<!--                case "groupInfo":-->
<!--                    this.groupInfoShow = true-->
<!--                    break;-->

<!--                case "transfer":-->
<!--                    this.groupTransferData = {-->
<!--                        dialog_id: this.dialogId,-->
<!--                        userid: [],-->
<!--                        disabledChoice: [this.userId]-->
<!--                    }-->
<!--                    this.groupTransferShow = true-->
<!--                    break;-->

<!--                case "transferConfirm":-->
<!--                    this.onTransferGroup()-->
<!--                    break;-->

<!--                case "disband":-->
<!--                    this.onDisbandGroup()-->
<!--                    break;-->

<!--                case "exit":-->
<!--                    this.onExitGroup()-->
<!--                    break;-->
<!--            }-->
<!--        },-->

<!--        onTransferGroup() {-->
<!--            if (this.groupTransferData.userid.length === 0) {-->
<!--                $A.messageError("请选择新的群主");-->
<!--                return-->
<!--            }-->
<!--            this.groupTransferLoad++;-->
<!--            this.$store.dispatch("call", {-->
<!--                url: 'dialog/group/transfer',-->
<!--                data: {-->
<!--                    dialog_id: this.dialogId,-->
<!--                    userid: this.groupTransferData.userid[0]-->
<!--                }-->
<!--            }).then(({data, msg}) => {-->
<!--                $A.messageSuccess(msg);-->
<!--                this.$store.dispatch("saveDialog", data);-->
<!--            }).catch(({msg}) => {-->
<!--                $A.modalError(msg);-->
<!--            }).finally(_ => {-->
<!--                this.groupTransferLoad&#45;&#45;;-->
<!--                this.groupTransferShow = false;-->
<!--            });-->
<!--        },-->

<!--        onDisbandGroup() {-->
<!--            $A.modalConfirm({-->
<!--                content: `你确定要解散【${this.dialogData.name}】群组吗？`,-->
<!--                loading: true,-->
<!--                okText: '解散',-->
<!--                onOk: () => {-->
<!--                    return new Promise((resolve, reject) => {-->
<!--                        this.$store.dispatch("call", {-->
<!--                            url: 'dialog/group/disband',-->
<!--                            data: {-->
<!--                                dialog_id: this.dialogId,-->
<!--                            }-->
<!--                        }).then(({msg}) => {-->
<!--                            resolve(msg);-->
<!--                            this.$store.dispatch("forgetDialog", this.dialogId);-->
<!--                            this.goForward({name: 'manage-messenger'});-->
<!--                        }).catch(({msg}) => {-->
<!--                            reject(msg);-->
<!--                        });-->
<!--                    })-->
<!--                },-->
<!--            });-->
<!--        },-->

<!--        onExitGroup() {-->
<!--            $A.modalConfirm({-->
<!--                content: "你确定要退出群组吗？",-->
<!--                loading: true,-->
<!--                onOk: () => {-->
<!--                    return new Promise((resolve, reject) => {-->
<!--                        this.$store.dispatch("call", {-->
<!--                            url: 'dialog/group/deluser',-->
<!--                            data: {-->
<!--                                dialog_id: this.dialogId,-->
<!--                            }-->
<!--                        }).then(({msg}) => {-->
<!--                            resolve(msg);-->
<!--                            this.$store.dispatch("forgetDialog", this.dialogId);-->
<!--                            this.goForward({name: 'manage-messenger'});-->
<!--                        }).catch(({msg}) => {-->
<!--                            reject(msg);-->
<!--                        });-->
<!--                    })-->
<!--                },-->
<!--            });-->
<!--        },-->

<!--        onCreateGroup() {-->
<!--            this.createGroupLoad++;-->
<!--            this.$store.dispatch("call", {-->
<!--                url: 'dialog/group/add',-->
<!--                data: this.createGroupData-->
<!--            }).then(({data, msg}) => {-->
<!--                $A.messageSuccess(msg);-->
<!--                this.createGroupShow = false;-->
<!--                this.createGroupData = {};-->
<!--                this.$store.dispatch("saveDialog", data);-->
<!--                this.$store.dispatch('openDialog', data.id)-->
<!--            }).catch(({msg}) => {-->
<!--                $A.modalError(msg);-->
<!--            }).finally(_ => {-->
<!--                this.createGroupLoad&#45;&#45;;-->
<!--            });-->
<!--        },-->

<!--        onModify() {-->
<!--            if (this.modifyData.userid) {-->
<!--                // 个人头像（机器人）-->
<!--                this.modifyLoad++;-->
<!--                this.$store.dispatch("call", {-->
<!--                    url: 'users/bot/edit',-->
<!--                    data: {-->
<!--                        id: this.modifyData.userid,-->
<!--                        avatar: this.modifyData.avatar,-->
<!--                        name: this.modifyData.name,-->
<!--                        clear_day: this.modifyData.clear_day,-->
<!--                        webhook_url: this.modifyData.webhook_url,-->
<!--                    },-->
<!--                    method: 'post'-->
<!--                }).then(({data, msg}) => {-->
<!--                    $A.messageSuccess(msg);-->
<!--                    this.$store.dispatch("saveUserBasic", {-->
<!--                        userid: this.modifyData.userid,-->
<!--                        nickname: data.name,-->
<!--                        userimg: data.avatar,-->
<!--                    });-->
<!--                    this.$store.dispatch("saveDialog", {-->
<!--                        id: this.modifyData.dialog_id,-->
<!--                        name: data.name-->
<!--                    });-->
<!--                    this.modifyShow = false;-->
<!--                    this.modifyData = {};-->
<!--                }).catch(({msg}) => {-->
<!--                    $A.modalError(msg);-->
<!--                }).finally(_ => {-->
<!--                    this.modifyLoad&#45;&#45;;-->
<!--                });-->
<!--            } else {-->
<!--                // 群组头像-->
<!--                this.modifyLoad++;-->
<!--                this.$store.dispatch("call", {-->
<!--                    url: 'dialog/group/edit',-->
<!--                    data: this.modifyData-->
<!--                }).then(({data, msg}) => {-->
<!--                    $A.messageSuccess(msg);-->
<!--                    this.$store.dispatch("saveDialog", data);-->
<!--                    this.modifyShow = false;-->
<!--                    this.modifyData = {};-->
<!--                }).catch(({msg}) => {-->
<!--                    $A.modalError(msg);-->
<!--                }).finally(_ => {-->
<!--                    this.modifyLoad&#45;&#45;;-->
<!--                });-->
<!--            }-->
<!--        },-->

<!--        onForwardBefore() {-->
<!--            return new Promise((resolve, reject) => {-->
<!--                this.forwardData = this.$refs.forwardSelect.formatSelect(this.$refs.forwardSelect.selects);-->
<!--                if (this.forwardData.length === 0) {-->
<!--                    $A.messageError("请选择转发对话或成员");-->
<!--                } else {-->
<!--                    this.forwardMessage = '';-->
<!--                    this.forwardSource = true;-->
<!--                    this.forwardhow = true;-->
<!--                }-->
<!--                reject();-->
<!--            })-->
<!--        },-->

<!--        onForwardAffirm() {-->
<!--            const selects = this.$refs.forwardSelect.selects;-->
<!--            if (selects.length === 0) {-->
<!--                $A.messageError("请选择转发对话或成员");-->
<!--                return-->
<!--            }-->
<!--            const dialogids = selects.filter(value => $A.leftExists(value, 'd:')).map(value => value.replace('d:', ''));-->
<!--            const userids = selects.filter(value => !$A.leftExists(value, 'd:'));-->
<!--            this.forwardLoad++;-->
<!--            this.$store.dispatch("call", {-->
<!--                url: 'dialog/msg/forward',-->
<!--                data: {-->
<!--                    dialogids,-->
<!--                    userids,-->
<!--                    msg_id: this.operateItem.id,-->
<!--                    show_source: this.forwardSource ? 1 : 0,-->
<!--                    leave_message: this.forwardMessage-->
<!--                }-->
<!--            }).then(({data, msg}) => {-->
<!--                this.$store.dispatch("saveDialogMsg", data.msgs);-->
<!--                this.$store.dispatch("updateDialogLastMsg", data.msgs);-->
<!--                $A.messageSuccess(msg);-->
<!--                this.$refs.forwardSelect.hide()-->
<!--                this.forwardhow = false;-->
<!--            }).catch(({msg}) => {-->
<!--                $A.modalError(msg);-->
<!--            }).finally(_ => {-->
<!--                this.forwardLoad&#45;&#45;;-->
<!--            });-->
<!--        },-->

<!--        onActivity(activity) {-->
<!--            if (this.msgActivityStatus === false) {-->
<!--                if (activity) {-->
<!--                    this.msgActivityStatus = 1-->
<!--                }-->
<!--                return-->
<!--            }-->
<!--            if (activity) {-->
<!--                this.msgActivityStatus++-->
<!--            } else {-->
<!--                this.msgActivityStatus&#45;&#45;-->
<!--            }-->
<!--        },-->

<!--        onScroll(event) {-->
<!--             console.log("onTouchStart1&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;scrollAction onScroll")-->
<!--            if (this.operatePreventScroll === 0) {-->
<!--                this.operateVisible = false;-->
<!--            }-->
<!--            //-->
<!--            const {offset, tail} = this.scrollInfo();-->
<!--            this.scrollOffset = offset;-->
<!--            this.scrollTail = tail;-->
<!--            if (this.scrollTail <= 55) {-->
<!--                this.msgNew = 0;-->
<!--                this.scrollToBottomAndRefresh && this.onReGetMsg()-->
<!--            }-->
<!--            //-->
<!--             console.log("onTouchStart1&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;scrollAction scrollTop")-->
<!--            this.scrollAction = event.target.scrollTop;-->
<!--            this.scrollDirection = this.scrollTmp <= this.scrollAction ? 'down' : 'up';-->
<!--            setTimeout(_ => this.scrollTmp = this.scrollAction, 0);-->
<!--            //-->
<!--            this.scrollIng++;-->
<!--            setTimeout(_=> this.scrollIng&#45;&#45;, 100);-->
<!--        },-->

<!--        onRange(range) {-->
<!--            if (this.preventMoreLoad) {-->
<!--                return-->
<!--            }-->
<!--            const key = this.scrollDirection === 'down' ? 'next_id' : 'prev_id';-->
<!--            for (let i = range.start; i <= range.end; i++) {-->
<!--                const rangeValue = this.allMsgs[i][key]-->
<!--                if (rangeValue) {-->
<!--                    const nearMsg = this.allMsgs[i + (key === 'next_id' ? 1 : -1)]-->
<!--                    if (nearMsg && nearMsg.id != rangeValue) {-->
<!--                        this.preventMoreLoad = true-->
<!--                        this.getMsgs({-->
<!--                            dialog_id: this.dialogId,-->
<!--                            msg_id: this.msgId,-->
<!--                            msg_type: this.msgType,-->
<!--                            [key]: rangeValue,-->
<!--                        }).finally(_ => {-->
<!--                          console.log("执行了这里2....")-->
<!--                            this.preventMoreLoad = false-->
<!--                        })-->
<!--                    }-->
<!--                }-->
<!--            }-->
<!--        },-->

<!--        onBack() {-->
<!--            if (!this.beforeBack) {-->
<!--                return this.handleBack();-->
<!--            }-->
<!--            const before = this.beforeBack();-->
<!--            if (before && before.then) {-->
<!--                before.then(() => {-->
<!--                    this.handleBack();-->
<!--                });-->
<!--            } else {-->
<!--                this.handleBack();-->
<!--            }-->
<!--        },-->

<!--        handleBack() {-->
<!--            const {name, params} = this.$store.state.routeHistoryLast;-->
<!--            if (name === this.$route.name && /^\d+$/.test(params.dialogId)) {-->
<!--                this.goForward({name: this.$route.name});-->
<!--            } else {-->
<!--                this.goBack();-->
<!--            }-->
<!--        },-->

<!--        onMsgType(type) {-->
<!--            switch (type) {-->
<!--                case 'project':-->
<!--                    this.openProject()-->
<!--                    break;-->

<!--                case 'task':-->
<!--                    this.openTask()-->
<!--                    break;-->

<!--                case 'okr':-->
<!--                    this.openOkr()-->
<!--                    break;-->

<!--                default:-->
<!--                    if (this.loadMsg) {-->
<!--                        $A.messageWarning("正在加载，请稍后再试...")-->
<!--                    } else {-->
<!--                        this.msgType = type-->
<!--                    }-->
<!--                    break;-->
<!--            }-->
<!--        },-->

<!--        onMention(data) {-->
<!--            const user = this.cacheUserBasic.find(({userid}) => userid == data.userid);-->
<!--            if (user) {-->
<!--                this.$refs.input.addMention({-->
<!--                    denotationChar: "@",-->
<!--                    id: user.userid,-->
<!--                    value: user.nickname,-->
<!--                })-->
<!--            }-->
<!--        },-->

<!--        onLongpress({event, el, msgData}) {-->
<!--            this.operateVisible = this.operateItem.id === msgData.id;-->
<!--            this.operateItem = $A.isJson(msgData) ? msgData : {};-->
<!--            this.operateCopys = []-->
<!--            if (event.target.nodeName === 'IMG' && this.$Electron) {-->
<!--                this.operateCopys.push({-->
<!--                    type: 'image',-->
<!--                    icon: '&#xe7cd;',-->
<!--                    label: '复制图片',-->
<!--                    value: $A.thumbRestore(event.target.currentSrc),-->
<!--                })-->
<!--            } else if (event.target.nodeName === 'A') {-->
<!--                if (event.target.classList.contains("mention") && event.target.classList.contains("file")) {-->
<!--                    this.findOperateFile(this.operateItem.id, event.target.href)-->
<!--                }-->
<!--                this.operateCopys.push({-->
<!--                    type: 'link',-->
<!--                    icon: '&#xe7cb;',-->
<!--                    label: '复制链接',-->
<!--                    value: event.target.href,-->
<!--                })-->
<!--            }-->
<!--            if (msgData.type === 'text') {-->
<!--                if (event.target.nodeName === 'IMG') {-->
<!--                    this.operateCopys.push({-->
<!--                        type: 'imagedown',-->
<!--                        icon: '&#xe7a8;',-->
<!--                        label: '下载图片',-->
<!--                        value: $A.thumbRestore(event.target.currentSrc),-->
<!--                    })-->
<!--                }-->
<!--                const selectText = this.getSelectedTextInElement(el)-->
<!--                if (selectText.length > 0) {-->
<!--                    this.operateCopys.push({-->
<!--                        type: 'selected',-->
<!--                        icon: '&#xe7df;',-->
<!--                        label: '复制选择',-->
<!--                        value: selectText,-->
<!--                    })-->
<!--                }-->
<!--                if (msgData.msg.text.replace(/<[^>]+>/g,"").length > 0) {-->
<!--                    let label = this.operateCopys.length > 0 ? '复制文本' : '复制'-->
<!--                    if (selectText.length > 0) {-->
<!--                        label = '复制全部'-->
<!--                    }-->
<!--                    this.operateCopys.push({-->
<!--                        type: 'text',-->
<!--                        icon: '&#xe77f;',-->
<!--                        label,-->
<!--                        value: '',-->
<!--                    })-->
<!--                }-->
<!--            }-->
<!--            this.$nextTick(() => {-->
<!--                const projectRect = el.getBoundingClientRect();-->
<!--                const wrapRect = this.$el.getBoundingClientRect();-->
<!--                this.operateStyles = {-->
<!--                    left: `${event.clientX - wrapRect.left}px`,-->
<!--                    top: `${projectRect.top + this.windowScrollY}px`,-->
<!--                    height: projectRect.height + 'px',-->
<!--                }-->
<!--                this.operateClient = {x: event.clientX, y: event.clientY};-->
<!--                this.operateVisible = true;-->
<!--            })-->
<!--        },-->

<!--        onOperate(action, value = null) {-->
<!--            this.operateVisible = false;-->
<!--            this.$nextTick(_ => {-->
<!--                switch (action) {-->
<!--                    case "reply":-->
<!--                        this.onReply()-->
<!--                        break;-->

<!--                    case "update":-->
<!--                        this.onUpdate()-->
<!--                        break;-->

<!--                    case "copy":-->
<!--                        this.onCopy(value)-->
<!--                        break;-->

<!--                    case "forward":-->
<!--                        this.$refs.forwardSelect.onSelection()-->
<!--                        break;-->

<!--                    case "withdraw":-->
<!--                        this.onWithdraw()-->
<!--                        break;-->

<!--                    case "view":-->
<!--                        this.onViewFile()-->
<!--                        break;-->

<!--                    case "down":-->
<!--                        this.onDownFile()-->
<!--                        break;-->

<!--                    case "tag":-->
<!--                        this.onTag()-->
<!--                        break;-->

<!--                    case "newTask":-->
<!--                        let content = $A.formatMsgBasic(this.operateItem.msg.text)-->
<!--                        content = content.replace(/<img[^>]*?src=(["'])(.*?)(_thumb\.jpg)*\1[^>]*?>/g, `<img src="$2">`)-->
<!--                        Store.set('addTask', {owner: [this.userId], content});-->
<!--                        break;-->

<!--                    case "todo":-->
<!--                        this.onTodo()-->
<!--                        break;-->

<!--                    case "pos":-->
<!--                        this.onPositionId(this.operateItem.id)-->
<!--                        break;-->

<!--                    case "emoji":-->
<!--                        if (value === 'more') {-->
<!--                            choiceEmojiOne().then(this.onEmoji)-->
<!--                        } else {-->
<!--                            this.onEmoji(value)-->
<!--                        }-->
<!--                        break;-->

<!--                    case "top":-->
<!--                        this.onTopOperate()-->
<!--                        break;-->
<!--                }-->
<!--            })-->
<!--        },-->

<!--        onReply(type) {-->
<!--            this.setQuote(this.operateItem.id, type)-->
<!--            this.inputFocus()-->
<!--        },-->

<!--        onUpdate() {-->
<!--            const {type} = this.operateItem-->
<!--            this.onReply(type === 'text' ? 'update' : 'reply')-->
<!--            if (type === 'text') {-->
<!--                let {text, type} = this.operateItem.msg-->
<!--                this.$refs.input.setPasteMode(false)-->
<!--                if (type === 'md') {-->
<!--                    this.$refs.input.setText(text)-->
<!--                } else {-->
<!--                    if (text.indexOf("mention") > -1) {-->
<!--                        text = text.replace(/<a class="mention file" href="([^'"]*)"([^>]*)>~([^>]*)<\/a>/g, '<span class="mention" data-denotation-char="~" data-id="$1" data-value="$3">&#xFEFF;<span contenteditable="false"><span class="ql-mention-denotation-char">~</span>$3</span>&#xFEFF;</span>')-->
<!--                        text = text.replace(/<span class="mention ([^'"]*)" data-id="(\d+)">([@#])([^>]*)<\/span>/g, '<span class="mention" data-denotation-char="$3" data-id="$2" data-value="$4">&#xFEFF;<span contenteditable="false"><span class="ql-mention-denotation-char">$3</span>$4</span>&#xFEFF;</span>')-->
<!--                    }-->
<!--                    text = text.replace(/<img[^>]*>/gi, match => {-->
<!--                        return match.replace(/(width|height)="\d+"\s*/ig, "");-->
<!--                    })-->
<!--                    this.msgText = $A.formatMsgBasic(text)-->
<!--                }-->
<!--                this.$nextTick(_ => this.$refs.input.setPasteMode(true))-->
<!--            }-->
<!--        },-->

<!--        onCopy(data) {-->
<!--            if (!$A.isJson(data)) {-->
<!--                return-->
<!--            }-->
<!--            const {type, value} = data-->
<!--            switch (type) {-->
<!--                case 'image':-->
<!--                    if (this.$Electron) {-->
<!--                        this.getBase64Image(value).then(base64 => {-->
<!--                            this.$Electron.sendMessage('copyBase64Image', {base64});-->
<!--                        })-->
<!--                    }-->
<!--                    break;-->

<!--                case 'imagedown':-->
<!--                    if (this.$Electron) {-->
<!--                        this.$Electron.sendMessage('saveImageAt', {-->
<!--                            params: { },-->
<!--                            url: value,-->
<!--                        })-->
<!--                    } else {-->
<!--                        this.$store.dispatch('downUrl', {-->
<!--                            url: value,-->
<!--                            token: false-->
<!--                        })-->
<!--                    }-->
<!--                    break;-->

<!--                case 'filepos':-->
<!--                    this.$store.dispatch("filePos", value);-->
<!--                    break;-->

<!--                case 'link':-->
<!--                    this.$copyText(value).then(_ => $A.messageSuccess('复制成功')).catch(_ => $A.messageError('复制失败'))-->
<!--                    break;-->

<!--                case 'selected':-->
<!--                    this.$copyText(value).then(_ => $A.messageSuccess('复制成功')).catch(_ => $A.messageError('复制失败'))-->
<!--                    break;-->

<!--                case 'text':-->
<!--                    const copyEl = $A(this.$refs.scroller.$el).find(`[data-id="${this.operateItem.id}"]`).find('.dialog-content')-->
<!--                    if (copyEl.length > 0) {-->
<!--                        const text = copyEl[0].innerText.replace(/\n\n/g, "\n").replace(/(^\s*)|(\s*$)/g, "")-->
<!--                        this.$copyText(text).then(_ => $A.messageSuccess('复制成功')).catch(_ => $A.messageError('复制失败'))-->
<!--                    } else {-->
<!--                        $A.messageWarning('不可复制的内容');-->
<!--                    }-->
<!--                    break;-->
<!--            }-->
<!--        },-->

<!--        onWithdraw() {-->
<!--            $A.modalConfirm({-->
<!--                content: `确定撤回此信息吗？`,-->
<!--                okText: '撤回',-->
<!--                loading: true,-->
<!--                onOk: () => {-->
<!--                    return new Promise((resolve, reject) => {-->
<!--                        this.$store.dispatch("call", {-->
<!--                            url: 'dialog/msg/withdraw',-->
<!--                            data: {-->
<!--                                msg_id: this.operateItem.id-->
<!--                            },-->
<!--                        }).then(() => {-->
<!--                            resolve("消息已撤回");-->
<!--                            this.$store.dispatch("forgetDialogMsg", this.operateItem.id);-->
<!--                        }).catch(({msg}) => {-->
<!--                            reject(msg);-->
<!--                        });-->
<!--                    })-->
<!--                }-->
<!--            });-->
<!--        },-->

<!--        onViewReply(data) {-->
<!--            if (this.operateVisible) {-->
<!--                return-->
<!--            }-->
<!--            this.onPositionId(data.reply_id, data.msg_id)-->
<!--        },-->

<!--        onViewText({target}, el) {-->
<!--            if (this.operateVisible) {-->
<!--                return-->
<!--            }-->

<!--            // 打开审批详情-->
<!--            let approveElement = target;-->
<!--            while (approveElement) {-->
<!--                if (approveElement.classList.contains('open-approve-details')) {-->
<!--                    const dataId = approveElement.getAttribute("data-id")-->
<!--                    if (window.innerWidth < 426) {-->
<!--                        this.goForward({name: 'manage-approve-details', query: {id: approveElement.getAttribute("data-id")}});-->
<!--                    } else {-->
<!--                        this.approveDetailsShow = true;-->
<!--                        this.$nextTick(() => {-->
<!--                            this.approveDetails = {id: dataId};-->
<!--                        })-->
<!--                    }-->
<!--                    break;-->
<!--                }-->
<!--                if (approveElement.classList.contains('dialog-item')) {-->
<!--                    break;-->
<!--                }-->
<!--                approveElement = approveElement.parentElement;-->
<!--            }-->

<!--            switch (target.nodeName) {-->
<!--                case "IMG":-->
<!--                    if (target.classList.contains('browse')) {-->
<!--                        this.onViewPicture(target.currentSrc);-->
<!--                    } else {-->
<!--                        const list = $A.getTextImagesInfo(el.outerHTML)-->
<!--                        const index = list.findIndex(item => item.src == target.currentSrc)-->
<!--                        this.$store.dispatch("previewImage", {index, list})-->
<!--                    }-->
<!--                    break;-->

<!--                case "SPAN":-->
<!--                    if (target.classList.contains('mention') && target.classList.contains('task')) {-->
<!--                        this.$store.dispatch("openTask", $A.runNum(target.getAttribute("data-id")));-->
<!--                    }-->
<!--                    if (target.classList.contains('mention') && target.classList.contains('okr')) {-->
<!--                        this.$store.dispatch("openOkr", $A.runNum(target.getAttribute("data-id")));-->
<!--                    }-->
<!--                    break;-->

<!--            }-->
<!--        },-->

<!--        onViewFile(data) {-->
<!--            if (this.operateVisible) {-->
<!--                return-->
<!--            }-->
<!--            if (!$A.isJson(data)) {-->
<!--                data = this.operateItem-->
<!--            }-->
<!--            const {msg} = data;-->
<!--            if (['jpg', 'jpeg', 'webp', 'gif', 'png'].includes(msg.ext)) {-->
<!--                this.onViewPicture(msg.path);-->
<!--                return-->
<!--            }-->
<!--            const path = `/single/file/msg/${data.id}`;-->
<!--            if (this.$Electron) {-->
<!--                this.$Electron.sendMessage('windowRouter', {-->
<!--                    name: `file-msg-${data.id}`,-->
<!--                    path: path,-->
<!--                    userAgent: "/hideenOfficeTitle/",-->
<!--                    force: false,-->
<!--                    config: {-->
<!--                        title: `${msg.name} (${$A.bytesToSize(msg.size)})`,-->
<!--                        titleFixed: true,-->
<!--                        parent: null,-->
<!--                        width: Math.min(window.screen.availWidth, 1440),-->
<!--                        height: Math.min(window.screen.availHeight, 900),-->
<!--                    },-->
<!--                    webPreferences: {-->
<!--                        nodeIntegrationInSubFrames: msg.ext === 'drawio'-->
<!--                    },-->
<!--                });-->
<!--            } else if (this.$isEEUiApp) {-->
<!--                $A.eeuiAppOpenPage({-->
<!--                    pageType: 'app',-->
<!--                    pageTitle: `${msg.name} (${$A.bytesToSize(msg.size)})`,-->
<!--                    url: 'web.js',-->
<!--                    params: {-->
<!--                        titleFixed: true,-->
<!--                        allowAccess: true,-->
<!--                        url: $A.rightDelete(window.location.href, window.location.hash) + `#${path}`-->
<!--                    },-->
<!--                });-->
<!--            } else {-->
<!--                window.open($A.apiUrl(`..${path}`))-->
<!--            }-->
<!--        },-->

<!--        onViewPicture(currentUrl) {-->
<!--            const data = this.allMsgs.filter(item => {-->
<!--                if (item.type === 'file') {-->
<!--                    return ['jpg', 'jpeg', 'webp', 'gif', 'png'].includes(item.msg.ext);-->
<!--                } else if (item.type === 'text') {-->
<!--                    return item.msg.text.match(/<img\s+class="browse"[^>]*?>/);-->
<!--                }-->
<!--                return false;-->
<!--            });-->
<!--            //-->
<!--            const list = [];-->
<!--            data.some(({type, msg}) => {-->
<!--                if (type === 'file') {-->
<!--                    list.push({-->
<!--                        src: msg.path,-->
<!--                        width: msg.width,-->
<!--                        height: msg.height,-->
<!--                    })-->
<!--                } else if (type === 'text') {-->
<!--                    list.push(...$A.getTextImagesInfo(msg.text))-->
<!--                }-->
<!--            })-->
<!--            //-->
<!--            const index = list.findIndex(({src}) => src === currentUrl);-->
<!--            if (index > -1) {-->
<!--                this.$store.dispatch("previewImage", {index, list})-->
<!--            } else {-->
<!--                this.$store.dispatch("previewImage", currentUrl)-->
<!--            }-->
<!--        },-->

<!--        onDownFile(data) {-->
<!--            if (this.operateVisible) {-->
<!--                return-->
<!--            }-->
<!--            if (!$A.isJson(data)) {-->
<!--                data = this.operateItem-->
<!--            }-->
<!--            $A.modalConfirm({-->
<!--                title: '下载文件',-->
<!--                content: `${data.msg.name} (${$A.bytesToSize(data.msg.size)})`,-->
<!--                okText: '立即下载',-->
<!--                onOk: () => {-->
<!--                    this.$store.dispatch('downUrl', $A.apiUrl(`dialog/msg/download?msg_id=${data.id}`))-->
<!--                }-->
<!--            });-->
<!--        },-->

<!--        onReplyList(data) {-->
<!--            if (this.operateVisible) {-->
<!--                return-->
<!--            }-->
<!--            this.replyListId = data.msg_id-->
<!--            this.replyListShow = true-->
<!--        },-->

<!--        onError(data) {-->
<!--            if (data.error !== true) {-->
<!--                return-->
<!--            }-->
<!--            const {type, mType, content, msg} = data.errorData-->
<!--            const config = {-->
<!--                icon: 'error',-->
<!--                title: '发送失败',-->
<!--                content,-->
<!--                cancelText: '取消发送',-->
<!--                onCancel: _ => {-->
<!--                    this.forgetTempMsg(data.id)-->
<!--                }-->
<!--            }-->
<!--            if (type === 'text') {-->
<!--                config.okText = '重新发送'-->
<!--                config.onOk = () => {-->
<!--                    this.forgetTempMsg(data.id)-->
<!--                     console.log("sendMsg&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;2")-->
<!--                    this.sendMsg(msg, mType)-->
<!--                }-->
<!--            } else if (type === 'record') {-->
<!--                config.okText = '重新发送'-->
<!--                config.onOk = () => {-->
<!--                    this.forgetTempMsg(data.id)-->
<!--                    this.sendRecord(msg)-->
<!--                }-->
<!--            } else {-->
<!--                return-->
<!--            }-->
<!--            $A.modalConfirm(config)-->
<!--        },-->

<!--        onEmoji(data) {-->
<!--            if (!$A.isJson(data)) {-->
<!--                data = {-->
<!--                    msg_id: this.operateItem.id,-->
<!--                    symbol: data,-->
<!--                }-->
<!--            }-->
<!--            //-->
<!--            const cacheEmojis = this.cacheEmojis.filter(item => item !== data.symbol);-->
<!--            cacheEmojis.unshift(data.symbol)-->
<!--            $A.IDBSave("cacheEmojis", this.$store.state.cacheEmojis = cacheEmojis.slice(0, 3))-->
<!--            //-->
<!--            this.$store.dispatch("setLoad", {-->
<!--                key: `msg-${data.msg_id}`,-->
<!--                delay: 600-->
<!--            })-->
<!--            this.$store.dispatch("call", {-->
<!--                url: 'dialog/msg/emoji',-->
<!--                data,-->
<!--            }).then(({data: resData}) => {-->
<!--                const index = this.dialogMsgs.findIndex(item => item.id == resData.id)-->
<!--                if (index > -1) {-->
<!--                    this.$store.dispatch("saveDialogMsg", resData);-->
<!--                } else if (this.todoViewData.id === resData.id) {-->
<!--                    this.todoViewData = Object.assign(this.todoViewData, resData)-->
<!--                }-->
<!--            }).catch(({msg}) => {-->
<!--                $A.messageError(msg);-->
<!--            }).finally(_ => {-->
<!--                this.$store.dispatch("cancelLoad", `msg-${data.msg_id}`)-->
<!--            });-->
<!--        },-->

<!--        onShowEmojiUser(data) {-->
<!--            if (this.operateVisible) {-->
<!--                return-->
<!--            }-->
<!--            this.respondData = data-->
<!--            this.respondShow = true-->
<!--        },-->

<!--        onTag() {-->
<!--            if (this.operateVisible) {-->
<!--                return-->
<!--            }-->
<!--            const data = {-->
<!--                msg_id: this.operateItem.id,-->
<!--            }-->
<!--            //-->
<!--            this.$store.dispatch("setLoad", {-->
<!--                key: `msg-${data.msg_id}`,-->
<!--                delay: 600-->
<!--            })-->
<!--            this.$store.dispatch("call", {-->
<!--                url: 'dialog/msg/tag',-->
<!--                data,-->
<!--            }).then(({data}) => {-->
<!--                this.tagOrTodoSuccess(data)-->
<!--            }).catch(({msg}) => {-->
<!--                $A.messageError(msg);-->
<!--            }).finally(_ => {-->
<!--                this.$store.dispatch("cancelLoad", `msg-${data.msg_id}`)-->
<!--            });-->
<!--        },-->

<!--        onTypeChange(val) {-->
<!--            if (val === 'user') {-->
<!--                if (this.todoSettingData.userids.length === 0 && this.todoSettingData.quick_value.length > 0) {-->
<!--                    this.todoSettingData.userids = this.todoSettingData.quick_value-->
<!--                }-->
<!--                this.$nextTick(_ => {-->
<!--                    this.$refs.userSelect.onSelection()-->
<!--                })-->
<!--            }-->
<!--            if (val !== 'quick_select') {-->
<!--                this.todoSettingData.quick_value = []-->
<!--            }-->
<!--        },-->

<!--        onQuickChange(val) {-->
<!--            this.todoSettingData.type = val.length === 0 ? 'all' : 'quick_select';-->
<!--        },-->

<!--        onTodo(type) {-->
<!--            if (this.operateVisible) {-->
<!--                return-->
<!--            }-->
<!--            if (type === 'submit') {-->
<!--                const todoData = $A.cloneJSON(this.todoSettingData)-->
<!--                if (todoData.type === 'quick_select') {-->
<!--                    todoData.type = 'user'-->
<!--                    todoData.userids = todoData.quick_value-->
<!--                } else if (todoData.type === 'user' && $A.arrayLength(todoData.userids) === 0) {-->
<!--                    $A.messageWarning("选择指定成员");-->
<!--                    return-->
<!--                }-->
<!--                this.todoSettingLoad++-->
<!--                this.onTodoSubmit(todoData).then(msg => {-->
<!--                    $A.messageSuccess(msg)-->
<!--                    this.todoSettingShow = false-->
<!--                }).catch(e => {-->
<!--                    $A.messageError(e)-->
<!--                }).finally(_ => {-->
<!--                    this.todoSettingLoad&#45;&#45;-->
<!--                })-->
<!--            } else {-->
<!--                const quickList = {}-->
<!--                quickList[this.userId] = this.userId-->
<!--                const userid = this.dialogData.dialog_user?.userid-->
<!--                if (userid && userid != this.userId && !this.dialogData.bot) {-->
<!--                    quickList[userid] = userid-->
<!--                }-->
<!--                if (this.operateItem.type === 'text') {-->
<!--                    const atReg = /<span class="mention user" data-id="(\d+)">([^<]+)<\/span>/g-->
<!--                    const atList = this.operateItem.msg.text.match(atReg)-->
<!--                    if (atList) {-->
<!--                        atList.forEach(item => {-->
<!--                            const userid = parseInt(item.replace(atReg, '$1'))-->
<!--                            if (userid && userid != this.userId) {-->
<!--                                quickList[userid] = userid-->
<!--                            }-->
<!--                        })-->
<!--                    }-->
<!--                }-->
<!--                this.todoSettingData = {-->
<!--                    type: 'all',-->
<!--                    userids: [],-->
<!--                    msg_id: this.operateItem.id,-->
<!--                    quick_value: [],-->
<!--                    quick_list: Object.values(quickList),-->
<!--                }-->
<!--                if (this.operateItem.todo) {-->
<!--                    $A.modalConfirm({-->
<!--                        content: "你确定取消待办吗？",-->
<!--                        cancelText: '取消',-->
<!--                        okText: '确定',-->
<!--                        loading: true,-->
<!--                        onOk: () => this.onTodoSubmit(this.todoSettingData)-->
<!--                    });-->
<!--                } else {-->
<!--                    this.todoSettingShow = true-->
<!--                }-->
<!--            }-->
<!--        },-->

<!--        onTodoSubmit(data) {-->
<!--            return new Promise((resolve, reject) => {-->
<!--                this.$store.dispatch("setLoad", {-->
<!--                    key: `msg-${data.msg_id}`,-->
<!--                    delay: 600-->
<!--                })-->
<!--                this.$store.dispatch("call", {-->
<!--                    url: 'dialog/msg/todo',-->
<!--                    data,-->
<!--                }).then(({data, msg}) => {-->
<!--                    resolve(msg)-->
<!--                    this.tagOrTodoSuccess(data)-->
<!--                    this.onActive()-->
<!--                }).catch(({msg}) => {-->
<!--                    reject(msg);-->
<!--                }).finally(_ => {-->
<!--                    this.$store.dispatch("cancelLoad", `msg-${data.msg_id}`)-->
<!--                });-->
<!--            })-->
<!--        },-->

<!--        tagOrTodoSuccess(data) {-->
<!--            this.$store.dispatch("saveDialogMsg", data.update);-->
<!--            if (data.add) {-->
<!--                this.$store.dispatch("saveDialogMsg", data.add);-->
<!--                this.$store.dispatch("updateDialogLastMsg", data.add);-->
<!--            }-->
<!--        },-->

<!--        onSearchSwitch(type) {-->
<!--            if (this.searchResult.length === 0) {-->
<!--                return-->
<!--            }-->
<!--            if (this.searchLocation === 1 && this.searchResult.length === 1) {-->
<!--                this.onPositionId(this.searchResult[0])-->
<!--                return-->
<!--            }-->
<!--            if (type === 'prev') {-->
<!--                if (this.searchLocation <= 1) {-->
<!--                    this.searchLocation = this.searchResult.length-->
<!--                } else {-->
<!--                    this.searchLocation&#45;&#45;-->
<!--                }-->
<!--            } else {-->
<!--                if (this.searchLocation >= this.searchResult.length) {-->
<!--                    this.searchLocation = 1-->
<!--                } else {-->
<!--                    this.searchLocation++-->
<!--                }-->
<!--            }-->
<!--        },-->

<!--        onSearchKeyup(e) {-->
<!--            if (e === null || e.keyCode === 27) {-->
<!--                this.searchShow = false-->
<!--                this.searchKey = ''-->
<!--                this.searchResult = []-->
<!--            }-->
<!--        },-->

<!--        onPositionMark(id) {-->
<!--            if (this.positionLoad > 0) {-->
<!--                return;-->
<!--            }-->
<!--            this.positionLoad++-->
<!--            //-->
<!--            this.onPositionId(id).finally(_ => {-->
<!--                this.positionLoad&#45;&#45;-->
<!--            })-->
<!--        },-->

<!--        findOperateFile(msgId, link) {-->
<!--            const file = this.fileLinks.find(item => item.link === link)-->
<!--            if (file) {-->
<!--                this.addFileMenu(msgId, file)-->
<!--                return-->
<!--            }-->
<!--            this.$store.dispatch("searchFiles", {-->
<!--                link-->
<!--            }).then(({data}) => {-->
<!--                if (data.length === 1) {-->
<!--                    const file = {-->
<!--                        link,-->
<!--                        id: data[0].id,-->
<!--                        pid: data[0].pid,-->
<!--                    }-->
<!--                    this.fileLinks.push(file)-->
<!--                    this.addFileMenu(msgId, file)-->
<!--                }-->
<!--            }).catch(_ => {})-->
<!--        },-->

<!--        addFileMenu(msgId, data) {-->
<!--            if (this.operateItem.id != msgId) {-->
<!--                return-->
<!--            }-->
<!--            if (this.operateCopys.findIndex(item => item.type === 'filepos') !== -1) {-->
<!--                return-->
<!--            }-->
<!--            const index = Math.max(0, this.operateCopys.findIndex(item => item.type === 'link') - 1)-->
<!--            this.operateCopys.splice(index, 0, {-->
<!--                type: 'filepos',-->
<!--                icon: '&#xe6f3;',-->
<!--                label: '显示文件',-->
<!--                value: {-->
<!--                    folderId: data.pid,-->
<!--                    fileId: null,-->
<!--                    shakeId: data.id-->
<!--                },-->
<!--            })-->
<!--        },-->

<!--        getBase64Image(url) {-->
<!--            return new Promise(resolve => {-->
<!--                let canvas = document.createElement('CANVAS'),-->
<!--                    ctx = canvas.getContext('2d'),-->
<!--                    img = new Image;-->
<!--                img.crossOrigin = 'Anonymous';-->
<!--                img.onload = () => {-->
<!--                    canvas.height = img.height;-->
<!--                    canvas.width = img.width;-->
<!--                    ctx.drawImage(img, 0, 0);-->
<!--                    let format = "png";-->
<!--                    if ($A.rightExists(url, "jpg") || $A.rightExists(url, "jpeg")) {-->
<!--                        format = "jpeg"-->
<!--                    } else if ($A.rightExists(url, "webp")) {-->
<!--                        format = "webp"-->
<!--                    } else if ($A.rightExists(url, "git")) {-->
<!--                        format = "git"-->
<!--                    }-->
<!--                    resolve(canvas.toDataURL(`image/${format}`));-->
<!--                    canvas = null;-->
<!--                };-->
<!--                img.src = url;-->
<!--            })-->
<!--        },-->

<!--        getSelectedTextInElement(element) {-->
<!--            let selectedText = "";-->
<!--            if (window.getSelection) {-->
<!--                let selection = window.getSelection();-->
<!--                if (selection.rangeCount > 0) {-->
<!--                    const range = selection.getRangeAt(0);-->
<!--                    if (element.contains(range.commonAncestorContainer)) {-->
<!--                        selectedText = range.toString();-->
<!--                    }-->
<!--                }-->
<!--            }-->
<!--            return selectedText;-->
<!--        },-->

<!--        onViewAvatar(e) {-->
<!--            let src = null-->
<!--            if (e.target.tagName === "IMG") {-->
<!--                src = e.target.src-->
<!--            } else {-->
<!--                src = $A(e.target).find("img").attr("src")-->
<!--            }-->
<!--            if (src) {-->
<!--                this.$store.dispatch("previewImage", src)-->
<!--            }-->
<!--        },-->

<!--        onTopOperate() {-->
<!--            if (this.operateVisible) {-->
<!--                return-->
<!--            }-->
<!--            if (this.operateItem.top_at) {-->
<!--                this.onCancelTop(this.operateItem)-->
<!--            } else {-->
<!--                this.onTopSubmit(this.operateItem)-->
<!--            }-->
<!--        },-->

<!--        onTopSubmit(data) {-->
<!--            return new Promise((resolve, reject) => {-->
<!--                this.$store.dispatch("setLoad", {-->
<!--                    key: `msg-${data.msg_id}`,-->
<!--                    delay: 600-->
<!--                })-->
<!--                this.$store.dispatch("call", {-->
<!--                    url: 'dialog/msg/top',-->
<!--                    data: {-->
<!--                        msg_id: data.id-->
<!--                    },-->
<!--                }).then(({ data, msg }) => {-->
<!--                    resolve(msg)-->
<!--                    // 取消置顶-->
<!--                    this.$store.dispatch("saveDialog", {-->
<!--                        'id' : this.dialogId,-->
<!--                        'top_msg_id' : data.update?.top_msg_id || 0,-->
<!--                        'top_userid' : data.update?.top_userid || 0-->
<!--                    });-->
<!--                    // 置顶-->
<!--                    if (data.update?.top_msg_id) {-->
<!--                        const index = this.dialogMsgs.findIndex(({ id }) => id == data.update.top_msg_id);-->
<!--                        if (index > -1) {-->
<!--                            this.$store.dispatch("saveDialogMsgTop", Object.assign({}, this.dialogMsgs[index]))-->
<!--                        }-->
<!--                    }-->
<!--                    // 添加消息-->
<!--                    if (data.add) {-->
<!--                        this.$store.dispatch("saveDialogMsg", data.add);-->
<!--                        this.$store.dispatch("updateDialogLastMsg", data.add);-->
<!--                        this.onActive();-->
<!--                    }-->
<!--                }).catch(({ msg }) => {-->
<!--                    reject(msg);-->
<!--                }).finally(_ => {-->
<!--                    this.$store.dispatch("cancelLoad", `msg-${data.msg_id}`)-->
<!--                });-->
<!--            })-->
<!--        },-->

<!--        onPosTop() {-->
<!--            if (!this.topMsg) {-->
<!--                return-->
<!--            }-->
<!--            this.topPosLoad = true-->
<!--            this.onPositionId(this.topMsg.id).finally(_ => {-->
<!--                this.topPosLoad = false-->
<!--            })-->
<!--        },-->

<!--        onCancelTop(info) {-->
<!--            $A.modalConfirm({-->
<!--                content: "你确定取消置顶吗？",-->
<!--                cancelText: '取消',-->
<!--                okText: '确定',-->
<!--                loading: true,-->
<!--                onOk: () => this.onTopSubmit(info)-->
<!--            });-->
<!--        },-->

<!--        getUserApproveStatus() {-->
<!--            console.log('111112进到这里2..getUserApproveStatus..IN........................')-->
<!--            this.approvaUserStatus = ''-->
<!--            if (this.dialogData.type !== 'user' || this.dialogData.bot) {-->
<!--                return-->
<!--            }-->
<!--            this.$store.dispatch("call", {-->
<!--                url: 'approve/user/status',-->
<!--                data: {-->
<!--                    userid: this.dialogData.dialog_user.userid,-->
<!--                }-->
<!--            }).then(({data}) => {-->
<!--                this.approvaUserStatus = data;-->
<!--            }).catch(({msg}) => {-->
<!--                $A.messageError(msg);-->
<!--            });-->
<!--        },-->

<!--    }-->
<!--}-->
<!--</script>-->
