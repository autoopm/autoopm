
# 使用官方 Maven 镜像作为基础镜像
FROM maven:3.8.1-openjdk-17 AS build
WORKDIR /app
# 复制项目代码到工作目录
COPY ./service /app
# 执行 Maven 清理和打包命令
RUN mvn clean package
# 使用官方 OpenJDK 11 轻量级镜像作为最终基础镜像
FROM openjdk:17-jdk-slim
WORKDIR /app
# 从上一个阶段复制生成的 JAR 文件到镜像中
COPY --from=build /app/target/*.jar /app/app.jar
# 暴露应用程序的端口（如果需要）
ENV SERVER_PORT=8081
EXPOSE ${SERVER_PORT}
# 启动 Spring Boot 应用程序
ENTRYPOINT ["java", \
            "-Djava.security.egd=file:/dev/./urandom", \
            "-Dserver.port=${SERVER_PORT}", \
            "-jar", "app.jar"]

