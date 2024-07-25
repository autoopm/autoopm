package model

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"strconv"

	config "workflow/workflow-config"

	"github.com/jinzhu/gorm"
	"gopkg.in/yaml.v2"

	// mysql
	_ "github.com/go-sql-driver/mysql"
)

var db *gorm.DB

// Model 其它数据结构的公共部分
type Model struct {
	ID int `gorm:"primary_key" json:"id,omitempty"`
}

// 配置
var conf = *config.Config

// Setup 初始化一个db连接
func Setup() {
	var err error
	log.Println("数据库初始化！！")
	db, err = gorm.Open(conf.DbType, fmt.Sprintf("%s:%s@(%s:%s)/%s?charset=utf8mb4&parseTime=True&loc=Local", conf.DbUser, conf.DbPassword, conf.DbHost, conf.DbPort, conf.DbName))
	if err != nil {
		log.Fatalf("数据库连接失败 err: %v", err)
	}

	// 启用Logger，显示详细日志
	mode, _ := strconv.ParseBool(conf.DbLogMode)

	db.LogMode(mode)

	db.SingularTable(true) //全局设置表名不可以为复数形式
	// db.Callback().Create().Replace("gorm:update_time_stamp", updateTimeStampForCreateCallback)
	idle, err := strconv.Atoi(conf.DbMaxIdleConns)
	if err != nil {
		panic(err)
	}
	db.DB().SetMaxIdleConns(idle)
	open, err := strconv.Atoi(conf.DbMaxOpenConns)
	if err != nil {
		panic(err)
	}
	db.DB().SetMaxOpenConns(open)

	//添加表前缀
	gorm.DefaultTableNameHandler = func(db *gorm.DB, defaultTableName string) string {
		// 判断defaultTableName等于Department时返回defaultTableName
		//if defaultTableName == "user_departments" || defaultTableName == "users" {
		if defaultTableName == "sys_office" || defaultTableName == "sys_user" || defaultTableName == "sys_role" || defaultTableName == "sys_user_role" {
			//return "pre_" + defaultTableName
			return defaultTableName //这里不加前缀
		}
		return conf.DbPrefix + defaultTableName
	}

	oneCheckTable := db.HasTable(&Procdef{})

	db.Set("gorm:table_options", "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=1;").
		AutoMigrate(&Procdef{}).
		AutoMigrate(&Execution{}).
		AutoMigrate(&Task{}).
		AutoMigrate(&ProcInst{}).
		AutoMigrate(&Identitylink{}).
		AutoMigrate(&ExecutionHistory{}).
		AutoMigrate(&IdentitylinkHistory{}).
		AutoMigrate(&ProcInstHistory{}).
		AutoMigrate(&TaskHistory{}).
		AutoMigrate(&ProcdefHistory{})

	// 添加索引
	db.Model(&Procdef{}).AddIndex("idx_id", "id")
	db.Model(&ProcInst{}).AddIndex("idx_id", "id")
	db.Model(&Execution{}).AddForeignKey("proc_inst_id", conf.DbPrefix+"proc_inst(id)", "CASCADE", "RESTRICT").AddIndex("idx_id", "id")
	db.Model(&Identitylink{}).AddForeignKey("proc_inst_id", conf.DbPrefix+"proc_inst(id)", "CASCADE", "RESTRICT").AddIndex("idx_id", "id")
	db.Model(&Task{}).AddForeignKey("proc_inst_id", conf.DbPrefix+"proc_inst(id)", "CASCADE", "RESTRICT").AddIndex("idx_id", "id")
	//---------------------历史纪录------------------------------
	db.Model(&ProcInstHistory{}).AddIndex("idx_id", "id")
	db.Model(&ExecutionHistory{}).AddForeignKey("proc_inst_id", conf.DbPrefix+"proc_inst_history(id)", "CASCADE", "RESTRICT").AddIndex("idx_id", "id")
	db.Model(&IdentitylinkHistory{}).AddForeignKey("proc_inst_id", conf.DbPrefix+"proc_inst_history(id)", "CASCADE", "RESTRICT").AddIndex("idx_id", "id")
	db.Model(&TaskHistory{}).AddIndex("idx_id", "id")

	// 修改表字段的字符集
	db.Model(&ProcInst{}).ModifyColumn("var", "text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci")
	db.Model(&ProcInstHistory{}).ModifyColumn("var", "text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci")
	db.Model(&ProcInst{}).ModifyColumn("latest_comment", "text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci")
	db.Model(&ProcInstHistory{}).ModifyColumn("latest_comment", "text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci")
	db.Model(&ProcInst{}).ModifyColumn("global_comment", "text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci")
	db.Model(&ProcInstHistory{}).ModifyColumn("global_comment", "text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci")
	db.Model(&Procdef{}).ModifyColumn("username", "text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci")
	db.Model(&ProcdefHistory{}).ModifyColumn("username", "text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci")
	db.Model(&Identitylink{}).ModifyColumn("comment", "text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci")
	db.Model(&IdentitylinkHistory{}).ModifyColumn("comment", "text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci")

	// 新增字段 - 给定默认值
	db.Model(&Procdef{}).Where("created_time IS NULL").UpdateColumn("created_time", gorm.Expr("deploy_time"))

	// 演示数据
	twoCheckTable := db.HasTable(&Procdef{})
	IsInitOkrEmpty := false
	if !oneCheckTable && twoCheckTable {
		IsInitOkrEmpty = true
	}
	if os.Getenv("DEMO_DATA") == "true" && IsInitOkrEmpty {
		if _, err := os.Stat("demo-lock"); os.IsNotExist(err) {
			executeSQLFromFile(db, "approveProcdefTableSeeder.yaml")
			executeSQLFromFile(db, "approveProcdefHistoryTableSeeder.yaml")
			executeSQLFromFile(db, "approveProcInstTableSeeder.yaml")
			executeSQLFromFile(db, "approveProcInstHistoryTableSeeder.yaml")
			executeSQLFromFile(db, "approveTaskTableSeeder.yaml")
			executeSQLFromFile(db, "approveTaskHistoryTableSeeder.yaml")
			executeSQLFromFile(db, "approveExecutionTableSeeder.yaml")
			executeSQLFromFile(db, "approveExecutionHistoryTableSeeder.yaml")
			executeSQLFromFile(db, "approveIdentitylinkTableSeeder.yaml")
			executeSQLFromFile(db, "approveIdentitylinkHistoryTableSeeder.yaml")

			_, err := os.Create("demo-lock")
			if err != nil {
				panic(err)
			}
		}
	}
}

func executeSQLFromFile(db *gorm.DB, filename string) {
	filename = "workflow-engine/model/seeders/" + filename
	file, err := os.Open(filename)
	if err != nil {
		panic(err)
	}
	defer file.Close()

	bytes, err := ioutil.ReadAll(file)
	if err != nil {
		panic(err)
	}
	var sql string
	err = yaml.Unmarshal(bytes, &sql)
	if err != nil {
		panic(err)
	}
	db.Exec(sql)
}

// CloseDB closes database connection (unnecessary)
func CloseDB() {
	defer db.Close()
}

// GetDB getdb
func GetDB() *gorm.DB {
	return db
}

// GetTx GetTx
func GetTx() *gorm.DB {
	return db.Begin()
}
