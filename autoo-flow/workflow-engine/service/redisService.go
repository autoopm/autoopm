package service

import (
	"workflow/util"

	"workflow/workflow-engine/model"
)

// UserInfo 用户信息
type UserInfo struct {
	Company     string   `json:"company"`
	Department  string   `json:"department"` // 用户所属部门
	Username    string   `json:"username"`
	ID          string   `json:"ID"`
	Roles       []string `json:"roles"`       // 用户的角色
	Departments []string `json:"departments"` // 用户负责的部门
}

// GetUserinfoFromRedis 从redis获取用户信息
func GetUserinfoFromRedis(token string) (*UserInfo, error) {
	result, err := GetValFromRedis(token)
	if err != nil {
		return nil, err
	}
	// fmt.Println(result)
	var userinfo = &UserInfo{}
	err = util.Str2Struct(result, userinfo)
	if err != nil {
		return nil, err
	}
	return userinfo, nil
}

// GetValFromRedis 从redis获取值
func GetValFromRedis(key string) (string, error) {
	return model.RedisGetVal(key)
}
