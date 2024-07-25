# 构建镜像
# DOCKER_BUILDKIT=1 docker build -t hitosea2020/go-workflow:1.0.1 .
# 提交镜像到docker
# docker commit 469f4b02521e imagecommit
# 推送 
# docker push hitosea2020/go-approve:latest

# FROM alpine
FROM nginx:alpine
 
ENV GO111MODULE=on \
    CGO_ENABLE=0 \
    GOOS=linux \
    GOARCH=amd64 

WORKDIR /var/doo/
 
COPY main .
COPY config.json .
COPY workflow-vue3/dist/ /var/doo/dist
COPY docker/nginx/default.conf /etc/nginx/conf.d/

CMD nginx;./main