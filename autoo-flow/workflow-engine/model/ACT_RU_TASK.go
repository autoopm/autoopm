package model

import (
	"workflow/util"

	"github.com/jinzhu/gorm"
)

// import _ "github.com/jinzhu/gorm"

// Task 流程任务表
type Task struct {
	Model
	NodeID        string `gorm:"comment:'当前执行流所在的节点ID'" json:"nodeId"`
	Step          int    `gorm:"comment:'一步'" json:"step"`
	ProcInstID    int    `gorm:"comment:'流程实例id'" json:"procInstID"`
	Assignee      string `gorm:"comment:'处理人'" json:"assignee"`
	CreateTime    string `gorm:"autoCreateTime;not null;comment:'创建时间'" json:"createTime"`
	ClaimTime     string `gorm:"not null;comment:'处理时间'" json:"claimTime"`
	MemberCount   int8   `gorm:"default:1;comment:'还未审批的用户数，等于0代表会签已经全部审批结束，默认值为1'" json:"memberCount"`
	UnCompleteNum int8   `gorm:"default:1;comment:'完整的数字'" json:"unCompleteNum"`
	AgreeNum      int8   `gorm:"comment:'审批通过数'" json:"agreeNum"`
	ActType       string `gorm:"default:'or';comment:'and 为会签，or为或签，默认为or'" json:"actType"`
	IsFinished    bool   `gorm:"default:false;comment:'是否完成'" json:"isFinished"`
}

// NewTask 新建任务
func (t *Task) NewTask() (int, error) {
	err := db.Create(t).Error
	if err != nil {
		return 0, err
	}
	return t.ID, nil
}

// UpdateTx 更新任务
func (t *Task) UpdateTx(tx *gorm.DB) error {
	err := tx.Model(&Task{}).Updates(t).Error
	return err
}

// GetTaskByID
func GetTaskByID(id int) (*Task, error) {
	var t = &Task{}
	err := db.Where("id=?", id).Find(t).Error
	return t, err
}

// GetTaskByProInstID 根据流程实例id任务列表
func GetTaskByProInstID(procInstID int) ([]*Task, error) {
	var datas []*Task
	err := db.Where("proc_inst_id=?", procInstID).Order("claim_time desc").Find(&datas).Error
	if err != nil || len(datas) == 0 {
		var datass []*TaskHistory
		err = db.Where("proc_inst_id=?", procInstID).Order("claim_time desc").Find(&datass).Error
		if err != nil {
			return nil, err
		}
		strjson, _ := util.ToJSONStr(&datass)
		util.Str2Struct(strjson, &datas)
	}
	return datas, err
}

// GetTaskLastByProInstID 根据流程实例id获取上一个任务
func GetTaskLastByProInstID(procInstID int) (*Task, error) {
	var t = &Task{}
	err := db.Where("proc_inst_id=? and is_finished=1", procInstID).Order("claim_time desc").First(t).Error
	return t, err
}

// NewTaskTx 开启事务
func (t *Task) NewTaskTx(tx *gorm.DB) (int, error) {
	// str, _ := util.ToJSONStr(t)
	// fmt.Printf("newTask:%s", str)
	err := tx.Create(t).Error
	if err != nil {
		return 0, err
	}
	return t.ID, nil
}

// DeleteTask 删除任务
func DeleteTask(id int) error {
	err := db.Where("id=?", id).Delete(&Task{}).Error
	return err
}
