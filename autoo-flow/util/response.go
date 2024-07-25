package util

import (
	"fmt"
	"net/http"
	"strings"
	"time"
)

// Response 返回信息给前台
func Response(writer http.ResponseWriter, data string, ok bool) {
	status := 200
	if ok == false {
		status = 500
	}
	fmt.Fprintf(writer, "{\"message\":\"%s\",\"ok\":%t,\"status\":%d}", data, ok, status)
}

// ResponseData 返回信息给前台
func ResponseData(writer http.ResponseWriter, data string) {
	fmt.Fprintf(writer, "{\"data\":%s,\"message\":\"ok\",\"ok\":%t,\"status\":200}", data, true)
}

// ResponseErr 返回错误给前台
func ResponseErr(w http.ResponseWriter, data interface{}) {
	str := fmt.Sprintf("%v", data)
	str = strings.ReplaceAll(str, "\"", "'")
	fmt.Fprintf(w, "{\"message\":\"%s\",\"timestamp\":\"%v\",\"status\":400,\"error\":\"%s\",\"ok\":%t}", str, time.Now(), "Bad Request", false)
}

// ResponseOk 返回成功
func ResponseOk(w http.ResponseWriter) {
	fmt.Fprintf(w, "{\"message\":\"%s\",\"ok\":%t,\"status\":200}", "成功", true)
}

// ResponseNo 返回失败
func ResponseNo(w http.ResponseWriter, data string) {
	fmt.Fprintf(w, "{\"message\":\"%s\",\"ok\":%t,\"status\":500}", data, false)
}
