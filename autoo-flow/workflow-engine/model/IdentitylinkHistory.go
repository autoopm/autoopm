package model

import (
	"fmt"

	"github.com/jinzhu/gorm"
)

// IdentitylinkHistory
type IdentitylinkHistory struct {
	Identitylink
}

// CopyIdentitylinkToHistoryByProcInstID
func CopyIdentitylinkToHistoryByProcInstID(procInstID int, tx *gorm.DB) error {
	return tx.Exec(fmt.Sprintf("insert into %sidentitylink_history select * from %sidentitylink where proc_inst_id=?", conf.DbPrefix, conf.DbPrefix), procInstID).Error
}

// FindParticipantHistoryByProcInstID
func FindParticipantHistoryByProcInstID(procInstID int) ([]*IdentitylinkHistory, error) {
	var datas []*IdentitylinkHistory
	err := db.Select("id,user_id,step,comment").Where("proc_inst_id=? and type=?", procInstID, IdentityTypes[PARTICIPANT]).Order("id asc").Find(&datas).Error
	return datas, err
}
