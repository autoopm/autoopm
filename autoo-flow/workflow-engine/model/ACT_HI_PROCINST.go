package model

import (
	"fmt"
	"strconv"
	"strings"
	"sync"
	"workflow/util"

	"github.com/jinzhu/gorm"
)

// ProcInst 流程实例
type ProcInst struct {
	Model
	ProcDefID     int    `gorm:"not null;default:0;comment:'流程定义ID'" json:"procDefId"`
	ProcDefName   string `gorm:"comment:'流程定义名'" json:"procDefName"`
	Title         string `gorm:"comment:'标题'" json:"title,omitempty"`
	DepartmentId  string `gorm:"comment:'用户部门ID'" json:"departmentId"`
	Department    string `gorm:"comment:'用户部门'" json:"department"`
	Company       string `gorm:"comment:'用户公司'" json:"company"`
	NodeID        string `gorm:"comment:'当前节点'" json:"nodeID"`
	Candidate     string `gorm:"comment:'审批人'" json:"candidate"`
	TaskID        int    `gorm:"comment:'当前任务'" json:"taskID"`
	StartTime     string `gorm:"comment:'开始时间'" json:"startTime"`
	EndTime       string `gorm:"comment:'结束时间'" json:"endTime"`
	Duration      int64  `gorm:"comment:'持续时间'" json:"duration"`
	StartUserID   string `gorm:"comment:'开始用户ID'" json:"startUserId"`
	StartUserName string `gorm:"comment:'开始用户名'" json:"startUserName"`
	IsFinished    bool   `gorm:"default:false;comment:'是否完成'" json:"isFinished"`
	Var           string `gorm:"size:4000;comment:'执行流程的附加参数'" json:"var"`
	State         int    `gorm:"not null;default:0;comment:'当前状态: 0待审批，1审批中，2通过，3拒绝，4撤回'" json:"state"`
	LatestComment string `gorm:"size:500;comment:'最新评论'" json:"latestComment"`
	GlobalComment string `gorm:"type:text;charset=utf8mb4;default:null;comment:'全局评论'" json:"globalComment"`
}

type ProcInstUnion struct {
	*ProcInst
	Total int
}

// GroupsNotNull 候选组
func GroupsNotNull(groups []string, sql string) func(db *gorm.DB) *gorm.DB {
	if len(groups) > 0 {
		return func(db *gorm.DB) *gorm.DB {
			return db.Or("candidate in (?) and "+sql, groups)
		}
	}
	return func(db *gorm.DB) *gorm.DB {
		return db
	}
}

// DepartmentsNotNull 分管部门
func DepartmentsNotNull(departments []string, sql string) func(db *gorm.DB) *gorm.DB {
	if len(departments) > 0 {
		return func(db *gorm.DB) *gorm.DB {
			return db.Or("department in (?) and candidate=? and "+sql, departments, IdentityTypes[MANAGER])
		}
	}
	return func(db *gorm.DB) *gorm.DB {
		return db
	}
}

// FindAllProcIns 查询所有流程实例
func FindAllProcIns(userID, procDefName string, state int, startTime string, endTime string, isFinished int, username string) ([]*ProcInst, int, error) {
	maps := map[string]interface{}{
		"start_user_id": userID,
		"proc_def_name": procDefName,
		"state":         state,
		"start_time":    startTime,
		"end_time":      endTime,
		"is_finished":   isFinished,
		"username":      username,
	}
	return findProcInstAll(maps, 0, 0)
}

// StartByMyselfAll 查询我的所有流程实例
func StartByMyselfAll(userID, procDefName string, state, pageIndex, pageSize int, username string) ([]*ProcInst, int, error) {
	maps := map[string]interface{}{
		"start_user_id": userID,
		"proc_def_name": procDefName,
		"state":         state,
		"username":      username,
	}
	return findProcInstAll(maps, pageIndex, pageSize)
}

