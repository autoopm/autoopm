# 使用 Node.js 官方镜像作为基础镜像
FROM node:16 AS build

# 设置工作目录
WORKDIR /app

# 将项目文件复制到工作目录
COPY . .

# 安装依赖
RUN npm install

# 执行构建
RUN npm run build

# 使用 Nginx 官方镜像作为运行时镜像
FROM nginx:alpine

# 将构建好的项目代码复制到 Nginx 默认站点目录
COPY --from=build /app/dist /usr/share/nginx/html

# 暴露容器端口
EXPOSE 80








