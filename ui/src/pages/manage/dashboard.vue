<template>

  <div class="page-dashboard " >
    <div class="p-8" style="width: 100%;">
      <div class="flex flex-col gap-8" >

        <!--new add -->

        <div
            class="mt-5 grid grid-cols-1 gap-4 px-4 sm:grid-cols-3 sm:px-5"
        >
          <div
              class="relative flex flex-col overflow-hidden rounded-lg bg-gradient-to-br from-info to-info-focus p-3.5"
          >
            <p class="text-xs uppercase text-sky-100">总任务</p>
            <div class="flex items-end justify-between space-x-2">
              <p class="mt-4 text-2xl font-medium text-white">{{dashData.myTaskSize}}</p>
              <ETooltip placement="top" :content="$L('功能开发中...')">
              <a
                  href="#"
                  class="border-b border-dotted border-current pb-0.5 text-xs font-medium text-sky-100 outline-none transition-colors duration-300 line-clamp-1 hover:text-white focus:text-white"
              >获取报告
              </a>
              </ETooltip>
            </div>
            <div
                class="mask is-reuleaux-triangle absolute top-0 right-0 -m-3 h-16 w-16 bg-white/20"
            ></div>
          </div>
          <div
              class="relative flex flex-col overflow-hidden rounded-lg bg-gradient-to-br from-amber-400 to-orange-600 p-3.5"
          >
            <p class="text-xs uppercase text-amber-50">待处理</p>
            <div class="flex items-end justify-between space-x-2">
              <p class="mt-4 text-2xl font-medium text-white">{{dashData.pendingTaskSize}}</p>
              <ETooltip placement="top" :content="$L('功能开发中...')">
              <a href="#"
                  class="border-b border-dotted border-current pb-0.5 text-xs font-medium text-amber-50 outline-none transition-colors duration-300 line-clamp-1 hover:text-white focus:text-white"
              >获取报告
              </a>
              </ETooltip>
            </div>
            <div
                class="mask is-diamond absolute top-0 right-0 -m-3 h-16 w-16 bg-white/20"
            ></div>
          </div>
          <div
              class="relative flex flex-col overflow-hidden rounded-lg bg-gradient-to-br from-pink-500 to-rose-500 p-3.5"
          >
            <p class="text-xs uppercase text-pink-100">本周应完成</p>
            <div class="flex items-end justify-between space-x-2">
              <p class="mt-4 text-2xl font-medium text-white">{{dashData.weekShouleCompleteTaskSize}}</p>

              <ETooltip placement="top" :content="$L('功能开发中...')">
                <a href="#"
                   class="border-b border-dotted border-current pb-0.5 text-xs font-medium text-pink-100 outline-none transition-colors duration-300 line-clamp-1 hover:text-white focus:text-white"
                >获取报告
                </a>
              </ETooltip>

            </div>
            <div class="mask is-hexagon-2 absolute top-0 right-0 -m-3 h-16 w-16 bg-white/20"></div>
          </div>
        </div>

        <!--new add end -->


      <dl class="mt-5 grid grid-cols-1 gap-5 sm:grid-cols-4"  style="display: none">
        <div class="overflow-hidden rounded-lg bg-white px-4 py-5 shadow sm:p-6" style="background: #4477DC">
          <dt class="truncate text-sm font-medium text-white">总任务</dt>
          <dd class="mt-1 text-3xl font-semibold tracking-tight text-white">{{dashData.myTaskSize}}</dd>
        </div>

        <div class="overflow-hidden rounded-lg bg-white px-4 py-5 shadow sm:p-6" style="background: #69D2AC">
          <dt class="truncate text-sm font-medium text-white">待处理</dt>
          <dd class="mt-1 text-3xl font-semibold tracking-tight text-white">{{dashData.pendingTaskSize}}</dd>
        </div>

        <div class="overflow-hidden rounded-lg bg-white px-4 py-5 shadow sm:p-6" style="background: #C244DE">
          <dt class="truncate text-sm font-medium text-white">本周已完成</dt>
          <dd class="mt-1 text-3xl font-semibold tracking-tight text-white">{{dashData.weekCompleteTaskSize}}</dd>
        </div>

        <div class="overflow-hidden rounded-lg bg-white px-4 py-5 shadow sm:p-6" style="background: #ED4014">
          <dt class="truncate text-sm font-medium text-white">本周应完成</dt>
          <dd class="mt-1 text-3xl font-semibold tracking-tight text-white">{{dashData.weekShouleCompleteTaskSize}}</dd>
        </div>
      </dl>

        <!--图片分析-->
        <div class="grid grid-cols-1 gap-8 lg:grid-cols-2">
          <!---->
          <div >
            <h3 class="mb-2 font-semibold capitalize">超期任务</h3>
            <div class="h-[calc(100%-2.25rem)] rounded-[10px] border border-custom-border-200 bg-custom-background-100  text-sm rounded-lg max-h-96 overflow-auto  ring-black ring-opacity-5">
              <div class=" grid grid-cols-4 gap-2  px-3 py-2 font-medium bg-red-500/20 bg-opacity-20 bg-red-300">
                <h4 class="capitalize">超期</h4>
                <h4 class="col-span-2">任务</h4>
                <h4>到期日期</h4>
              </div>

              <div class="max-h-12 overflow-y-auto border-b border-gray-200" v-for="task in dashData.overdueTask" @click="openTaskModal(task)" >
                  <div class="grid grid-cols-4 gap-2 px-3 py-2 ">
                    <h5 class="flex cursor-default items-center gap-2 text-red-500  ">
                      {{expiresFormat(task.end_at)}}
                    </h5>
                    <!--设置最大显示字符数-->
                    <h5 class="col-span-2">{{task.name}}</h5>
                    <h5 class="cursor-default">
                      {{dealTime(task.end_at)}}
                    </h5>
                </div>

              </div>
              <div class="grid h-full place-items-center" v-if="dashData.overdueTask && dashData.overdueTask.length === 0">
                <div class="my-5 flex flex-col items-center gap-4">