// findProcInstAll 查询所有流程实例
func findProcInstAll(maps map[string]interface{}, pageIndex, pageSize int) ([]*ProcInst, int, error) {
	// 定义一个结构体来存储联合查询结果
	var datas []*ProcInst
	var userID int
	userID, _ = strconv.Atoi(maps["start_user_id"].(string))
	// 获取联合查询结果和总数
	var procInstUnion []*ProcInstUnion
	query := `
		SELECT *, COUNT(*) OVER() AS total FROM (
			SELECT * FROM ` + conf.DbPrefix + `proc_inst
			UNION ALL
			SELECT * FROM ` + conf.DbPrefix + `proc_inst_history
		) AS proc_inst_union
	`
	args := []interface{}{}
	// 拼接查询条件
	query += " WHERE 1 = 1"
	if maps["start_user_id"] != "" {
		query += " and start_user_id = ?"
		args = append(args, userID)
	}
	if maps["proc_def_name"] != "" {
		query += " and proc_def_name = ?"
		args = append(args, maps["proc_def_name"])
	}
	if maps["state"] != 0 {
		query += " and state = ?"
		args = append(args, maps["state"])
	}
	// 判断is_finished存在就执行
	if maps["is_finished"] == 0 || maps["is_finished"] == 1 {
		query += " and is_finished = ?"
		args = append(args, maps["is_finished"])
	}
	// 用户名称模糊查询
	if maps["username"] != "" {
		query += " and start_user_name like ?"
		args = append(args, "%"+maps["username"].(string)+"%")
	}
	// 判断开始和结束时间是否存在，如果存在则查询时间段内的数据
	if maps["start_user_id"] == "" && maps["start_time"] != "" && maps["end_time"] != "" {
		query += " AND JSON_UNQUOTE(JSON_EXTRACT(var, '$.startTime')) <= ?"
		query += " AND JSON_UNQUOTE(JSON_EXTRACT(var, '$.endTime')) >= ?"
		args = append(args, maps["end_time"], maps["start_time"])
	}
	// 判断分页参数是否存在,如果不存在则不分页
	if pageIndex > 0 && pageSize > 0 {
		query += " ORDER BY start_time DESC LIMIT ? OFFSET ?"
		args = append(args, pageSize, (pageIndex-1)*pageSize)
	} else {
		query += " ORDER BY start_time ASC "
	}
	db.Raw(query, args...).Scan(&procInstUnion)
	// 判断是否有数据
	if len(procInstUnion) == 0 {
		return nil, 0, nil
	}
	// 将 ProcInstUnion 转换成 ProcInst
	for _, union := range procInstUnion {
		datas = append(datas, &ProcInst{
			Model:         union.Model,
			ProcDefID:     union.ProcDefID,
			ProcDefName:   union.ProcDefName,
			Title:         union.Title,
			DepartmentId:  union.DepartmentId,
			Department:    union.Department,
			Company:       union.Company,
			NodeID:        union.NodeID,
			Candidate:     union.Candidate,
			TaskID:        union.TaskID,
			StartTime:     union.StartTime,
			EndTime:       union.EndTime,
			Duration:      union.Duration,
			StartUserID:   union.StartUserID,
			StartUserName: union.StartUserName,
			IsFinished:    union.IsFinished,
			Var:           union.Var,
			State:         union.State,
			LatestComment: union.LatestComment,
		})
	}
	// 返回
	return datas, procInstUnion[0].Total, nil
}

// StartByMyself 我发起的流程
func StartByMyself(userID, company string, pageIndex, pageSize int) ([]*ProcInst, int, error) {
	maps := map[string]interface{}{
		"start_user_id": userID,
		"company":       company,
	}
	return findProcInsts(maps, pageIndex, pageSize)
}

