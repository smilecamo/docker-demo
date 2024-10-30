# 文件 Dockerfile

在根目录下,创建 Dockerfile 文件，内容如下：

```Dockerfile
FROM node:20-alpine // 指定的基础镜像
COPY index.js . // 复制文件到镜像中 COPY 文件 镜像文件
CMD ["node", "index.js"] // 指定容器启动时执行的命令
```

```md
1. 构建镜像第一种方式

# 在 Dockerfile 所在目录运行

docker build -t node-nginx-app:v1 . 2. 运行容器
docker run -d --name my-node-app -p 80:80 -p 443:443 -p 5177:5177 --restart unless-stopped node-nginx-app:v1 3. 检查运行状态

# 查看容器状态

docker ps

# 查看容器日志

docker logs my-node-app

# 查看 PM2 进程状态

docker exec my-node-app pm2 list

# 查看 Nginx 状态

docker exec my-node-app nginx -t

# 通过 docker-compose 构建镜像

1. 构建镜像

docker-compose build

2.  启动服务

docker-compose up -d

3. 查看容器状态

docker ps

# 停止服务

docker-compose down
```

# 进入容器并安装依赖

docker exec -w /opt/node-demo/8001 my-nginx npm i
docker exec my-nginx pm2 start /opt/node-demo/8001/index.js

# 在不删除容器的情况下添加新端口，我们可以使用 docker commit 和 docker run 的组合：

```bash
# 提交当前容器为新镜像
docker commit my-nginx my-nginx-new

# 停止旧容器（但不删除）
docker stop my-nginx
# 运行新容器，包含所有需要的端口
 docker run -d --name my-custom-nginx -p 8080:80 -p 5177:5177 -p 443:443 my-custom-nginx
# 如果之后需要切回旧容器：
 # 停止新容器
docker stop my-nginx-new
# 启动旧容器
docker start my-nginx
 # 运行新容器，包含所有需要的端口
docker run -d \
    --name my-nginx-new \
    --add-host=host.docker.internal:host-gateway \
    -p 80:80 \
    -p 443:443 \
    -p 8080:8080 \
    -p 3000:3000 \
    -p 8000:8000 \
    -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf \
    -v $(pwd)/default.conf:/etc/nginx/conf.d/default.conf \
    my-nginx-new
```

# 查看日志

docker-compose logs -f

# 进入容器

docker exec -it my-node-app sh

# 重启 PM2 应用

docker exec my-node-app pm2 restart all

# 重启 Nginx

docker exec my-node-app nginx -s reload

# 查看容器资源使用情况

docker stats my-node-app

# 常用命令

```bash
docker build -t my-node-app . // 构建镜像 my-node-app 镜像名称
docker run my-node-app // 运行镜像
docker image ls // 查看所有镜像
docker ps // 查看所有运行中的容器
docker stop <container_id> // 停止指定容器
docker rm <container_id> // 删除指定容器
docker rmi <image_id> // 删除指定镜像
docker exec my-container bash -c "rm -rf /app/*"
```

# 复制文件到容器

```bash
# 1. 复制新配置到容器
docker cp ./default.conf my-nginx:/etc/nginx/conf.d/default.conf
# 解释:
# docker cp - Docker的复制命令,用于在容器和主机之间复制文件
# ./default.conf - 本地主机上的源文件路径
# my-nginx - 目标容器的名称
# :/etc/nginx/conf.d/default.conf - 容器内的目标路径
# 这个命令会将本地的nginx配置文件复制到容器中的指定位置,通常用于更新nginx配置而无需重建容器
# 2. 检查配置
docker exec my-nginx nginx -t
# 3. 复制完成后需要重新加载nginx配置:
docker exec my-nginx nginx -s reload
```

```bash
docker exec my-nginx nginx -t
# 解释:
# docker exec - 在运行中的容器内执行命令
# my-nginx - 容器名称
# nginx -t - 测试nginx配置文件的语法是否正确
# 这个命令会检查nginx配置文件的语法,如果配置正确会显示"syntax is ok"
# 在修改nginx配置文件后,建议先用此命令检查配置是否正确,再重新加载配置
# 镜像源
```

# 通过 命令行 安装环境

```bash
# 安装 Node.js 环境
docker exec -it 容器ID bash -c "curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && apt-get install -y nodejs"

# 安装 Python 环境
docker exec -it 容器ID bash -c "apt-get update && apt-get install -y python3 python3-pip"

# 安装开发工具
docker exec -it 容器ID bash -c "apt-get update && apt-get install -y build-essential gcc g++ make"

# 安装 nginx
docker exec -it 容器ID bash -c "apt-get update && apt-get install -y nginx"

# 安装数据库客户端
docker exec -it 容器ID bash -c "apt-get install -y mysql-client postgresql-client"
```

<!-- 暂时可用的镜像源 -->

```json
"registry-mirrors": [
    "https://dockerproxy.com",
    "https://docker.mirrors.ustc.edu.cn",
    "https://docker.nju.edu.cn",
    "https://docker.m.daocloud.io"
]
```
