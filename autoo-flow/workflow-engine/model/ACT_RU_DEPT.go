package model

import "time"

// 部门结构体 user_departments 包括【id, name, dialog_id, parent_id, owner_userid, created_at, updated_at】
//type UserDepartments struct {
//	Id          int    `json:"id"`
//	Name        string `json:"name"`
//	DialogId    string `json:"dialog_id"`
//	ParentId    int    `json:"parent_id"`
//	OwnerUserid string `json:"owner_userid"`
//	CreatedAt   string `json:"created_at"`
//	UpdatedAt   string `json:"updated_at"`
//}

// 部门结构体
type SysOffice struct {
	ID         string    `json:"id" gorm:"id"`                   // 主键
	Name       string    `json:"name" gorm:"name"`               // 名称
	Type       string    `json:"type" gorm:"type"`               // 类型
	Code       string    `json:"code" gorm:"code"`               // 组织机构编码
	Pid        string    `json:"pid" gorm:"pid"`                 // 父id
	Sort       int64     `json:"sort" gorm:"sort"`               // 排序
	IsDel      int64     `json:"is_del" gorm:"is_del"`           // 删除标识
	CreateBy   string    `json:"create_by" gorm:"create_by"`     // 创建人
	CreateDate time.Time `json:"create_date" gorm:"create_date"` // 创建日期
	UpdateBy   string    `json:"update_by" gorm:"update_by"`     // 更新人
	UpdateDate time.Time `json:"update_date" gorm:"update_date"` // 更新日期
}

// SysRole 角色表
type SysRole struct {
	ID         string    `json:"id" gorm:"id"`                   // 主键
	Type       string    `json:"type" gorm:"type"`               // 类型
	Name       string    `json:"name" gorm:"name"`               // 角色名称
	Code       string    `json:"code" gorm:"code"`               // 角色编码
	Permission string    `json:"permission" gorm:"permission"`   // 0：全部，1：自定义，2：本级级子级，3：本级
	Sort       int64     `json:"sort" gorm:"sort"`               // 排序
	DescRibe   string    `json:"desc_ribe" gorm:"desc_ribe"`     // 描述
	IsDel      int64     `json:"is_del" gorm:"is_del"`           // 是否删除：0未删除，1已删除
	CreateBy   string    `json:"create_by" gorm:"create_by"`     // 创建人
	CreateDate time.Time `json:"create_date" gorm:"create_date"` // 创建时间
	UpdateBy   string    `json:"update_by" gorm:"update_by"`     // 更新人
	UpdateDate time.Time `json:"update_date" gorm:"update_date"` // 更新时间
}

// SysUserRole 用户与角色关联表
type SysUserRole struct {
	UserId string `json:"user_id" gorm:"user_id"` // 用户id
	RoleId string `json:"role_id" gorm:"role_id"` // 角色id
}

// 用户结构体 users 包括【userid, identity, department, nickname, profession, userimg, created_at, updated_at】
//type Users struct {
//	Userid     string `json:"userid"`
//	Identity   string `json:"identity"`
//	Department string `json:"department"`
//	Nickname   string `json:"nickname"`
//	Email      string `json:"email"`
//	Profession string `json:"profession"`
//	Userimg    string `json:"userimg"`
//	CreatedAt  string `json:"created_at"`
//	UpdatedAt  string `json:"updated_at"`
//}

// 用户结构体
type SysUser struct {
	ID           string    `json:"id" gorm:"id"`                       // 主键
	Username     string    `json:"username" gorm:"username"`           // 登录名
	Name         string    `json:"name" gorm:"name"`                   // 姓名/昵称
	Password     string    `json:"password" gorm:"password"`           // 密码
	Status       string    `json:"status" gorm:"status"`               // 状态
	Phone        string    `json:"phone" gorm:"phone"`                 // 手机号
	HeadPortrait string    `json:"head_portrait" gorm:"head_portrait"` // 头像
	IsLogin      int64     `json:"is_login" gorm:"is_login"`           // 禁止登录：0未禁用，1已禁用
	Sort         int64     `json:"sort" gorm:"sort"`                   // 排序
	OfficeId     string    `json:"office_id" gorm:"office_id"`         // 组织机构id
	IsDel        int64     `json:"is_del" gorm:"is_del"`               // 删除标识：0未删除，1已删除
	CreateBy     string    `json:"create_by" gorm:"create_by"`         // 创建人
	CreateDate   time.Time `json:"create_date" gorm:"create_date"`     // 创建时间
	UpdateBy     string    `json:"update_by" gorm:"update_by"`         // 更新人
	UpdateDate   time.Time `json:"update_date" gorm:"update_date"`     // 更新时间
	Office       SysOffice `gorm:"foreignKey:OfficeId"`                //外键关联部门表
}

// GetAllDept 所有部门列表
func GetAllDept(parentId string) ([]*SysOffice, error) {
	var datas []*SysOffice
	dbModel := db
	if parentId != "" {
		dbModel = dbModel.Where("pid=?", parentId)
	}
	err := dbModel.Find(&datas).Error
	return datas, err
}

