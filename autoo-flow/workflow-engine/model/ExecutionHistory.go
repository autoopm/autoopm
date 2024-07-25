package model

import (
	"fmt"

	"github.com/jinzhu/gorm"
)

// ExecutionHistory 执行流历史纪录
type ExecutionHistory struct {
	Execution
}

// CopyExecutionToHistoryByProcInstIDTx 根据流程实例ID复制执行流到历史纪录
func CopyExecutionToHistoryByProcInstIDTx(procInstID int, tx *gorm.DB) error {
	return tx.Exec(fmt.Sprintf("insert into %sexecution_history select * from %sexecution where proc_inst_id=?", conf.DbPrefix, conf.DbPrefix), procInstID).Error
}
