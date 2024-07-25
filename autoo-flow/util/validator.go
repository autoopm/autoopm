package util

import (
	"regexp"
	"time"
)

// IsDoubleStr 验证是否是浮点字符串
func IsDoubleStr(doubelstr string) (bool, error) {
	return regexp.MatchString(`^[-+]?[0-9]+(\.[0-9]+)?$`, doubelstr)
}

// 判断元素是否存在数组中
func IsContain(items []string, item string) bool {
	for _, eachItem := range items {
		if eachItem == item {
			return true
		}
	}
	return false
}

// 验证时间格式
func ValidateTimeFormat(str string, layout ...string) bool {
	var lay string
	if layout != nil {
		lay = layout[0]
	} else {
		lay = "2006-01-02 15:04"
	}
	_, err := time.Parse(lay, str)
	if err != nil {
		return false
	}
	return true
}
