# 使用node作为基础镜像
FROM node:16 AS build-stage
WORKDIR /app
COPY ./ui .

RUN npm config set registry https://registry.npm.taobao.org
RUN npm install  --legacy-peer-deps

RUN npm run build

 #使用nginx作为web服务器
FROM nginx:alpine
COPY --from=build-stage /app/dist /usr/share/nginx/html
#COPY ../docker/nginx/default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]