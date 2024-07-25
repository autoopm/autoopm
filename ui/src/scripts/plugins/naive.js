import * as NaiveUI from 'naive-ui';

const naive = NaiveUI.create({
    components: [
        NaiveUI.NMessageProvider,
        NaiveUI.NDialogProvider,
        NaiveUI.NConfigProvider,
        NaiveUI.NInput,
        NaiveUI.NInputGroup,
        NaiveUI.NInputGroupLabel,
        NaiveUI.NButton,
        NaiveUI.NForm,
        NaiveUI.NFormItem,
        NaiveUI.NFormItemGi,
        NaiveUI.NCheckboxGroup,
        NaiveUI.NCheckbox,
        NaiveUI.NIcon,
        NaiveUI.NLayout,
        NaiveUI.NLayoutHeader,
        NaiveUI.NLayoutContent,
        NaiveUI.NLayoutFooter,
        NaiveUI.NLayoutSider,
        NaiveUI.NMenu,
        NaiveUI.NBreadcrumb,
        NaiveUI.NBreadcrumbItem,
        NaiveUI.NDropdown,
        NaiveUI.NSpace,
        NaiveUI.NTooltip,
        NaiveUI.NAvatar,
        NaiveUI.NTabs,
        NaiveUI.NTabPane,
        NaiveUI.NCard,
        NaiveUI.NRow,
        NaiveUI.NCol,
        NaiveUI.NDrawer,
        NaiveUI.NDrawerContent,
        NaiveUI.NDivider,
        NaiveUI.NSwitch,
        NaiveUI.NBadge,
        NaiveUI.NAlert,
        NaiveUI.NElement,
        NaiveUI.NTag,
        NaiveUI.NNotificationProvider,
        NaiveUI.NProgress,
        NaiveUI.NDatePicker,
        NaiveUI.NGrid,
        NaiveUI.NGridItem,
        NaiveUI.NList,
        NaiveUI.NListItem,
        NaiveUI.NThing,
        NaiveUI.NDataTable,
        NaiveUI.NPopover,
        NaiveUI.NPagination,
        NaiveUI.NSelect,
        NaiveUI.NRadioGroup,
        NaiveUI.NRadio,
        NaiveUI.NRadioButton,
        NaiveUI.NSteps,
        NaiveUI.NStep,
        NaiveUI.NInputGroup,
        NaiveUI.NResult,
        NaiveUI.NDescriptions,
        NaiveUI.NDescriptionsItem,
        NaiveUI.NTable,
        NaiveUI.NInputNumber,
        NaiveUI.NLoadingBarProvider,
        NaiveUI.NModal,
        NaiveUI.NUpload,
        NaiveUI.NUploadDragger,
        NaiveUI.NTree,
        NaiveUI.NTreeSelect,
        NaiveUI.NSpin,
        NaiveUI.NTimePicker,
        NaiveUI.NTimeline,
        NaiveUI.NTimelineItem,
        NaiveUI.NBackTop,
        NaiveUI.NSkeleton,
        NaiveUI.NImage,
        NaiveUI.NImageGroup,
        NaiveUI.NSplit,
        NaiveUI.NEllipsis
    ]
});

export function setupNaive(app) {
    app.use(naive)
}
