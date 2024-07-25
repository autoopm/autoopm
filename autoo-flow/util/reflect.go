package util

import (
	"encoding/json"
	"errors"
	"fmt"
	"reflect"
	"regexp"
	"strings"
)

// Transform2Csv 将数组转换成csv对象
// header 表示转换后的行标如:["用户名","部门"]
// fields 表示行标对应的字段:["Username","DeptName"]
// datas 是struct数组
func Transform2Csv(header []interface{}, fields []interface{}, datas interface{}) ([]interface{}, error) {
	if datas == nil {
		return []interface{}{}, nil
	}
	if len(header) == 0 || len(fields) == 0 {
		return nil, errors.New("数据转换成csv格式时,行标和字段名不能为空")
	}
	// 获取结果集
	s := reflect.ValueOf(datas)
	var result []interface{}
	// 遍历结果
	for i := 0; i < s.Len(); i++ {
		var row []string
		for _, f := range fields {
			// log.Println(f)
			item := s.Index(i)
			str, _ := toJSONStr(item.Interface())
			data, err := str2Map(str)
			if err != nil {
				return make([]interface{}, 0), err
			}
			value := interface2String(data[f.(string)])
			row = append(row, value)
		}
		result = append(result, row)
	}
	return result, nil
}
func toJSONStr(data interface{}) (string, error) {
	result, err := json.Marshal(data)
	return fmt.Sprintf("%s", result), err
}

func str2Map(source string) (map[string]interface{}, error) {
	res := make(map[string]interface{})
	err := json.Unmarshal([]byte(source), &res)
	return res, err
}

func interface2String(value interface{}) string {
	if value == nil {
		return ""
	}
	switch value.(type) {
	case string:
		if len(value.(string)) == 0 {
			return ""
		}
		return value.(string)
	case int:
		return fmt.Sprintf("%d", value)
	case float64:
		return fmt.Sprintf("%f", value)
	case float32:
		return fmt.Sprintf("%f", value)
	default:
		return ""
	}
}

// StructSetValByReflect StructSetValByReflect
// structname 是一个指针变量
func StructSetValByReflect(structname interface{}, fieldname string, value interface{}) error {
	pp := reflect.ValueOf(structname)         // 取得struct变量的指针
	field := pp.Elem().FieldByName(fieldname) // 获取指定field
	if !field.IsValid() {
		return errors.New("结构体没有属性【" + fieldname + "】")
	}
	// fmt.Printf("------------%v", field)
	valueType := reflect.TypeOf(value).String()
	if field.Type().String() != valueType {
		return errors.New("field的类型为【" + field.Type().String() + "】,value的类型为【" + valueType + "】,两者不匹配")
	}
	field.Set(reflect.ValueOf(value))
	return nil
}

// GetTagJSONChannelFromStruct GetTagJSONChannelFromStruct
// 当属性比较多，后序操作比较复杂的时候，建议使用
func GetTagJSONChannelFromStruct(structName interface{}) (<-chan string, error) {
	t := reflect.TypeOf(structName)
	if t.Kind() == reflect.Ptr {
		t = t.Elem()
	}
	if t.Kind() != reflect.Struct {
		return nil, errors.New("不是结构体，not Struct")
	}
	fieldNum := t.NumField()
	if fieldNum == 0 {
		return nil, errors.New("结构体没有任何属性")
	}
	resultStream := make(chan string, fieldNum)
	reg := regexp.MustCompile(`.*json:"([^"]*)".*`)
	go func() {
		defer close(resultStream)
		// defer fmt.Println("关闭resultStream")
		for i := 0; i < fieldNum; i++ {
			var result string
			tags := string(t.Field(i).Tag)
			if strings.Contains(tags, "json:") {
				result = reg.ReplaceAllString(tags, "$1")
			} else {
				result = t.Field(i).Name
			}
			resultStream <- result
			// fmt.Printf("send %s\n", result)
		}
	}()
	return resultStream, nil
}

// GetTagJSONArrayFromStruct GetTagJSONArrayFromStruct
// 当属性比较少，后序没有什么操作时使用
func GetTagJSONArrayFromStruct(structName interface{}) ([]string, error) {
	t := reflect.TypeOf(structName)
	if t.Kind() == reflect.Ptr {
		t = t.Elem()
	}
	if t.Kind() != reflect.Struct {
		return nil, errors.New("不是结构体，not Struct")
	}
	fieldNum := t.NumField()
	result := make([]string, 0, fieldNum)
	reg := regexp.MustCompile(`.*json:"([^"]*)".*`)
	for i := 0; i < fieldNum; i++ {
		tags := string(t.Field(i).Tag)
		if strings.Contains(tags, "json:") {
			result = append(result, reg.ReplaceAllString(tags, "$1"))
		} else {
			result = append(result, t.Field(i).Name)
		}
	}
	return result, nil
}

// GetFieldArrayFromStruct GetFieldArrayFromStruct
// 获取结构体的属性[]string
func GetFieldArrayFromStruct(structName interface{}) ([]string, error) {
	t := reflect.TypeOf(structName)
	if t.Kind() == reflect.Ptr {
		t = t.Elem()
	}
	if t.Kind() != reflect.Struct {
		return nil, errors.New("不是结构体，not Struct")
	}
	fieldNum := t.NumField()
	result := make([]string, 0, fieldNum)
	// reg := regexp.MustCompile(`.*json:"([^"]*)".*`)
	for i := 0; i < fieldNum; i++ {
		result = append(result, t.Field(i).Name)
	}
	return result, nil
}

// GetFieldChannelFromStruct GetFieldChannelFromStruct
// 当属性比较多，后序操作比较复杂的时候，建议使用
func GetFieldChannelFromStruct(structName interface{}) (<-chan string, error) {
	t := reflect.TypeOf(structName)
	if t.Kind() == reflect.Ptr {
		t = t.Elem()
	}
	if t.Kind() != reflect.Struct {
		return nil, errors.New("不是结构体，not Struct")
	}
	fieldNum := t.NumField()
	if fieldNum == 0 {
		return nil, errors.New("结构体没有任何属性")
	}
	resultStream := make(chan string, fieldNum)
	go func() {
		defer close(resultStream)
		// defer fmt.Println("关闭resultStream")
		for i := 0; i < fieldNum; i++ {
			resultStream <- t.Field(i).Name
			// fmt.Printf("send %s\n", result)
		}
	}()
	return resultStream, nil
}
