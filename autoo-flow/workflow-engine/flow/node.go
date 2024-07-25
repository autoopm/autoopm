package flow

import (
	"container/list"
	"errors"
	"strconv"
	"strings"

	"workflow/util"
	"workflow/workflow-engine/model"
	"workflow/workflow-engine/types"
)

// ActionConditionType 条件类型
type ActionConditionType int

const (
	RANGE ActionConditionType = iota // RANGE 条件类型: 范围
	VALUE                            // VALUE 条件类型： 值
)

// ActionConditionTypes 所有条件类型
var ActionConditionTypes = [...]string{RANGE: "dingtalk_actioner_range_condition", VALUE: "dingtalk_actioner_value_condition"}

// NodeType 节点类型
type NodeType int

const (
	// START 类型start
	START NodeType = iota
	ROUTE
	CONDITION
	APPROVER
	NOTIFIER
)

// ActionRuleType 审批人类型
type ActionRuleType int

const (
	MANAGER ActionRuleType = iota
	LABEL
)

// NodeTypes 节点类型
var NodeTypes = [...]string{START: "start", ROUTE: "route", CONDITION: "condition", APPROVER: "approver", NOTIFIER: "notifier"}
var actionRuleTypes = [...]string{MANAGER: "target_management", LABEL: "target_label"}

// 级别类型
var DirectorLevelTypes = [...]string{1: "直接主管", 2: "第二级主管", 3: "第三级主管", 4: "第四级主管"}
var ExamineEndDirectorLevelTypes = [...]string{1: "最高层级主管", 2: "第二级主管", 3: "第三级主管", 4: "第四级主管"}

type NodeInfoType int

const (
	STARTER NodeInfoType = iota
)

var NodeInfoTypes = [...]string{STARTER: "starter"}

// Node represents a specific logical unit of processing and routing
// in a workflow.
// 流程中的一个节点
type Node struct {
	Name                    string               `json:"name,omitempty"`                    // 节点名称
	Type                    string               `json:"type,omitempty"`                    // 节点类型，0 发起人 1审批 2抄送 3条件 4路由
	NodeID                  string               `json:"nodeId,omitempty"`                  // 节点id
	PrevID                  string               `json:"prevId,omitempty"`                  // 父级id
	ChildNode               *Node                `json:"childNode,omitempty"`               // 子节点
	ConditionNodes          []*Node              `json:"conditionNodes,omitempty"`          // 条件节点
	ConditionList           []*NodeConditionList `json:"conditionList,omitempty"`           // 条件列表
	Properties              *NodeProperties      `json:"properties,omitempty"`              // 属性
	Settype                 int                  `json:"settype,omitempty"`                 // 审批人设置 1指定成员 2主管 3连续多级主管
	SelectMode              int                  `json:"selectMode,omitempty"`              // 审批人数 1选一个人 2选多个人
	SelectRange             int                  `json:"selectRange,omitempty"`             // 选择范围 1.全公司 2指定成员 2指定角色
	PriorityLevel           int                  `json:"priorityLevel,omitempty"`           // 优先级
	DirectorLevel           int                  `json:"directorLevel,omitempty"`           // 主管级别，1直接主管， 2第二级主管，3第三级主管，4第四级主管，Settype=3才有效
	ExamineEndDirectorLevel int                  `json:"examineEndDirectorLevel,omitempty"` // 最终主管级别
	ExamineMode             int                  `json:"examineMode,omitempty"`             // 多人审批时采用的审批方式 1依次审批，2会签(须所有审批人同意)
	NoHanderAction          int                  `json:"noHanderAction,omitempty"`          // 审批人为空时 1自动审批通过/不允许发起, 2转交给审核管理员
	NodeUserList            []*NodeUser          `json:"nodeUserList,omitempty"`            // 节点用户列表
	CcSelfSelectFlag        int                  `json:"ccSelfSelectFlag"`                  // 允许发起人自选抄送人
}

// 活动规则
type ActionerRule struct {
	Type        string `json:"type,omitempty"`
	LabelNames  string `json:"labelNames,omitempty"`
	Labels      int    `json:"labels,omitempty"`
	IsEmpty     bool   `json:"isEmpty,omitempty"`
	MemberCount int8   `json:"memberCount,omitempty"` // 表示需要通过的人数 如果是会签
	ActType     string `json:"actType,omitempty"`     // and 表示会签 or表示或签，默认为或签
	Level       int8   `json:"level,omitempty"`
	AutoUp      bool   `json:"autoUp,omitempty"`
}

