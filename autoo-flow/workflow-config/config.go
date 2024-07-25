package config

import (
	"encoding/json"
	"log"
	"os"

	"workflow/util"

	"github.com/joho/godotenv"
)

// Configuration 数据库配置结构
type Configuration struct {
	Port         string
	ReadTimeout  string
	WriteTimeout string
	// 数据库设置
	DbLogMode      string
	DbType         string
	DbName         string
	DbHost         string
	DbPort         string
	DbUser         string
	DbPassword     string
	DbPrefix       string
	DbMaxIdleConns string
	DbMaxOpenConns string
	// redis 设置
	RedisCluster  string
	RedisHost     string
	RedisPort     string
	RedisPassword string
	TLSOpen       string
	TLSCrt        string
	TLSKey        string
	// 跨域设置
	AccessControlAllowOrigin  string
	AccessControlAllowHeaders string
	AccessControlAllowMethods string
}

// Config 数据库配置
var Config = &Configuration{}

func init() {
	if os.Getenv("MYSQL_HOST") == "" {
		errs := godotenv.Load(".env")
		if errs != nil {
			// os.Exit(101)
		}
	}
	LoadConfig()
}

// LoadConfig LoadConfig
func LoadConfig() {
	// 获取配置信息config
	Config.getConf()
	// 环境变量覆盖config
	err := Config.setFromEnv()
	if err != nil {
		panic(err)
	}
}

func (c *Configuration) setFromEnv() error {
	fieldStream, err := util.GetFieldChannelFromStruct(&Configuration{})
	if err != nil {
		return err
	}
	for fieldname := range fieldStream {
		newFieldname := fieldname
		switch newFieldname {
		case "Port":
			newFieldname = "SERVER_PORT"
		case "DbHost":
			newFieldname = "MYSQL_HOST"
		case "DbPort":
			newFieldname = "MYSQL_PORT"
		case "DbName":
			newFieldname = "MYSQL_DBNAME"
		case "DbUser":
			newFieldname = "MYSQL_USERNAME"
		case "DbPassword":
			newFieldname = "MYSQL_PASSWORD"
		case "DbPrefix":
			newFieldname = "MYSQL_Prefix"
		case "RedisHost":
			newFieldname = "REDIS_HOST"
		case "RedisPort":
			newFieldname = "REDIS_PORT"
		case "RedisPassword":
			newFieldname = "REDIS_PASS"
		}
		if len(os.Getenv(newFieldname)) > 0 {
			err = util.StructSetValByReflect(c, fieldname, os.Getenv(newFieldname))
			if err != nil {
				return err
			}
		}
	}
	return nil
}

func (c *Configuration) getConf() *Configuration {
	file, err := os.Open("config.json")
	if err != nil {
		log.Printf("cannot open file config.json：%v", err)
		panic(err)
	}
	decoder := json.NewDecoder(file)
	err = decoder.Decode(c)
	if err != nil {
		log.Printf("decode config.json failed:%v", err)
		panic(err)
	}
	return c
}
