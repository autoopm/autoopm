package types

import (
	"errors"
	"strings"
	"time"
	"workflow/util"
)

// 参数
type Vars struct {
	Type        string `json:"type"`        //请假类型，
	Description string `json:"description"` //请假事由
	StartTime   string `json:"startTime"`   //开始时间
	EndTime     string `json:"endTime"`     //结束时间
	Other       string `json:"other"`       //其他
}

var VacateTypes = []string{"年假", "事假", "病假", "调休假", "产假", "婚假", "丧假", "陪产假", "哺乳假"}

// 验证请假类型
func CheckVacateVars(vars *Vars) (bool, error) {
	if vars == nil {
		return false, errors.New("var 不存在")
	}
	if len(vars.Type) == 0 {
		return false, errors.New("var.type 不存在")
	}
	if !strings.Contains(strings.Join(VacateTypes, ","), vars.Type) {
		return false, errors.New("var.type错误,只允许：" + strings.Join(VacateTypes, ","))
	}
	if len(vars.StartTime) == 0 {
		return false, errors.New("var.startTime 不存在")
	}
	if len(vars.EndTime) == 0 {
		return false, errors.New("var.endTime 不存在")
	}
	if len(vars.Description) == 0 {
		return false, errors.New("var.description 不存在")
	}
	if !util.ValidateTimeFormat(vars.StartTime) {
		return false, errors.New("开始时间 无效的时间格式")
	}
	if !util.ValidateTimeFormat(vars.EndTime) {
		return false, errors.New("结束时间 无效的时间格式")
	}
	if vars.StartTime > vars.EndTime {
		return false, errors.New("开始时间不能大于结束时间")
	}
	return true, nil
}

// 验证加班申请类型
func CheckOvertimeVars(vars *Vars) (bool, error) {
	if vars == nil {
		return false, errors.New("var 不存在")
	}
	if len(vars.StartTime) == 0 {
		return false, errors.New("var.startTime 不存在")
	}
	if len(vars.EndTime) == 0 {
		return false, errors.New("var.endTime 不存在")
	}
	if len(vars.Description) == 0 {
		return false, errors.New("var.description 不存在")
	}
	if !util.ValidateTimeFormat(vars.StartTime) {
		return false, errors.New("开始时间 无效的时间格式")
	}
	if !util.ValidateTimeFormat(vars.EndTime) {
		return false, errors.New("结束时间 无效的时间格式")
	}
	if vars.StartTime > vars.EndTime {
		return false, errors.New("开始时间不能大于结束时间")
	}
	return true, nil
}

// 获取时间差 - 单位(小时)
func (vars *Vars) GetHourDiffer() int64 {
	var hour int64
	t1, err := time.ParseInLocation("2006-01-02 15:04", vars.StartTime, time.Local)
	t2, err := time.ParseInLocation("2006-01-02 15:04", vars.EndTime, time.Local)
	if err == nil && t1.Before(t2) {
		diff := t2.Unix() - t1.Unix() //
		hour = diff / 3600
		return hour
	} else {
		return hour
	}
}
