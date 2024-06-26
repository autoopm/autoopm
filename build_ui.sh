#!/bin/bash

# 设置变量
IMAGE_NAME="autoo-ui"
CONTAINER_NAME="autoo-ui-build"
DIST_DIR="./ui/dist"
UI_DIR="./ui"

# 检查DIST_DIR的父目录是否存在，如果不存在则创建它
if [ ! -d "$(dirname "$DIST_DIR")" ]; then
    mkdir -p "$(dirname "$DIST_DIR")"
    echo "Created directory: $(dirname "$DIST_DIR")"
fi

# 进入ui目录并删除node_modules和dist目录
cd "$UI_DIR" || exit 1
rm -rf node_modules dist
echo "Deleted node_modules and dist directories from $UI_DIR."

# 返回到脚本所在的目录（如果需要的话）
cd - > /dev/null || exit 1

# 构建Docker镜像
docker build -t $IMAGE_NAME "$UI_DIR"
if [ $? -ne 0 ]; then
    echo "Error building Docker image."
    exit 1
fi

# 清理可能存在的同名容器（可选）
docker rm -f $CONTAINER_NAME || true

# 运行容器进行构建（并删除容器，因为我们只需要构建结果）
docker run --name $CONTAINER_NAME --rm -v $DIST_DIR:/app/dist -w /app $IMAGE_NAME sh -c "npm config set registry https://registry.npm.taobao.org && npm install --legacy-peer-deps && npm run build"
if [ $? -ne 0 ]; then
    echo "Error building frontend app inside the container."
    exit 1
fi

# 检查dist目录是否存在，并输出信息
if [ -d "$DIST_DIR" ]; then
    echo "Build completed and dist directory copied to $DIST_DIR"
    # 可以添加额外的步骤，比如压缩dist目录或执行其他操作
else
    echo "Error: dist directory not found or not copied properly."
    exit 1
fi