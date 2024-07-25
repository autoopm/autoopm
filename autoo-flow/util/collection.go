package util

import (
	"container/list"
	"sort"
)

// List2Array List2Array
// list对象转数组
func List2Array(list *list.List) []interface{} {
	var len = list.Len()
	if len == 0 {
		return nil
	}
	var arr []interface{}
	for e := list.Front(); e != nil; e = e.Next() {
		arr = append(arr, e.Value)
	}
	return arr
}

// ExistsDuplicateInStringsArr 字符串数组中是否存在重复元素
func ExistsDuplicateInStringsArr(arr []string) bool {
	length := len(arr)
	sort.Strings(arr)
	for i := 1; i < length; i++ {
		if arr[i-1] == arr[i] {
			return true
		}
	}
	return false
}
