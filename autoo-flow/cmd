#!/bin/bash

#fonts color
Green="\033[32m"
Red="\033[31m"
GreenBG="\033[42;37m"
RedBG="\033[41;37m"
Font="\033[0m"

#notification information
OK="${Green}[OK]${Font}"
Error="${Red}[错误]${Font}"

cur_path="$(pwd)"
cur_arg=$@
COMPOSE="docker-compose --env-file ./.env"
env_path="$(pwd)"

arch=amd64
[ "`uname -m`" == "arm64" ] && arch=arm64

git_host="git@github.com:innet8"
git_user=""
git_pass=""

judge() {
    if [[ 0 -eq $? ]]; then
        echo -e "${OK} ${GreenBG} $1 完成 ${Font}"
        sleep 1
    else
        echo -e "${Error} ${RedBG} $1 失败 ${Font}"
        exit 1
    fi
}

rand() {
    local min=$1
    local max=$(($2-$min+1))
    local num=$(($RANDOM+1000000000))
    echo $(($num%$max+$min))
}

rand_string() {
    local lan=$1
    if [[ `uname` == 'Linux' ]]; then
        echo "$(date +%s%N | md5sum | cut -c 1-${lan})"
    else
        echo "$(docker run -it --rm alpine sh -c "date +%s%N | md5sum | cut -c 1-${lan}")"
    fi
}

input_gituser() {
    if [ -z "$git_user" ]; then
        read -p"请输入git用户名：" uname
        stty -echo
        read -p"请输入git密码：" passw; echo
        stty echo
        git_user=$uname
        git_pass=$passw
        if [ -z "$git_user" ]; then
            echo -e "${Error} ${RedBG} git用户名不能为空！${Font}"
            exit 1
        fi
        if [ -z "$git_pass" ]; then
            echo -e "${Error} ${RedBG} git密码不能为空！${Font}"
            exit 1
        fi
    fi
}

check_docker() {
    docker --version &> /dev/null
    if [ $? -ne  0 ]; then
        echo -e "${Error} ${RedBG} 未安装 Docker！${Font}"
        exit 1
    fi
    docker-compose version &> /dev/null
    if [ $? -ne  0 ]; then
        docker compose version &> /dev/null
        if [ $? -ne  0 ]; then
            echo -e "${Error} ${RedBG} 未安装 Docker-compose！${Font}"
            exit 1
        fi
        COMPOSE="docker compose"
    fi
    if [[ -n `$COMPOSE version | grep -E "\sv*1"` ]]; then
        $COMPOSE version
        echo -e "${Error} ${RedBG} Docker-compose 版本过低，请升级至v2+！${Font}"
        exit 1
    fi
}

docker_name() {
    echo `$COMPOSE ps | awk '{print $1}' | grep "\-$1\-"`
}

env_get() {
    local key=$1
    local value=`cat ${env_path}/.env | grep "^$key=" | awk -F '=' '{print $2}'`
    echo "$value"
}

env_set() {
    local key=$1
    local val=$2
    local exist=`cat ${env_path}/.env | grep "^$key="`
    if [ -z "$exist" ]; then
        echo "$key=$val" >> $env_path/.env
    else
        if [[ `uname` == 'Linux' ]]; then
            sed -i "/^${key}=/c\\${key}=${val}" ${env_path}/.env
        else
            docker run -it --rm -v ${cur_path}:/www alpine sh -c "sed -i "/^${key}=/c\\${key}=${val}" /www/.env"
        fi
        if [ $? -ne  0 ]; then
            echo -e "${Error} ${RedBG} 设置env参数失败！${Font}"
            exit 1
        fi
    fi
}

env_init() {
    if [ ! -f "${env_path}/.env" ]; then
        cp ${env_path}/.env.example ${env_path}/.env
    fi
    if [ -z "$(env_get APP_SECRET)" ]; then
        env_set APP_SECRET "$(docker run -it --rm alpine sh -c "date +%s%N | md5sum | cut -c 1-8")"
    fi
    if [ -z "$(env_get MYSQL_ROOT_PASSWORD)" ]; then
        env_set MYSQL_ROOT_PASSWORD "$(docker run -it --rm alpine sh -c "date +%s%N | md5sum | cut -c 1-16")"
    fi
    if [ -z "$(env_get REDIS_PASS)" ]; then
        env_set REDIS_PASS "$(docker run -it --rm alpine sh -c "date +%s%N | md5sum | cut -c 1-16")"
    fi
    if [ -z "$(env_get APP_ID)" ]; then
        env_set APP_ID "$(docker run -it --rm alpine sh -c "date +%s%N | md5sum | cut -c 1-6")"
    fi
}

run_exec() {
    local container=$1
    local cmd=$2
    local name=`docker_name $container`
    if [ -z "$name" ]; then
        echo -e "${Error} ${RedBG} 没有找到 $container 容器! ${Font}"
        exit 1
    fi
    docker exec -it "$name" /bin/sh -c "$cmd"
}


####################################################################################
####################################################################################
####################################################################################

if [ $# -gt 0 ]; then
    if [[ "$1" == "init" ]] || [[ "$1" == "install" ]]; then
        shift 1
        check_docker
        env_init
        # 启动容器
        $COMPOSE up -d
        # 
        echo -e "${OK} ${GreenBG} 安装完成 ${Font}"
        echo -e "地址: http://${GreenBG}127.0.0.1:$(env_get SERVER_PORT)${Font}"
        echo -e "账号: ${GreenBG}admin${Font}"
        echo -e "密码: ${GreenBG}123456${Font}"
    elif [[ "$1" == "update" ]]; then
        shift 1
        git fetch --all
        git reset --hard origin/$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
        git pull
        $COMPOSE up -d
    elif [[ "$1" == "restart" ]]; then
        shift 1
        $COMPOSE stop "$@"
        $COMPOSE start "$@"
    elif [[ "$1" == "dev" ]]; then
        fresh -c fresh.conf
    elif [[ "$1" == "build" ]]; then
        run_exec golang "rm -f main & CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main main.go"
        echo -e "${OK} ${GreenBG} 编译完成 ${Font}"
    elif [[ "$1" == "push-image" ]]; then
        cd workflow-vue3 && npm run build && cd ../
        CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main main.go
        DOCKER_BUILDKIT=1 docker buildx build --push -t hitosea2020/go-approve:0.1.4 --platform linux/amd64,linux/arm64 .
    else
        $COMPOSE "$@"
    fi
else
    $COMPOSE ps
fi