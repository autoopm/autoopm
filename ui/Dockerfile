# 使用Node.js作为基础镜像
FROM node:16 AS build
WORKDIR /app
COPY . .
#RUN npm config set registry https://registry.npm.taobao.org
RUN npm install  --legacy-peer-deps
RUN npm run build