// findProcInsts 查询我发起的流程实例（审核中）
func findProcInsts(maps map[string]interface{}, pageIndex, pageSize int) ([]*ProcInst, int, error) {
	var datas []*ProcInst
	var count int
	selectDatas := func(in chan<- error, wg *sync.WaitGroup) {
		go func() {
			err := db.Where(maps).Offset((pageIndex - 1) * pageSize).Limit(pageSize).Order("start_time desc").Find(&datas).Error
			in <- err
			wg.Done()
		}()
	}
	selectCount := func(in chan<- error, wg *sync.WaitGroup) {
		err := db.Model(&ProcInst{}).Where(maps).Count(&count).Error
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

// FindProcInstByID 根据ID查询流程实例
func FindProcInstByID(id int) (*ProcInst, error) {
	var data = &ProcInst{}
	err := db.Where("id=?", id).Find(data).Error
	if err != nil {
		if fmt.Sprintf("%s", err) == "record not found" {
			var datas = &ProcInstHistory{}
			err = db.Where("id=?", id).Find(datas).Error
			if err != nil {
				return nil, err
			}
			strjson, _ := util.ToJSONStr(datas)
			util.Str2Struct(strjson, data)
		}
	}
	return data, nil
}

// FindProcNotify 查询抄送我的流程
func FindProcNotify(userID, procName, company string, groups []string, sort string, pageIndex, pageSize int) ([]*ProcInst, int, error) {
	var datas []*ProcInst
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
		sql = "SELECT proc_inst_id FROM %sidentitylink i WHERE i.type='notifier' AND i.company= ? AND (FIND_IN_SET(?, i.user_id) OR i.group IN (" + strings.Join(placeholders, ",") + "))"
		values = append(values, company, userID)
		for _, group := range groups {
			values = append(values, group)
		}
	} else {
		sql = "SELECT proc_inst_id FROM %sidentitylink i WHERE i.type='notifier' AND i.company= ? AND FIND_IN_SET(?, i.user_id)"
		values = append(values, company, userID)
	}
	if procName != "" {
		sql += " AND proc_def_name = ?"
		values = append(values, procName)
	}
	sql = fmt.Sprintf(sql, conf.DbPrefix)
	err := db.Where("id in ("+sql+")", values...).Offset((pageIndex - 1) * pageSize).Limit(pageSize).Order(order).Find(&datas).Error
	if err != nil {
		return datas, count, err
	}
	err = db.Model(&ProcInst{}).Where("id in ("+sql+")", values...).Count(&count).Error
	if err != nil {
		return nil, count, err
	}
	return datas, count, err
}

// FindProcInsts 分页查询
func FindProcInsts(userID, procName, company string, groups, departments []string, sort string, pageIndex, pageSize int, username string) ([]*ProcInst, int, error) {
	var datas []*ProcInst
	var count int
	var order string
	var sql = " company = '" + company + "' and is_finished = 0 "
	if len(procName) > 0 {
		sql += "and proc_def_name='" + procName + "'"
	}
	// 用户名模糊查询
	if len(username) > 0 {
		sql += " and start_user_name like '%" + username + "%'"
	}

	// 判断排序
	if sort == "asc" {
		order = "start_time asc"
	} else {
		order = "start_time desc"
	}
	// fmt.Println(sql)
	selectDatas := func(in chan<- error, wg *sync.WaitGroup) {
		go func() {
			err := db.Scopes(GroupsNotNull(groups, sql), DepartmentsNotNull(departments, sql)).
				Or("find_in_set(?,candidate) and "+sql, userID).
				Offset((pageIndex - 1) * pageSize).Limit(pageSize).
				Order(order).
				Find(&datas).Error
			in <- err
			wg.Done()
		}()
	}
	selectCount := func(in chan<- error, wg *sync.WaitGroup) {
		go func() {
			err := db.Scopes(GroupsNotNull(groups, sql), DepartmentsNotNull(departments, sql)).Model(&ProcInst{}).Or("candidate=? and "+sql, userID).Count(&count).Error
			in <- err
			wg.Done()
		}()
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

// FindProcInsts 查询总数
func FindProcInstsTotal(userId string) int {
	var count int
	db.Model(&ProcInst{}).Or("candidate=? and is_finished=0", userId).Count(&count)
	return count
}

// Save
func (p *ProcInst) Save() (int, error) {
	err := db.Create(p).Error
	if err != nil {
		return 0, err
	}
	return p.ID, nil
}

// SaveTx 事务保存
func (p *ProcInst) SaveTx(tx *gorm.DB) (int, error) {
	if err := tx.Create(p).Error; err != nil {
		tx.Rollback()
		return 0, err
	}
	return p.ID, nil
}

// DelProcInstByID 删除流程实例
func DelProcInstByID(id int) error {
	return db.Where("id=?", id).Delete(&ProcInst{}).Error
}

// DelProcInstByIDTx 事务
func DelProcInstByIDTx(id int, tx *gorm.DB) error {
	return tx.Where("id=?", id).Delete(&ProcInst{}).Error
}

// UpdateTx 更新
func (p *ProcInst) UpdateTx(tx *gorm.DB) error {
	return tx.Model(&ProcInst{}).Updates(p).Error
}

// FindFinishedProc 查询已完成的流程
func FindFinishedProc() ([]*ProcInst, error) {
	var datas []*ProcInst
	err := db.Where("is_finished=1").Find(&datas).Error
	return datas, err
}

// UpdateProcInstByID 更新流程实例
func UpdateProcInstByID(id int, data map[string]interface{}) error {
	// 先找审核中表的数据，如果没有则去结束表找
	var procInst ProcInst
	err := db.Where("id=?", id).First(&procInst).Error
	if err != nil {
		// 如果没有找到，则去结束表找
		var procInstHistory ProcInstHistory
		err = db.Where("id=?", id).First(&procInstHistory).Error
		if err != nil {
			return err
		}
		err = db.Model(&ProcInstHistory{}).Where("id=?", id).Updates(data).Error
		if err != nil {
			return err
		}
	}
	err = db.Model(&ProcInst{}).Where("id=?", id).Updates(data).Error
	if err != nil {
		return err
	}
	return nil

}