<!--                  <LayerDiagonalIcon height={60} width={60} />-->
                  <span class="text-custom-text-200">
                    任务为空，使用快捷键
                    <pre class="inline rounded bg-custom-background-80 px-2 py-1">{{key}}</pre>
                    <pre class="inline rounded bg-custom-background-80 px-2 py-1">+ K</pre>
                   快速添加任务
                  </span>
                </div>
              </div>
            </div>
          </div>
          <!--进行中任务-->
          <div >
            <h3 class="mb-2 font-semibold capitalize">进行中任务</h3>
            <div class="h-[calc(100%-2.25rem)] rounded-[10px] border border-custom-border-200 bg-custom-background-100 text-sm rounded-lg max-h-96 overflow-auto ring-black ring-opacity-5">
              <div class=" grid grid-cols-4 gap-2  px-3 py-2 font-medium bg-opacity-20 bg-green-300">
                <h4 class="capitalize">进行中</h4>
                <h4 class="col-span-2">任务</h4>
                <h4>到期日期</h4>
              </div>
              <div class="max-h-12 overflow-y-auto border-b border-gray-200" v-for="task in dashData.runingTask" @click="openTaskModal(task)" >

                <div class="grid grid-cols-4 gap-2 px-3 py-2">
                  <h5 class="flex cursor-default items-center gap-2 text-green-500 ">
                    {{expiresFormat(task.end_at)}}
                  </h5>
                  <!--设置最大显示字符数-->
                  <h5 class="col-span-2">{{task.name}}</h5>
                  <h5 class="cursor-default">
                    {{dealTime(task.end_at)}}
                    <!--                    {{expiresFormat(task.end_at)}}-->
                  </h5>
                </div>
              </div>

              <div class="grid h-full place-items-center" v-if="dashData.runingTask && dashData.runingTask.length === 0">
                <div class="my-5 flex flex-col items-center gap-4">
                  <!--                  <LayerDiagonalIcon height={60} width={60} />-->
                  <span class="text-custom-text-200">
                    任务为空，使用快捷键
                    <pre class="inline rounded bg-custom-background-80 px-2 py-1">{{key}}</pre>
                    <pre class="inline rounded bg-custom-background-80 px-2 py-1">+ K</pre>
                   快速添加任务
                  </span>
                </div>
              </div>
              </div>
            </div>

            <!--任务状态-->
