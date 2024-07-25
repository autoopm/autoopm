package model

import (
	"fmt"
	"sort"
	"strings"
	"sync"
	"time"

	"github.com/jinzhu/gorm"
)

// ProcInstHistory
type ProcInstHistory struct {
	ProcInst
}

// StartHistoryByMyself 查询我发起的流程
func StartHistoryByMyself(userID, company string, pageIndex, pageSize int) ([]*ProcInstHistory, int, error) {
	maps := map[string]interface{}{
		"start_user_id": userID,
		"company":       company,
	}
	return findProcInstsHistory(maps, pageIndex, pageSize)
}
func findProcInstsHistory(maps map[string]interface{}, pageIndex, pageSize int) ([]*ProcInstHistory, int, error) {
	var datas []*ProcInstHistory
	var count int
	selectDatas := func(in chan<- error, wg *sync.WaitGroup) {
		go func() {
			err := db.Where(maps).Offset((pageIndex - 1) * pageSize).Limit(pageSize).Order("start_time desc").Find(&datas).Error
			in <- err
			wg.Done()
		}()
	}
	selectCount := func(in chan<- error, wg *sync.WaitGroup) {
		err := db.Model(&ProcInstHistory{}).Where(maps).Count(&count).Error
		in <- err
		wg.Done()
	}
	var err1 error
	var wg sync.WaitGroup
	numberOfRoutine := 2
	wg.Add(numberOfRoutine)
	errStream := make(chan error, numberOfRoutine)
	// defer fmt.Println("close channel")
	selectDatas(errStream, &wg)
	selectCount(errStream, &wg)
	wg.Wait()
	defer close(errStream) // 关闭通道
	for i := 0; i < numberOfRoutine; i++ {
		// log.Printf("send: %v", <-errStream)
		if err := <-errStream; err != nil {
			err1 = err
		}
	}
	// fmt.Println("结束")
	return datas, count, err1
}

// FindProcHistory 查询历史纪录
func FindProcHistory(userID, procName, company string, sortStr string, pageIndex, pageSize int, username string) ([]*ProcInstHistory, int, error) {
	var datas []*ProcInstHistory
	var count int
	var err1 error
	var order string
	// 判段排序
	if sortStr == "asc" {
		order = "start_time asc"
	} else {
		order = "start_time desc"
	}

	wg := sync.WaitGroup{}
	wg.Add(2)
	errStream := make(chan error, 2)

	go func() {
		defer wg.Done()
		dbQuery := db.Where(fmt.Sprintf("id in (select distinct proc_inst_id from %sidentitylink_history where company=? and user_id=?)", conf.DbPrefix), company, userID)

		if procName != "" {
			dbQuery = dbQuery.Where("proc_def_name = ?", procName)
		}
		// 用户名模糊查询
		if username != "" {
			dbQuery = dbQuery.Where("start_user_name LIKE ?", "%"+username+"%")
		}
		err := dbQuery.Offset((pageIndex - 1) * pageSize).Limit(pageSize).
			Order(order).Find(&datas).Error
		errStream <- err
	}()

	go func() {
		defer wg.Done()

		dbQuery := db.Model(&ProcInstHistory{})
		dbQuery = dbQuery.Where(fmt.Sprintf("id in (select distinct proc_inst_id from %sidentitylink_history where company=? and user_id=?)", conf.DbPrefix), company, userID)
		if procName != "" {
			dbQuery = dbQuery.Where("proc_def_name = ?", procName)
		}
		// 用户名模糊查询
		if username != "" {
			dbQuery = dbQuery.Where("start_user_name LIKE ?", "%"+username+"%")
		}
		err := dbQuery.Count(&count).Error
		errStream <- err
	}()

	wg.Wait()
	close(errStream)

	for err := range errStream {
		if err != nil {
			err1 = err
		}
	}

	// 查询包含历史表(identitylink_history)中的数据外，还需要查询现在表（identitylink）的数据是否有我参与审核通过（字段state=1为通过）的数据
	var datas2 []*ProcInst
	dbQuery := db.Where(fmt.Sprintf("id in (select distinct proc_inst_id from %sidentitylink where company=? and user_id=? and step>0 and state=1)", conf.DbPrefix), company, userID)
	if procName != "" {
		dbQuery = dbQuery.Where("proc_def_name = ?", procName)
	}
	// 用户名模糊查询
	if username != "" {
		dbQuery = dbQuery.Where("start_user_name LIKE ?", "%"+username+"%")
	}
	err := dbQuery.Offset((pageIndex - 1) * pageSize).Limit(pageSize).Order(order).Find(&datas2).Error
	if err != nil {
		err1 = err
	}

	// 判断为空，把现在表中的数据加入到历史表中的数据中
	if len(datas2) > 0 {
		// 将 datas2 中的数据加入到 datas 中
		for _, v := range datas2 {
			var data ProcInstHistory
			data.ProcInst = *v
			datas = append(datas, &data)
		}
		// 将 ProcInst.StartTime 转换为 time.Time 类型，然后按照时间排序
		sort.Slice(datas, func(i, j int) bool {
			t1, _ := time.Parse("2006-01-02 15:04:05", datas[i].ProcInst.StartTime)
			t2, _ := time.Parse("2006-01-02 15:04:05", datas[j].ProcInst.StartTime)
			if sortStr == "asc" {
				return t1.Before(t2)
			} else {
				return t1.After(t2)
			}
		})
		// count 加上 datas2 的长度
		count += len(datas2)
	}

	return datas, count, err1
}

