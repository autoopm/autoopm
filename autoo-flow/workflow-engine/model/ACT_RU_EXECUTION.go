package model

import (
	"fmt"
	"time"

	"workflow/util"

	"github.com/jinzhu/gorm"
)

// Execution 流程实例（执行流）表
type Execution struct {
	Model
	Rev         int    `gorm:"comment:'牧师'" json:"rev"`
	ProcInstID  int    `gorm:"comment:'流程实例ID'" json:"procInstID"`
	ProcDefID   int    `gorm:"comment:'流程定义数据的ID'" json:"procDefID"`
	ProcDefName string `gorm:"comment:'流程定义数据的名字'" json:"procDefName"`
	NodeInfos   string `gorm:"size:4000;comment:'NodeInfos 执行流经过的所有节点'" json:"nodeInfos"`
	IsActive    int8   `gorm:"comment:'是活跃的'" json:"isActive"`
	StartTime   string `gorm:"comment:'开始时间'" json:"startTime"`
}

// Save
func (p *Execution) Save() (ID int, err error) {
	err = db.Create(p).Error
	if err != nil {
		return 0, err
	}
	return p.ID, nil
}

// SaveTx 接收外部事务
func (p *Execution) SaveTx(tx *gorm.DB) (ID int, err error) {
	p.StartTime = util.FormatDate(time.Now(), util.YYYY_MM_DD_HH_MM_SS)
	if err := tx.Create(p).Error; err != nil {
		return 0, err
	}
	return p.ID, nil
}

// GetExecByProcInst 根据流程实例id查询执行流
func GetExecByProcInst(procInstID int) (*Execution, error) {
	var p = &Execution{}
	err := db.Where("proc_inst_id=?", procInstID).Find(p).Error
	// log.Printf("procdef:%v,err:%v", p, err)
	if err == gorm.ErrRecordNotFound {
		return nil, nil
	}
	if err != nil || p == nil {
		return nil, err
	}
	return p, nil
}

// GetExecNodeInfosByProcInstID 根据流程实例procInstID查询执行流经过的所有节点信息
func GetExecNodeInfosByProcInstID(procInstID int) (string, error) {
	var e = &Execution{}
	err := db.Select("node_infos").Where("proc_inst_id=?", procInstID).Find(e).Error
	if err != nil {
		var datas = &ExecutionHistory{}
		if fmt.Sprintf("%s", err) == "record not found" {
			err = db.Select("node_infos").Where("proc_inst_id=?", procInstID).Find(datas).Error
			if err != nil {
				return "", err
			}
			strjson, _ := util.ToJSONStr(datas)
			util.Str2Struct(strjson, e)
		}
	}
	return e.NodeInfos, nil
}

// ExistsExecByProcInst 指定流程实例的执行流是否已经存在
func ExistsExecByProcInst(procInst int) (bool, error) {
	e, err := GetExecByProcInst(procInst)
	// var p = &Execution{}
	// err := db.Where("proc_inst_id=?", procInst).Find(p).RecordNotFound
	// log.Printf("errnotfound:%v", err)
	if e != nil {
		return true, nil
	}
	if err != nil {
		return false, err
	}
	return false, nil
}