<!--          <div>-->
<!--            <h3 class="mb-2 font-semibold">任务状态</h3>-->
<!--            <div class="rounded-[10px] border border-custom-border-200 bg-custom-background-100 p-4 rounded-lg">-->
<!--              <div class="grid grid-cols-1 sm:grid-cols-4">-->
<!--                <div class="sm:col-span-3">-->
<!--                   功能开发中-->
<!--                </div>-->

<!--&lt;!&ndash;                <div class="flex sm:block items-center gap-3 flex-wrap justify-center sm:space-y-2 sm:self-end sm:justify-self-end sm:px-8 sm:pb-8">&ndash;&gt;-->
<!--&lt;!&ndash;                  &lt;!&ndash;遍历对象&ndash;&gt;&ndash;&gt;-->
<!--&lt;!&ndash;                  <div  class="flex items-center gap-2">&ndash;&gt;-->
<!--&lt;!&ndash;&lt;!&ndash;                    <div className="h-2 w-2" style={{ backgroundColor: STATE_GROUP_COLORS[cell.state_group] }}/>&ndash;&gt;&ndash;&gt;-->
<!--&lt;!&ndash;                    <div class="h-2 w-2" style="background-color: red"/>&ndash;&gt;-->
<!--&lt;!&ndash;                    <div class="capitalize text-custom-text-200 text-xs whitespace-nowrap">&ndash;&gt;-->
<!--&lt;!&ndash;                      已完成 - 111&ndash;&gt;-->
<!--&lt;!&ndash;                    </div>&ndash;&gt;-->
<!--&lt;!&ndash;                  </div>&ndash;&gt;-->

<!--&lt;!&ndash;                  <div  class="flex items-center gap-2">&ndash;&gt;-->
<!--&lt;!&ndash;                    &lt;!&ndash;                    <div className="h-2 w-2" style={{ backgroundColor: STATE_GROUP_COLORS[cell.state_group] }}/>&ndash;&gt;&ndash;&gt;-->
<!--&lt;!&ndash;                    <div class="h-2 w-2" style="background-color: green"/>&ndash;&gt;-->
<!--&lt;!&ndash;                    <div class="capitalize text-custom-text-200 text-xs whitespace-nowrap">&ndash;&gt;-->
<!--&lt;!&ndash;                      进行中 - 87&ndash;&gt;-->
<!--&lt;!&ndash;                    </div>&ndash;&gt;-->
<!--&lt;!&ndash;                  </div>&ndash;&gt;-->

<!--&lt;!&ndash;                  <div  class="flex items-center gap-2">&ndash;&gt;-->
<!--&lt;!&ndash;                    &lt;!&ndash;                    <div className="h-2 w-2" style={{ backgroundColor: STATE_GROUP_COLORS[cell.state_group] }}/>&ndash;&gt;&ndash;&gt;-->
<!--&lt;!&ndash;                    <div class="h-2 w-2" style="background-color: yellow"/>&ndash;&gt;-->
<!--&lt;!&ndash;                    <div class="capitalize text-custom-text-200 text-xs whitespace-nowrap">&ndash;&gt;-->
<!--&lt;!&ndash;                      待处理 - 87&ndash;&gt;-->
<!--&lt;!&ndash;                    </div>&ndash;&gt;-->
<!--&lt;!&ndash;                  </div>&ndash;&gt;-->
<!--&lt;!&ndash;                  &lt;!&ndash;遍历对象&ndash;&gt;&ndash;&gt;-->
<!--&lt;!&ndash;                </div>&ndash;&gt;-->