// 节点属性
type NodeProperties struct {
	ActivateType       string             `json:"activateType,omitempty"` // ONE_BY_ONE 代表依次审批
	AgreeAll           bool               `json:"agreeAll,omitempty"`
	Conditions         [][]*NodeCondition `json:"conditions,omitempty"`
	ActionerRules      []*ActionerRule    `json:"actionerRules,omitempty"`
	NoneActionerAction string             `json:"noneActionerAction,omitempty"`
}

// 节点条件
type NodeCondition struct {
	Type            string      `json:"type,omitempty"`
	ParamKey        string      `json:"paramKey,omitempty"`
	ParamLabel      string      `json:"paramLabel,omitempty"`
	IsEmpty         bool        `json:"isEmpty,omitempty"`
	LowerBound      string      `json:"lowerBound,omitempty"` // 类型为range
	LowerBoundEqual string      `json:"lowerBoundEqual,omitempty"`
	UpperBoundEqual string      `json:"upperBoundEqual,omitempty"`
	UpperBound      string      `json:"upperBound,omitempty"`
	BoundEqual      string      `json:"boundEqual,omitempty"`
	Unit            string      `json:"unit,omitempty"`
	ParamValues     []string    `json:"paramValues,omitempty"` // 类型为 value
	OriValue        []string    `json:"oriValue,omitempty"`
	Conds           []*NodeCond `json:"conds,omitempty"`
}

// 节点条件列表
type NodeConditionList struct {
	ColumnId          int    `json:"columnId"`
	Type              int    `json:"type,omitempty"`
	ShowType          string `json:"showType,omitempty"` //显示类型
	ShowName          string `json:"showName,omitempty"` //发起人
	OptType           string `json:"optType,omitempty"`  //选择类型
	Zdy1              string `json:"zdy1,omitempty"`
	Opt1              string `json:"opt1,omitempty"`
	Zdy2              string `json:"zdy2,omitempty"`
	Opt2              string `json:"opt2,omitempty"`
	ColumnDbname      string `json:"columnDbname,omitempty"`
	ColumnType        string `json:"columnType,omitempty"`
	FixedDownBoxValue string `json:"fixedDownBoxValue,omitempty"`
}

// 节点气孔导度
type NodeCond struct {
	Type  string    `json:"type,omitempty"`
	Value string    `json:"value,omitempty"`
	Attrs *NodeUser `json:"attrs,omitempty"`
}

// 节点用户
type NodeUser struct {
	Name     string `json:"name,omitempty"`
	Avatar   string `json:"avatar,omitempty"`
	TargetId string `json:"targetId,omitempty"`
	Type     int    `json:"type,omitempty"`
}

// NodeInfo 节点信息
type NodeInfo struct {
	NodeID                  string      `json:"nodeId"`
	Type                    string      `json:"type"`
	Settype                 int         `json:"settype,omitempty"`
	Aprover                 string      `json:"approver"`
	AproverId               string      `json:"aproverId"`
	AproverType             string      `json:"aproverType"`
	MemberCount             int8        `json:"memberCount"`
	Level                   int8        `json:"level"`
	ActType                 string      `json:"actType"`
	DirectorLevel           int         `json:"directorLevel,omitempty"`           // 主管级别，1直接主管， 2第二级主管，3第三级主管，4第四级主管，Settype=3才有效
	ExamineEndDirectorLevel int         `json:"examineEndDirectorLevel,omitempty"` // 最终主管级别 1直接主管， 2第二级主管，3第三级主管，4第四级主管，Settype=3才有效
	NodeUserList            []*NodeUser `json:"nodeUserList,omitempty"`            // 节点用户列表
}

