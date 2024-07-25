package util

import (
	"strconv"
	"sync"
)

// Page 分页信息对象
type Page struct {
	PageIndex int `json:"pageIndex"`
	PageSize  int `json:"pageSize"`
}

// PageRequest 生成分页数据
func (p *Page) PageRequest(pageIndex interface{}, pageSize interface{}) {
	var wg sync.WaitGroup
	wg.Add(2)
	go format(&pageIndex, &wg)
	go format(&pageSize, &wg)
	wg.Wait()
	p.PageIndex = pageIndex.(int)
	p.PageSize = pageSize.(int)
}
func format(val *interface{}, wg *sync.WaitGroup) {
	defer wg.Done()
	var e = *val
	switch e.(type) {
	case string:
		e, _ = strconv.Atoi(e.(string))
		break
	case float64:
		e = int(e.(float64))
		break
	case nil:
		e = 1
		break
	case int:
		e = e.(int)
		break
	}
	*val = e
}