<!--              </div>-->
<!--            </div>-->
<!--          </div>-->

        </div>
      </div>
    </div>

    <PageTitle :title="$L('仪表盘')"/>
    <Alert v-if="warningMsg" class="dashboard-warning" type="warning" show-icon>
      <span @click="goForward({name: 'manage-setting-license'})">{{ warningMsg }}</span>
    </Alert>
    <div class="dashboard-wrapper" :style="wrapperStyle" style="display: none">
      <div class="dashboard-hello">{{ $L('欢迎您，' + userInfo.nickname) }}</div>
      <div class="dashboard-desc">
        {{ $L('以下是你当前的任务统计数据') }}
        <transition name="dashboard-load">
          <div v-if="loadDashboardTasks" class="dashboard-load">
            <Loading/>
          </div>
        </transition>
      </div>

      <div class="todo">
        <div class="todo-main">
          <div v-for="subs in groupedLevels" class="todo-ul">
            <div v-for="index in subs" class="todo-li">
              <div class="todo-card">
                <div class="todo-card-head" :style="{ 'background-color': taskDatas[index].items[0].p_color }">
                  <i class="ft icon flag">&#xE753;</i>
                  <div class="todo-card-title">{{taskDatas[index].items[0].p_name? taskDatas[index].items[0].p_name : '未知'}}</div>
<!--                    <label class="todo-input-box"-->
<!--                           :class="{active: !!taskDatas[index].focus}"-->
<!--                           @click="()=>{$set(taskDatas[index],'focus',true)}"-->
<!--                           -->
<!--                    >-->
                  <label class="todo-input-box">
                    <div class="todo-input-ibox" @click.stop="">
                      <Input v-model="taskDatas[index].p_name" class="todo-input-enter"
                             :placeholder="$L('在这里输入事项，回车即可保存')" @on-enter="addTask(index)"></Input>
                      <div class="todo-input-close"><i
                          class="ft icon">&#xE710;</i></div>
                    </div>
<!--                    <div class="todo-input-pbox">-->
<!--                      <div class="todo-input-placeholder">{{ $L('点击可快速添加需要处理的事项') }}</div>-->
<!--                      <div class="todo-input-close"><i class="ft icon">&#xE740;</i></div>-->
<!--                    </div>-->
                  </label>
                </div>
                <div class="todo-card-content">
                <draggable
                      v-model="taskDatas[index].items"
                      class="content-ul"
                      group="task"
                      draggable=".task-draggable"
                      :animation="150"
                      @sort="taskSortUpdate"
                      @remove="taskSortUpdate"
                >
                    <div v-for="task in taskDatas[index].items" class="content-li task-draggable" :key="task.id"
                         :class="{complete:task.complete}" @click="openTaskModal(task)">
                      <div class="subtask-progress"><em :style="{width: subtaskProgress(task) + '%'}"></em></div>
                      <Icon v-if="task.complete" class="task-check" type="md-checkbox-outline"
                            @click.stop="taskComplete(task, false)"/>
                      <Icon v-else class="task-check" type="md-square-outline" @click.stop="taskComplete(task, true)"/>
                      <div v-if="!!task.loadIng" class="task-loading">
                        <w-loading></w-loading>
                      </div>
                      <div v-if="task.overdue" class="task-overdue">[{{ $L('超期') }}]</div>
<!--                      <div class="item-select" @click.stop="openMenu($event, task)">-->
<!--                           <i class="taskfont" v-html="task.complete_at ? '&#xe627;' : '&#xe625;'"></i>-->
<!--                      </div>-->
                      <div class="task-title">

                        {{ task.name }}
                        <span v-if="task.enddate > 0 && $A.formatDate('Ymd', task.enddate)==$A.formatDate('Ymd')"
                              class="task-today">{{ $L('今天') }}</span>
                        <span
                            v-else-if="task.enddate > 0 && $A.formatDate('Ymd', task.enddate - 86400)==$A.formatDate('Ymd')"
                            class="task-tomorrow">{{ $L('明天') }}</span>
                        <span v-else-if="task.enddate > 0" class="task-enddate">{{ formatCDate(task.enddate) }}</span>
                        <Icon v-if="task.desc" type="ios-list-box-outline"/>
                      </div>
                    </div>