// SaveProcInstHistory
func SaveProcInstHistory(p *ProcInst) error {
	return db.Table(conf.DbPrefix + "proc_inst_history").Create(p).Error
}

// DelProcInstHistoryByID
func DelProcInstHistoryByID(id int) error {
	return db.Where("id=?", id).Delete(&ProcInstHistory{}).Error
}

// SaveProcInstHistoryTx
func SaveProcInstHistoryTx(p *ProcInst, tx *gorm.DB) error {
	return tx.Table(conf.DbPrefix + "proc_inst_history").Create(p).Error
}

// FindProcHistoryNotify 查询抄送我的历史纪录
func FindProcHistoryNotify(userID, procName, company string, groups []string, sort string, pageIndex, pageSize int, username string) ([]*ProcInstHistory, int, error) {
	var datas []*ProcInstHistory
	var count int
	var sql string
	var values []interface{}
	var order string
	// 判断排序
	if sort == "asc" {
		order = "start_time asc"
	} else {
		order = "start_time desc"
	}
	if len(groups) != 0 {
		var placeholders []string
		for range groups {
			placeholders = append(placeholders, "?")
		}
		sql = "SELECT proc_inst_id FROM %sidentitylink_history WHERE type='notifier' AND company=? AND (FIND_IN_SET(?, user_id) OR `group` IN (" + strings.Join(placeholders, ",") + "))"
		values = append(values, company, userID)
		for _, group := range groups {
			values = append(values, group)
		}
	} else {
		sql = "SELECT proc_inst_id FROM %sidentitylink_history WHERE type='notifier' AND company=? AND FIND_IN_SET(?, user_id)"
		values = append(values, company, userID)
	}
	if procName != "" {
		sql += " AND proc_def_name = ?"
		values = append(values, procName)
	}
	// 用户名模糊查询
	if username != "" {
		sql += " AND start_user_name LIKE ?"
		values = append(values, "%"+username+"%")
	}

	sql = fmt.Sprintf(sql, conf.DbPrefix)
	err := db.Where("id in ("+sql+")", values...).Offset((pageIndex - 1) * pageSize).Limit(pageSize).Order(order).Find(&datas).Error
	if err != nil {
		return datas, count, err
	}
	err = db.Model(&ProcInstHistory{}).Where("id in ("+sql+")", values...).Count(&count).Error
	if err != nil {
		return nil, count, err
	}
	return datas, count, err
}

// GetProcInstByStarUserIDAndTime 获取申请用户ID在当前时间之前的流程实例
func GetProcInstByStarUserIDAndTime(StartUserID int) (*ProcInstHistory, error) {
	var data ProcInstHistory
	nowFormat := time.Now().Format("2006-01-02 15:04:05")
	err := db.Where("start_user_id=?", StartUserID).
		Where("JSON_UNQUOTE(JSON_EXTRACT(var, '$.startTime')) <= ?", nowFormat).
		Where("JSON_UNQUOTE(JSON_EXTRACT(var, '$.endTime')) >= ?", nowFormat).
		Where("proc_def_name LIKE '%请假%' OR proc_def_name LIKE '%外出%'").
		Where("state = 2").
		Limit(1).
		Find(&data).Error
	if err != nil {
		return nil, err
	}
	return &data, nil
}