// GetDeptByParentID 根据父级部门ID获取子部门列表
func GetDeptByParentID(parentID string) ([]*SysOffice, error) {
	var datas []*SysOffice
	err := db.Where("pid=?", parentID).Find(&datas).Error
	return datas, err
}

// GetDeptByID 根据部门ID获取部门信息
func GetDeptByID(deptID string) (*SysOffice, error) {
	var data SysOffice
	err := db.Where("id=?", deptID).Find(&data).Error
	return &data, err
}

// GetDeptByID 根据部门ID获取指定层级的部门信息
func GetDeptLevelByID(deptID string, level int) (*SysOffice, error) {
	var datas []*SysOffice
	err := db.Find(&datas).Error
	//TODO
	datas = getDeptTreeList(datas, deptID)
	for i, data := range datas {
		if level == i+1 {
			return data, nil
		}
	}
	return nil, err
}

// GetDeptManagerByDeptId 根据部门id获得部门负责人岗位的人员id
func GetDeptManagerByDeptId(deptID string) (string, error) {
	var user *SysUser
	err := db.Table("sys_user").
		Select("sys_user.id").
		Joins("JOIN sys_user_role ON sys_user.id = sys_user_role.user_id").
		Joins("JOIN sys_role ON sys_user_role.role_id = sys_role.id").
		Joins("JOIN sys_office ON sys_user.office_id = sys_office.id").
		Where("sys_role.type = ?", "dept").
		Where("sys_office.id = ?", deptID).
		Scan(&user).Error
	return user.ID, err
}

// GetDeptByID 根据部门ID获取树列表
func GetDeptTreeList(deptID string) ([]*SysOffice, error) {
	var datas []*SysOffice
	err := db.Find(&datas).Error
	datas = getDeptTreeList(datas, deptID)
	return datas, err
}

// getDeptTreeList 获取树列表
func getDeptTreeList(nodes []*SysOffice, ParentId string) []*SysOffice {
	var result []*SysOffice
	for _, node := range nodes {
		if node.ID == ParentId {
			result = append(result, node)
			childrens := getDeptTreeList(nodes, node.Pid)
			for _, children := range childrens {
				result = append(result, children)
			}
		}
	}
	return result
}

// GetUsersByDept 根据部门名称获取用户列表  TODO 这里要改成部门id
func GetUsersByDept(deptName string) ([]*SysUser, error) {
	var datas []*SysUser
	//err := db.Where("department=?", deptName).Find(&datas).Error
	err := db.Preload("Office", "name = ?", deptName).Find(&datas).Error
	return datas, err
}

// GetUsersByDeptNames 根据多个部门名称获取用户列表
func GetUsersByDeptNames(deptNames []string) ([]*SysUser, error) {
	var datas []*SysUser
	err := db.Preload("Office", "name IN (?)", deptNames).Find(&datas).Error
	//err := db.Where("department in (?)", deptNames).Find(&datas).Error
	return datas, err
}

// GetUsersByDeptIds 根据部门id获取用户列表，使用find_in_set函数查询
func GetUsersByDeptId(deptId string) ([]*SysUser, error) {
	var datas []*SysUser
	modelDb := db.Where("is_del = 0 ")
	//这里系统不给在多个部门任职，所有直接查就可以了
	if deptId != "" {
		modelDb = modelDb.Where("office_id = ?", deptId)
		//modelDb = modelDb.Where("find_in_set(?,department)", deptId)
	} else {
		//这里不需要操作
		//modelDb = modelDb.Where("(department=? or department=?)", "", ",,")
	}
	err := modelDb.Find(&datas).Error
	return datas, err
}

// GetUserByName 根据用户名称获取用户并分页
func GetUserByName(name string, page, pageSize int) ([]*SysUser, error) {
	var datas []*SysUser
	err := db.Where("is_del = 0 and (username like ? or name like ?)", "%"+name+"%", "%"+name+"%").Limit(pageSize).Offset((page - 1) * pageSize).Find(&datas).Error
	return datas, err
}

// GetUserByNameCount 根据用户名称获取用户总数
func GetUserByNameCount(name string) (int, error) {
	var count int
	err := db.Model(&SysUser{}).Where("is_del = 0 and (username like ? or name like ?)", "%"+name+"%", "%"+name+"%").Count(&count).Error
	return count, err
}

// GetUserDeptById 根据用户id获取用户部门
func GetUserDeptById(id string) ([]*SysUser, error) {
	var datas []*SysUser
	err := db.Preload("Office").First(&datas, id).Error
	//err := db.Model(&Users{}).Where("userid=?", id).Find(&datas).Error
	return datas, err
}

// GetUserInfoById 根据用户id获取用户信息
func GetUserInfoById(id string) (*SysUser, error) {
	var datas SysUser
	err := db.Model(&SysUser{}).Where("is_del = 0 and id = ?", id).Find(&datas).Error
	return &datas, err
}