<!--                    <div v-if="taskDatas[index].hasMorePages === true" class="content-li more"-->
<!--                         @click="getTaskLists(index, true)">{{ $L('加载更多') }}-->
<!--                    </div>-->
                  </draggable>
                  <div v-if="taskDatas[index].items.length === 0 && taskDatas[index].loadIng == 0"
                       class="content-empty">{{ $L('恭喜你！已完成了所有待办') }}
                  </div>
                  <div v-if="taskDatas[index].loadIng > 0" class="content-loading">
                    <w-loading></w-loading>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!--            <ul class="dashboard-block" style="display: none">-->

      <!--                <li @click="scrollTo('today')">-->
      <!--                    <div class="block-title">{{getTitle('today')}}</div>-->
      <!--                    <div class="block-data">-->
      <!--                        <div class="block-num">{{dashboardTask.today_count}}</div>-->
      <!--                        <i class="taskfont">&#xe6f4;</i>-->
      <!--                    </div>-->
      <!--                </li>-->
      <!--                <li @click="scrollTo('overdue')">-->
      <!--                    <div class="block-title">{{getTitle('overdue')}}</div>-->
      <!--                    <div class="block-data">-->
      <!--                        <div class="block-num">{{dashboardTask.overdue_count}}</div>-->
      <!--                        <i class="taskfont">&#xe603;</i>-->
      <!--                    </div>-->
      <!--                </li>-->
      <!--                <li @click="scrollTo('all')">-->
      <!--                    <div class="block-title">{{getTitle('all')}}</div>-->
      <!--                    <div class="block-data">-->
      <!--                        <div class="block-num">{{dashboardTask.all_count}}</div>-->
      <!--                        <i class="taskfont">&#xe6f9;</i>-->
      <!--                    </div>-->
      <!--                </li>-->
      <!--            </ul>-->
      <!--            <Scrollbar class="dashboard-list" style="display: none">-->
      <!--                <template-->
      <!--                    v-for="column in columns"-->
      <!--                    v-if="column.list.length > 0">-->
      <!--                    <div :ref="`type_${column.type}`" class="dashboard-ref"></div>-->
      <!--                    <div class="dashboard-title">{{column.title}}</div>-->
      <!--                    <ul class="dashboard-ul">-->
      <!--                        <li-->
      <!--                            v-for="(item, index) in column.list"-->
      <!--                            :key="index"-->
      <!--                            :class="{complete: item.complete_at}"-->
      <!--                            :style="item.color ? {backgroundColor: item.color} : {}"-->
      <!--                            @click="openTask(item)">-->
      <!--                            <em-->
      <!--                                v-if="item.p_name"-->
      <!--                                class="priority-color"-->
      <!--                                :style="{backgroundColor:item.p_color}"></em>-->
      <!--                            <div class="item-select" @click.stop="openMenu($event, item)">-->
      <!--                                <i class="taskfont" v-html="item.complete_at ? '&#xe627;' : '&#xe625;'"></i>-->
      <!--                            </div>-->
      <!--                            <div class="item-title">-->
      <!--                                &lt;!&ndash;工作流状态&ndash;&gt;-->
      <!--                                <span v-if="item.flow_item_name" :class="item.flow_item_status" @click.stop="openMenu($event, item)">{{item.flow_item_name}}</span>-->
      <!--                                &lt;!&ndash;是否子任务&ndash;&gt;-->
      <!--                                <span v-if="item.sub_top === true">{{$L('子任务')}}</span>-->
      <!--                                &lt;!&ndash;有多少个子任务&ndash;&gt;-->
      <!--                                <span v-if="item.sub_my && item.sub_my.length > 0">+{{item.sub_my.length}}</span>-->
      <!--                                &lt;!&ndash;任务描述&ndash;&gt;-->
      <!--                                {{item.name}}-->
      <!--                            </div>-->
      <!--                            <div v-if="item.desc" class="item-icon">-->
      <!--                                <i class="taskfont">&#xe71a;</i>-->
      <!--                            </div>-->
      <!--                            <div v-if="item.sub_num > 0" class="item-icon">-->
      <!--                                <i class="taskfont">&#xe71f;</i>-->
      <!--                                <em>{{item.sub_complete}}/{{item.sub_num}}</em>-->
      <!--                            </div>-->
      <!--                            <ETooltip v-if="item.end_at" :disabled="$isEEUiApp || windowTouch" :content="item.end_at" placement="right">-->
      <!--                                <div :class="['item-icon', item.today ? 'today' : '', item.overdue ? 'overdue' : '']">-->
      <!--                                    <i class="taskfont">&#xe71d;</i>-->
      <!--                                    <em>{{expiresFormat(item.end_at)}}</em>-->
      <!--                                </div>-->
      <!--                            </ETooltip>-->
      <!--                        </li>-->
      <!--                    </ul>-->
      <!--                </template>-->
      <!--            </Scrollbar>-->
    </div>
  </div>
