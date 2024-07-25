package util

import (
	"bufio"
	"encoding/csv"
	"fmt"
	"os"

	"github.com/tealeg/xlsx"
	"golang.org/x/text/encoding/simplifiedchinese"
	"golang.org/x/text/transform"
)

// GetDatasFromXlsx 从xlsx文件获取数据
func GetDatasFromXlsx(file *os.File) ([][]string, error) {
	if file == nil {
		return nil, fmt.Errorf("file值为nil")
	}
	xlFile, err := xlsx.OpenFile(file.Name())
	if err != nil {
		return nil, err
	}
	datas, err := xlFile.ToSlice()
	if err != nil {
		return nil, fmt.Errorf("文件数据转换成数组失败:%s", err.Error())
	}
	return datas[0], nil
}

// GetDatasFromCSV 从csv文件获取数据
func GetDatasFromCSV(file *os.File) ([][]string, error) {
	if file == nil {
		return nil, fmt.Errorf("file值为nil")
	}
	csvfile, err := os.Open(file.Name())
	if err != nil {
		return nil, fmt.Errorf("打开csv文件:%s", err.Error())
	}
	defer csvfile.Close()
	r := transform.NewReader(bufio.NewReader(csvfile), simplifiedchinese.GBK.NewDecoder())
	reader := csv.NewReader(r)
	if reader == nil {
		return nil, fmt.Errorf("解析csv文件:reader为空")
	}
	records, err := reader.ReadAll()
	if err != nil {
		return nil, fmt.Errorf("从csv读取文件:%s", err.Error())
	}
	return records, nil
}
