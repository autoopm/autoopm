package util

import (
	"encoding/json"
	"errors"
	"fmt"
	"io/ioutil"
	"net/http"
	"net/url"
	"strings"
)

// ToJSONStr 对象转换成字符串
// 对象字段必须大写,否则结果为空
func ToJSONStr(data interface{}) (string, error) {
	result, err := json.Marshal(data)
	return fmt.Sprintf("%s", result), err
}

// ToPageJSON 转换成json字符串
func ToPageJSON(datas interface{}, count, pageIndex, pageSize int) (string, error) {
	var data any
	var err error
	if fmt.Sprintf("%s", datas) == "[]" {
		data = "[]"
	} else {
		data, err = json.Marshal(datas)
	}
	result := fmt.Sprintf("{\"rows\":%s,\"pageSize\":%d,\"total\":%d,\"page\":%d}", data, pageSize, count, pageIndex)
	return result, err
}

// Str2Struct Str2Struct
// 字符串转对象
func Str2Struct(source string, destination interface{}) error {
	err := json.Unmarshal([]byte(source), destination)
	return err
}

// Str2Map 字符转Map
func Str2Map(source string) (map[string]interface{}, error) {
	res := make(map[string]interface{})
	err := json.Unmarshal([]byte(source), &res)
	return res, err
}

// Body2MapWithDecode 获取已经编码的POST参数,并转换成map
// 每个key的存储对象是数组[], 用Get方法获取
func Body2MapWithDecode(r *http.Request) (url.Values, error) {
	s, _ := ioutil.ReadAll(r.Body)
	return url.ParseQuery(string(s))
}

// Body2Map 获取前台传递的body值，并转化成map
func Body2Map(r *http.Request) (map[string]interface{}, error) {
	s, _ := ioutil.ReadAll(r.Body)
	if len(s) == 0 {
		return nil, nil
	}
	map1 := make(map[string]interface{})
	err := json.Unmarshal(s, &map1)
	if err != nil {
		return nil, err
	}
	return map1, nil
}

// Body2Struct 获取前台传递的body值，并转化成指定结构体
func Body2Struct(r *http.Request, pojo interface{}) error {

	err := json.NewDecoder(r.Body).Decode(&pojo)

	return err
}

// GetBody 获取 body 值，并存储到指定 struct 中去
func GetBody(result interface{}, w http.ResponseWriter, r *http.Request) error {
	if r.Method != "POST" {
		return errors.New("只支持POST方法")
	}
	if err := Body2Struct(r, result); err != nil {
		return err
	}
	return nil
}

// PrintHTTPRequestInfo 打印http请求的详细信息
func PrintHTTPRequestInfo(r *http.Request) {
	s, _ := ioutil.ReadAll(r.Body)
	body := make(map[string]interface{})
	json.Unmarshal(s, &body)
	fmt.Println("body:", body)
}

// Struct2StructAndDelKey 对象转换结构体，并过滤某些字段
// 对象字段必须大写,否则结果为空
func Struct2Struct(data interface{}, newdata interface{}, filtrationKeys_optional string) error {
	result, err := json.Marshal(data)
	if err != nil {
		return err
	}
	str := fmt.Sprintf("%s", result)
	// 过滤字段
	if filtrationKeys_optional != "" {
		keysArr := strings.Split(filtrationKeys_optional, ",")
		for _, v := range keysArr {
			str = strings.Replace(string(str), `"`+v+`":`, `"_`+v+`":`, 1)
		}
	}
	// 转新的结构体
	err = json.Unmarshal([]byte(str), newdata)
	if err != nil {
		return err
	}
	//
	return nil
}

// StructToJson 结构体转json
func StructToJson(data interface{}) string {
	jsonBytes, err := json.Marshal(data)
	if err != nil {
		return ""
	}
	return string(jsonBytes)
}