func (n *Node) add2ExecutionList(list *list.List, userID string, departmentId string) {
	switch n.Type {
	case NodeTypes[APPROVER], NodeTypes[NOTIFIER]: //审核人，抄送人
		// 多人审批时采用的审批方式
		var actType string
		if n.ExamineMode == 1 {
			actType = "and"
		} else {
			actType = "or"
		}

		// 审批人设置
		if n.Settype == 1 {
			var strArr []string
			var strIdArr []string
			for _, user := range n.NodeUserList {
				strArr = append(strArr, user.Name)
				strIdArr = append(strIdArr, user.TargetId)
			}
			aprovers := strings.Join(strArr, ",")
			aproverIds := strings.Join(strIdArr, ",")

			var memberCount int8
			if n.ExamineMode == 1 {
				memberCount = 1
			} else {
				memberCount = int8(len(n.NodeUserList))
			}

			list.PushBack(NodeInfo{
				NodeID:       n.NodeID,
				Type:         n.Type,
				Settype:      n.Settype,
				Aprover:      aprovers,
				AproverId:    aproverIds,
				AproverType:  n.Type,
				Level:        int8(n.DirectorLevel),
				MemberCount:  memberCount,
				ActType:      actType,
				NodeUserList: n.NodeUserList,
			})
		} else if n.Settype == 2 {
			// 主管
			dept, _ := model.GetDeptLevelByID(departmentId, n.DirectorLevel)
			if dept != nil {
				//部门负责人
				ownerUserid, _ := model.GetDeptManagerByDeptId(dept.ID)
				if ownerUserid != "" {
					userInfo, _ := model.GetUserInfoById(ownerUserid)
					if userInfo.ID != "" {
						aprover := userInfo.Name
						if aprover == "" {
							aprover = userInfo.Username
						}
						list.PushBack(NodeInfo{
							NodeID:  n.NodeID,
							Type:    n.Type,
							Settype: n.Settype,
							Aprover: aprover,
							//AproverId:    dept.OwnerUserid, //部门负责人
							AproverId:    userInfo.ID,
							AproverType:  n.Type,
							Level:        int8(n.DirectorLevel),
							MemberCount:  1,
							ActType:      actType,
							NodeUserList: n.NodeUserList,
						})
					}

				}

			}
		} else if n.Settype == 3 {
			//  连续多级主管
			if n.ExamineEndDirectorLevel == 1 {
				n.ExamineEndDirectorLevel = 10
			}
			for i := 0; i < n.ExamineEndDirectorLevel; i++ {
				dept, _ := model.GetDeptLevelByID(departmentId, i+1)
				if dept != nil {
					//根据部门id获取部门负责人id，这里是根绝一个角色实现的
					ownerUserid, _ := model.GetDeptManagerByDeptId(dept.ID)
					if ownerUserid != "" {
						userInfo, _ := model.GetUserInfoById(ownerUserid) //部门负责人
						if userInfo.ID != "" {
							aprover := userInfo.Name
							if aprover == "" {
								aprover = userInfo.Username
							}
							list.PushBack(NodeInfo{
								NodeID:  n.NodeID + strconv.Itoa(i),
								Type:    n.Type,
								Settype: n.Settype,
								Aprover: aprover,
								//AproverId:    dept.OwnerUserid,
								AproverId:    userInfo.ID,
								AproverType:  n.Type,
								Level:        int8(i + 1),
								MemberCount:  1,
								ActType:      actType,
								NodeUserList: n.NodeUserList,
							})
						}

					}

				}
			}
		} else {
			list.PushBack(NodeInfo{
				NodeID:       n.NodeID,
				Type:         n.Type,
				Aprover:      "",
				AproverType:  n.Type,
				Level:        1,
				MemberCount:  int8(len(n.NodeUserList)),
				ActType:      actType,
				NodeUserList: n.NodeUserList,
			})
		}

		break
	default:
	}
}

// IfProcessConifgIsValid 检查流程配置是否有效
func IfProcessConifgIsValid(node *Node) error {
	// 节点名称是否有效
	if len(node.NodeID) == 0 {
		return errors.New("节点的【nodeId】不能为空！！")
	}
	// 检查类型是否有效
	if len(node.Type) == 0 {
		return errors.New("节点【" + node.NodeID + "】的类型【type】不能为空")
	}
	var flag = false
	for _, val := range NodeTypes {
		if val == node.Type {
			flag = true
			break
		}
	}
	if !flag {
		str, _ := util.ToJSONStr(NodeTypes)
		return errors.New("节点【" + node.NodeID + "】的类型为【" + node.Type + "】，为无效类型,有效类型为" + str)
	}
	// 当前节点是否设置有审批人
	// if node.Type == NodeTypes[APPROVER] || node.Type == NodeTypes[NOTIFIER] {
	// 	if node.Properties == nil || node.Properties.ActionerRules == nil {
	// 		return errors.New("节点【" + node.NodeID + "】的Properties属性不能为空，如：`\"properties\": {\"actionerRules\": [{\"type\": \"target_label\",\"labelNames\": \"人事\",\"memberCount\": 1,\"actType\": \"and\"}],}`")
	// 	}
	// }
	// 条件节点是否存在
	if node.ConditionNodes != nil { // 存在条件节点
		if len(node.ConditionNodes) == 1 {
			return errors.New("节点【" + node.NodeID + "】条件节点下的节点数必须大于1")
		}
		// 根据条件变量选择节点索引
		err := CheckConditionNode(node.ConditionNodes)
		if err != nil {
			return err
		}
	}

	// 子节点是否存在
	if node.ChildNode != nil && node.ChildNode.Name != "" {
		return IfProcessConifgIsValid(node.ChildNode)
	}
	return nil
}

