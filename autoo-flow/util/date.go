package util

import (
	"fmt"
	"math"
	"regexp"
	"time"
)

const (
	// 格式：2006-01-02
	YYYY_MM_DD = "2006-01-02"
	// 格式：2006/01/02
	DATE_DIR_PATTERN    = "2006/01/02"
	YYYY_MM_DD_HH_MM_SS = "2006-01-02 15:04:05"
)

// FormatDate 将日期转换成指定格式的字符串
func FormatDate(date time.Time, format string) string {
	return date.Format(format)
}

// FormatDate1 日期转换成字符串
// 转换成： yyyymmdd
func FormatDate1(date time.Time) string {
	return date.Format("20060102")
}

// FormatDate3 日期转换成字符串
// 转换成： yyyy-mm-dd
func FormatDate3(date time.Time) string {
	return date.Format("2006-01-02")
}

// FormatDate4 日期转换成字符串
// 转换成： yyyy-mm-dd mm:ss:ss
func FormatDate4(date time.Time) string {
	return date.Format("2006-01-02 15:04:05")
}

// ParseDate1 字符串转日期
// 字符串格式： yyyymmdd
func ParseDate1(date string) (time.Time, error) {
	return time.Parse("20060102", date)
}

// FormatDate2 日期转换成字符串
// 转换成： yyyy/mm/dd
func FormatDate2(date time.Time) string {
	return date.Format("2006/01/02")
}

// ParseDate2 字符串转日期
// 字符串格式： yyyy/mm/dd
func ParseDate2(date string) (time.Time, error) {
	return time.Parse("2006/01/02", date)
}

// ParseDate3 字符串转日期
// 字符串格式： yyyy-mm-dd
func ParseDate3(date string) (time.Time, error) {
	return time.Parse("2006-01-02", date)
}

// IsDate3 判断字符串格式是否是:yyyy-mm-dd
func IsDate3(date string) (bool, error) {
	if len(date) != 10 {
		return false, fmt.Errorf("日期格式必须是:yyyy-mm-dd,共10位,且有些月份没有31和30号")
	}
	return regexp.MatchString(`([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8])))`, date)

}

// ParseDate ParseDate
//将字符串日期转换成日期
func ParseDate(date string, format string) (time.Time, error) {
	return time.Parse(format, date)
}

// TimeStrSub 日期字符串相减 end-start  返回int
func TimeStrSub(start, end, format string) (int64, error) {
	d1, err := ParseDate(start, format)
	if err != nil {
		return 0, err
	}
	d2, err := ParseDate(end, format)
	if err != nil {
		return 0, err
	}
	result := d2.Unix() - d1.Unix()
	return result, nil
}

// DateStrSubDays3 end-start返回天数
// 日期格式: yyyy-mm-dd
func DateStrSubDays3(start, end string) (int, error) {
	d1, err := ParseDate3(start)
	if err != nil {
		return 0, err
	}
	d2, err := ParseDate3(end)
	if err != nil {
		return 0, err
	}
	// result := math.Ceil((d2.Sub(d1).Hours() / 24))
	return DateSubReturnDays(d1, d2)
}

// DateSubReturnDays end-start返回天数
func DateSubReturnDays(start, end time.Time) (int, error) {
	return int(math.Ceil((end.Sub(start).Hours() / 24))), nil
}

// FirstDayOfCurrentYearAsString 返回今年的第一天，格式为 2019-01-01
func FirstDayOfCurrentYearAsString() string {
	year := time.Now().Year()
	return fmt.Sprintf("%d-01-01", year)
}

// GetDateAsDefaultStr 获取当前日期,格式 yyyy-mm-dd
func GetDateAsDefaultStr() string {
	return FormatDate(time.Now(), YYYY_MM_DD)
}

// SecondsToTimesStr1 将秒转化成 天时分 格式
// 最终格式： 1天10时5分
func SecondsToTimesStr1(seconds int) string {
	day := seconds / 3600 / 24
	hour := (seconds - 3600*24*day) / 3600
	miniute := (seconds - 3600*24*day - 3600*hour) / 60
	return fmt.Sprintf("%d天%d时%d分", day, hour, miniute)
}

// SecondsToTimesStr2 将秒转化成时间格式
// 最终格式： 00:00:00
func SecondsToTimesStr2(seconds int) string {
	day := seconds / 3600 / 24
	hour := (seconds - 3600*24*day) / 3600
	miniute := (seconds - 3600*24*day - 3600*hour) / 60
	second := seconds - 3600*24*day - 3600*hour - 60*miniute
	var h, m, s string
	h = fmt.Sprintf("%d", hour)
	if hour < 10 {
		h = "0" + h
	}
	m = fmt.Sprintf("%d", miniute)
	if miniute < 10 {
		m = "0" + m
	}
	s = fmt.Sprintf("%d", second)
	if second < 10 {
		s = "0" + s
	}
	return fmt.Sprintf("%s:%s:%s", h, m, s)
}

// GetLastMonthStartAndEnd 获取上月开始第一天和最后一天
func GetLastMonthStartAndEnd(lastmonth time.Time) (time.Time, time.Time) {
	now := lastmonth
	firtOfMonth := time.Date(now.Year(), now.Month(), 1, 23, 59, 59, 0, now.Location())
	end := firtOfMonth.AddDate(0, 0, -1)
	start := time.Date(end.Year(), end.Month(), 1, 0, 0, 0, 0, end.Location())
	return start, end
}