</template>

<script>
import {mapGetters, mapState} from "vuex";
import TaskMenu from "./components/TaskMenu";

export default {
  components: {TaskMenu},
  data() {
    return {
      taskDatas:{},
      dashData:{},  //首页数据
      groupedLevels:[], //分组
      nowTime: $A.Time(),
      nowInter: null,
      licenseTimer: null,
      loadIng: 0,
      dashboard: 'today',
      warningMsg: '',
      isMac: window.navigator.platform.toUpperCase().indexOf('MAC') >= 0
    }
  },

  activated() {
    this.$store.dispatch("getTaskForDashboard", 600);
    this.loadInterval(true);
    this.refreshTask();
    // this.loadLicense(true);
  },

  deactivated() {
    this.$store.dispatch("forgetTaskCompleteTemp", true);
    this.loadInterval(false);
    // this.loadLicense(false);
  },

  computed: {

    ...mapState(['userInfo', 'userIsAdmin', 'cacheTasks', 'taskCompleteTemps', 'loadDashboardTasks']),
    ...mapGetters(['dashboardTask', 'assistTask', 'transforTasks']),

    columns() {
      const list = [];
      ['today', 'overdue', 'all'].some(type => {
        let data = this.transforTasks(this.dashboardTask[type]);
        list.push({
          type,
          title: this.getTitle(type),
          list: data.sort((a, b) => {
            return $A.Date(a.end_at || "2099-12-31 23:59:59") - $A.Date(b.end_at || "2099-12-31 23:59:59");
          })
        })
      })
      list.push({
        type: 'assist',
        title: this.getTitle('assist'),
        list: this.assistTask.sort((a, b) => {
          return $A.Date(a.end_at || "2099-12-31 23:59:59") - $A.Date(b.end_at || "2099-12-31 23:59:59");
        })
      })
      return list;
    },

    key() {
      return this.isMac ? 'Command' : 'Ctrl';
    },
    total() {
      const {dashboardTask} = this;
      return dashboardTask.today_count + dashboardTask.overdue_count + dashboardTask.all_count;
    },

    wrapperStyle({warningMsg}) {
      return warningMsg ? {
        'max-height': 'calc(100% - 50px)'
      } : null
    },

  },

  watch: {
    windowActive(active) {
      this.loadInterval(active)
      // this.loadLicense(active);
    }
  },

  methods: {
    dealTime(date) {
      let time = $A.Date(date, true);
      // console.log("date--->"+date);
      // $A.formatDate('Y-m-d', line)
      return $A.formatDate('m/d H:i', time);
    },

    taskSortUpdate() {


    },

    subtaskProgress(task) {

    },

    openTaskModal(taskDetail) {
      this.openTask(taskDetail);

    },
    getTaskSort() {
    },
    addTask(index) {

    },
    refreshTask(){
      // this.getTaskLists()
      this.getDashData()
    },
    getDashData(){
      this.$store.dispatch("call", {
        method: 'get',
        url: 'project/dash',
      }).then(({data}) => {
        this.dashData = {};
        this.dashData = data
      }).catch(({msg}) => {
        $A.modalError(msg);
      }).finally(_ => {
        this.loadIng--;
      });

    },

    getTaskLists(){
      this.$store.dispatch("call", {
        method: 'get',
        url: 'project/task/lists',
      }).then(({data}) => {
        // 清空taskDatas，好像无效呢
        // for (let p_level in this.taskDatas) {
        //   if (this.taskDatas.hasOwnProperty(p_level)) {
        //     delete this.taskDatas[p_level];
        //   }
        // }

        this.taskDatas = {};
        data.data.forEach(item => {
          if (!this.taskDatas[item.p_level]) {
            this.groupedLevels.push(item.p_level); //新建
            this.$set(this.taskDatas, item.p_level, {
              p_level: item.p_level,
              items: []
            });
          }
          this.taskDatas[item.p_level].items.push(item);
        });

        this.$forceUpdate()  //强刷

        // this.groupedLevels = groupedLevels.reduce((acc, curr, index) => {
        //   if (index % 2 === 0) {
        //     acc.push([curr, groupedLevels[index + 1]]);
        //   }
        //   return acc;
        // }, []);

        const result = this.chunkArray(this.groupedLevels, 2);
        this.groupedLevels = result;
      }).catch(({msg}) => {
        // $A.modalError(msg);
      }).finally(_ => {
        this.loadIng--;
      });
    },
    chunkArray(arr, chunkSize) {
      arr =  arr.slice(0, 4);
      const chunkedArray = [];
      for (let i = 0; i < arr.length; i += 2) {
        chunkedArray.push(arr.slice(i, i + 2));
      }
      return chunkedArray;
    },

    getTodayNum(){


    },
    formatCDate(){

    },

    pTitle(p) {
      switch (p) {
        case "1":
          return this.$L("重要且紧急");
        case "2":
          return this.$L("重要不紧急");
        case "3":
          return this.$L("紧急不重要");
        case "4":
          return this.$L("不重要不紧急");
      }
    },
    getTitle(type) {
      switch (type) {
        case 'today':
          return this.$L('今日到期');
        case 'overdue':
          return this.$L('超期任务');
        case 'all':
          return this.$L('待完成任务');
        case 'assist':
          return this.$L('协助的任务');
        default:
          return '';
      }
    },

    scrollTo(type) {
      let refs = this.$refs[`type_${type}`]
      if (refs) {
        $A.scrollToView(refs[0], {
          behavior: 'smooth',
          inline: 'end',
        });
      }
    },

    openTask(task) {
      this.$store.dispatch("openTask", task)
    },

    openMenu(event, task) {
      this.$store.state.taskOperation = {event, task}
    },

    expiresFormat(date) {
      return $A.countDownFormat(date, this.nowTime)
    },

    loadInterval(load) {
      if (this.nowInter) {
        clearInterval(this.nowInter)
        this.nowInter = null;
      }
      if (load === false) {
        return
      }
      this.nowInter = setInterval(_ => {
        this.nowTime = $A.Time()
      }, 1000)
    },

    // loadLicense(load) {
    //   if (this.licenseTimer) {
    //     clearTimeout(this.licenseTimer)
    //     this.licenseTimer = null;
    //   }
    //   if (load === false || !this.userIsAdmin) {
    //     return
    //   }
      // this.licenseTimer = setTimeout(_ => {
      //     this.$store.dispatch("call", {
      //         url: 'system/license',
      //         data: {
      //             type: 'get'
      //         }
      //     }).then(({data}) => {
      //         this.warningMsg = data.error.length > 0 ? data.error[0] : '';
      //     }).catch(_ => {
      //         this.warningMsg = '';
      //     })
      // }, 1500)
    // }
  }
}
</script>
<style lang="scss" scoped>
.todo {
  margin-top: 0px;
  padding: 0 12px;
  display: flex;
  flex: 1;
  width: 100%;

  .todo-main {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 100%;
    min-height: 500px;
    padding: 5px;

    .todo-ul {
      flex: 1;
      display: flex;
      flex-direction: row;
      align-items: center;
      justify-content: center;
      width: 100%;

      .todo-li {
        flex: 1;
        height: 100%;
        position: relative;

        .todo-card {
          position: absolute;
          top: 10px;
          left: 10px;
          right: 10px;
          bottom: 10px;
          display: flex;
          flex-direction: column;

          .todo-card-head {
            flex-grow: 0;
            flex-shrink: 0;
            display: flex;
            align-items: center;
            padding: 0 10px;
            height: 38px;
            border-radius: 4px 4px 0 0;
            color: #ffffff;

            .ft.icon {
              transform: scale(1);
            }

            .flag {
              font-weight: bold;
              font-size: 14px;
              margin-right: 5px;
              min-width: 16px;
            }

            .todo-card-title {
              font-weight: bold;
            }

            .todo-input-box {
              flex: 1;
              display: flex;
              flex-direction: row;
              align-items: center;
              justify-content: flex-end;
              height: 100%;
              cursor: pointer;

              &:hover {
                .todo-input-placeholder {
                  opacity: 1;
                }
              }

              &.active {
                .todo-input-pbox {
                  display: none;
                }

                .todo-input-ibox {
                  display: flex;
                }
              }

              .todo-input-placeholder {
                color: rgba(255, 255, 255, 0.6);
                padding-right: 6px;
                transition: all 0.2s;
                opacity: 0;
              }

              .todo-input-pbox,
              .todo-input-ibox {
                flex: 1;
                display: flex;
                flex-direction: row;
                align-items: center;
                justify-content: flex-end;
                padding-left: 14px;
                height: 100%;
              }

              .todo-input-ibox {
                display: none;
              }

              .todo-input-close {
                height: 100%;
                display: flex;
                align-items: center;
                padding-left: 8px;

                i {
                  font-size: 18px;
                  font-weight: normal;
                }
              }
            }

            &.p1 {
              background: rgba(248, 14, 21, 0.6);
            }

            &.p2 {
              background: rgba(236, 196, 2, 0.5);
            }

            &.p3 {
              background: rgba(0, 159, 227, 0.7);
            }

            &.p4 {
              background: rgba(121, 170, 28, 0.7);
            }
          }

          .todo-card-content {
            flex: 1;
            background-color: #f5f6f7;
            border-radius: 0 0 4px 4px;
            overflow: auto;
            transform: translateZ(0);

            .content-ul {
              display: flex;
              flex-direction: column;
              min-height: 20px;

              .content-li {
                display: flex;
                flex-direction: row;
                align-items: flex-start;
                width: 100%;
                padding: 8px;
                color: #444444;
                border-bottom: dotted 1px rgba(153, 153, 153, 0.25);
                position: relative;
                cursor: pointer;

                &.complete {
                  color: #999999;

                  .task-title {
                    text-decoration: line-through;
                  }
                }

                &.more {
                  color: #666;
                  justify-content: center;
                }

                .task-check {
                  font-size: 16px;
                  padding-right: 6px;
                  padding-top: 3px;
                }

                .task-loading {
                  width: 15px;
                  height: 15px;
                  margin-right: 6px;
                  margin-top: 3px;
                }

                .task-overdue {
                  color: #ff0000;
                  padding-right: 2px;
                }

                .task-title {
                  flex: 1;
                  word-break: break-all;

                  &:hover {
                    color: #000000;
                  }

                  .ivu-icon {
                    font-size: 16px;
                    color: #afafaf;
                    vertical-align: top;
                    padding: 2px 6px;
                    transform: scale(0.98);
                  }

                  .task-today,
                  .task-tomorrow,
                  .task-enddate {
                    color: #fff;
                    background: #f90;
                    font-weight: 600;
                    margin-left: 4px;
                    padding: 0 2px;
                    border-radius: 3px;
                    font-size: 12px;
                    line-height: 16px;
                    -webkit-transform: scale(0.9);
                    transform: scale(0.9);
                    border: 1px solid #f90;
                  }

                  .task-tomorrow {
                    font-weight: normal;
                    background: transparent;
                    color: #f90;
                  }

                  .task-enddate {
                    font-weight: normal;
                    background: transparent;
                    color: #aaa;
                    border-color: #aaa;
                  }
                }

                .subtask-progress {
                  position: absolute;
                  top: 0;
                  left: 0;
                  width: 100%;
                  height: 100%;
                  z-index: -1;
                  overflow: hidden;
                  pointer-events: none;

                  em {
                    display: block;
                    height: 100%;
                    background-color: rgba(3, 150, 242, 0.07);
                  }
                }
              }
            }

            .content-loading {
              width: 100%;
              height: 22px;
              text-align: center;
              margin-top: 8px;
              margin-bottom: 8px;
            }

            .content-empty {
              margin: 6px auto;
              text-align: center;
              color: #666;
            }
          }
        }
      }
    }
  }

  @media (max-width: 768px) {
    .todo-main {
      height: auto;

      .todo-ul {
        flex-direction: column;

        .todo-li {
          width: 100%;

          .todo-card {
            position: static;
            top: 0;
            right: 0;
            left: 0;
            bottom: 0;
            margin: 6px;
            display: flex;
            flex-direction: column;
            min-height: 320px;
            max-height: 520px;
          }
        }
      }
    }
  }
}
</style>