// CheckConditionNode 检查条件节点
func CheckConditionNode(nodes []*Node) error {
	for _, node := range nodes {
		// if node.Properties == nil {
		// return errors.New("节点【" + node.NodeID + "】的Properties对象为空值！！")
		// }
		// if len(node.Properties.Conditions) == 0 {
		// 	return errors.New("节点【" + node.NodeID + "】的Conditions对象为空值！！")
		// }
		err := IfProcessConifgIsValid(node)
		if err != nil {
			return err
		}
	}
	return nil
}

// ParseProcessConfig 解析流程定义json数据
func ParseProcessConfig(node *Node, userID string, departmentId string, variable *types.Vars) (*list.List, error) {
	// defer fmt.Println("----------解析结束--------")
	list := list.New()
	err := parseProcessConfig(node, userID, departmentId, variable, list)
	return list, err
}

func parseProcessConfig(node *Node, userID string, departmentId string, variable *types.Vars, list *list.List) (err error) {
	// fmt.Printf("nodeId=%s\n", node.NodeID)
	node.add2ExecutionList(list, userID, departmentId)

	// 存在条件节点
	if node.ConditionNodes != nil {
		// data, _ := util.ToJSONStr(node.ConditionNodes)

		// 如果条件节点只有一个或者条件只有一个，直接返回第一个
		if variable == nil || len(node.ConditionNodes) == 1 {
			err = parseProcessConfig(node.ConditionNodes[0].ChildNode, userID, departmentId, variable, list)
			if err != nil {
				return err
			}
		} else {
			// 根据条件变量选择节点索引
			condNode, err := GetConditionNode(node.ConditionNodes, userID, departmentId, variable)
			if err != nil {
				return err
			}
			if condNode == nil {
				return errors.New("找不到符合条件的子节点")
				// str, _ := util.ToJSONStr(variable)
				// return errors.New("节点【" + node.NodeID + "】找不到符合条件的子节点,检查变量【var】值是否匹配," + str)
			}
			err = parseProcessConfig(condNode, userID, departmentId, variable, list)
			if err != nil {
				return err
			}
		}

	}
	// 存在子节点
	if node.ChildNode != nil {
		err = parseProcessConfig(node.ChildNode, userID, departmentId, variable, list)
		if err != nil {
			return err
		}
	}
	return nil
}

// GetConditionNode 获取条件节点
func GetConditionNode(nodes []*Node, userID string, departmentId string, maps *types.Vars) (result *Node, err error) {
	// 用户信息
	// userInfo, errs := model.GetUserInfoById(userID)
	// if errs != nil {
	// 	return nil, errs
	// }
	// 部门列表
	deptList, errs := model.GetDeptTreeList(departmentId)
	if errs != nil {
		return nil, errs
	}
	// str, _ := json.Marshal(deptList)
	for _, node := range nodes {
		var flag int
		for _, v := range node.ConditionList {
			// 1.发起人
			if v.ColumnId == 0 {
				if len(node.NodeUserList) > 0 {
					for _, vv := range node.NodeUserList {
						//targetId, _ := strconv.Atoi(vv.TargetId)
						//这里本来就是字符串
						targetId := vv.TargetId
						// 属于用户条件
						if vv.Type == 1 && vv.TargetId == userID {
							flag++
							break
						}
						// 属于部门条件
						if vv.Type == 3 {
							for _, dept := range deptList {
								if targetId == dept.ID {
									flag++
									break
								}
							}
						}
					}
				} else {
					flag = len(node.ConditionList)
					break
				}
			}
			// 2.假期类型
			if v.ColumnId == 2 {
				for key, val := range types.VacateTypes {
					if strings.Contains(","+v.Zdy1, ","+strconv.Itoa(key+1)) && val == maps.Type {
						flag++
						break
					}
				}
			}
			// 3.请假时长
			if v.ColumnId == 3 {
				hour := maps.GetHourDiffer()                // 当前请求流程的时间（小时）
				optType, _ := strconv.Atoi(v.OptType)       // 判断类型
				zdy1, _ := strconv.ParseInt(v.Zdy1, 10, 64) // 判断值（小时）
				zdy2, _ := strconv.ParseInt(v.Zdy2, 10, 64) // 判断值（小时）

				switch optType {
				case 1: //小于
					if hour < zdy1 {
						flag++
					}
					break
				case 2: //大于
					if hour > zdy1 {
						flag++
					}
					break
				case 3: //小于等于
					if hour <= zdy1 {
						flag++
					}
					break
				case 4: //等于
					if hour == zdy1 {
						flag++
					}
					break
				case 5: //大于等于
					if hour >= zdy1 {
						flag++
					}
					break
				case 6: //介于两个数之间
					if hour >= zdy1 && hour <= zdy2 {
						flag++
					}
					break
				}
			}
		}
		// 满足所有条件
		if flag >= len(node.ConditionList) {
			result = node
			break
		}
	}
	return result, nil
}
