package model

import (
	"fmt"

	"github.com/jinzhu/gorm"
)

// TaskHistory
type TaskHistory struct {
	Task
}

// CopyTaskToHistoryByProInstID 根据procInstID查询结果，并将结果复制到task_history表
func CopyTaskToHistoryByProInstID(procInstID int, tx *gorm.DB) error {
	return tx.Exec(fmt.Sprintf("insert into %stask_history select * from %stask where proc_inst_id=?", conf.DbPrefix, conf.DbPrefix), procInstID).Error
}
