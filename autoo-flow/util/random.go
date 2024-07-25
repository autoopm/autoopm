package util

import (
	"fmt"
	"math/rand"
	"strings"
	"time"
)

const (
	KC_RAND_KIND_NUM   = 0 // 纯数字
	KC_RAND_KIND_LOWER = 1 // 小写字母
	KC_RAND_KIND_UPPER = 2 // 大写字母
	KC_RAND_KIND_ALL   = 3 // 数字、大小写字母
)

// RandomNumbers 返回随机数字
// len 为长度
func RandomNumbers(len int) string {
	var buff strings.Builder
	r := rand.New(rand.NewSource(time.Now().Local().UnixNano()))
	for i := 0; i < len; i++ {

		buff.WriteString(fmt.Sprintf("%d", r.Intn(9)))
	}
	return buff.String()
}

// Random8Password 返回8位复杂密码
func Random8Password() string {
	var buff strings.Builder
	buff.WriteString(string(Krand(3, KC_RAND_KIND_ALL)))
	buff.WriteString("_")
	buff.WriteString(string(Krand(1, KC_RAND_KIND_LOWER)))
	buff.WriteString(string(Krand(1, KC_RAND_KIND_UPPER)))
	buff.WriteString(string(Krand(2, KC_RAND_KIND_NUM)))
	return buff.String()
}

// 随机字符串
func Krand(size int, kind int) []byte {
	ikind, kinds, result := kind, [][]int{{10, 48}, {26, 97}, {26, 65}}, make([]byte, size)
	is_all := kind > 2 || kind < 0
	rand.Seed(time.Now().UnixNano())
	for i := 0; i < size; i++ {
		if is_all { // random ikind
			ikind = rand.Intn(3)
		}
		scope, base := kinds[ikind][0], kinds[ikind][1]
		result[i] = uint8(base + rand.Intn(scope))
	}
	return result
}
