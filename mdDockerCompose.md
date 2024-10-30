## docker-compose 使用

在没有 docker-compose 之前，我们使用 docker run 来启动服务，但是 docker run 启动服务需要指定很多参数，而且不方便管理，docker-compose 就是为了解决这个问题而生的。

docker-compose 是一个工具，可以管理多个 docker 容器，并且可以定义服务之间的依赖关系，方便我们管理和维护。

举一个简单的例子，
我们有一个 mongo 数据库，一个 mongo-express 可视化工具，我们需要两个容器，一个容器运行 mongo，一个容器运行 mongo-express，这两个容器需要进行连接，如果使用 docker run 来启动，我们需要指定很多参数，而且不方便管理，如果使用 docker-compose 来启动，我们只需要在 docker-compose.yml 文件中进行配置即可。

## 基本的使用

```bash
# 查看 docker 网络
docker network ls
# 新建 docker 网络
docker network create mongo-network
# 运行 mongo 容器
docker run -d -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=mongoadmin -e MONGO_INITDB_ROOT_PASSWORD=secret --network mongo-network --name mongodb mongo
# 运行 mongo-express 容器
docker run -d -p 8081:8081 -e ME_CONFIG_MONGODB_ADMINUSERNAME=mongoadmin -e ME_CONFIG_MONGODB_ADMINPASSWORD=secret -e ME_CONFIG_MONGODB_SERVER=mongodb --network mongo-network --name mongo-express mongo-express
# 访问 mongo-express
http://localhost:8081
# 注意使用 docker ps 结合 docker logs dockerId查看 mongo-express 的日志
# Server is open to allow connections from anyone (0.0.0.0)
# basicAuth credentials are "admin:pass", it is recommended you change this in your config.js!

# 使用容器ID或容器名称停止容器
docker stop <容器ID/容器名称>
# 示例
docker stop mongodb
docker stop mongo-express
# 停止并删除容器
# 停止并删除指定容器
docker rm -f <容器ID/容器名称>
# 停止并删除所有容器
docker rm -f $(docker ps -aq)
注意事项：
1. `docker stop` 命令会发送 SIGTERM 信号，给容器一个优雅关闭的机会
2. `docker kill` 命令会发送 SIGKILL 信号，立即终止容器
3. 使用 `docker rm` 删除容器前，建议先停止容器
4. `-f` 参数表示强制操作，谨慎使用
```

## 使用 docker-compose 启动服务

```bash
# 使用 docker-compose 启动服务
docker-compose -f mongo-services.yaml up -d
# 使用 docker-compose 停止服务 会删除容器
docker-compose -f mongo-services.yaml down
# 启动服务 通过stop停止的容器会重新启动
docker-compose -f mongo-services.yaml start
# 停止服务 不会删除容器
docker-compose -f mongo-services.yaml stop
```

## 指定项目名称

```bash

docker-compose --project-name docker-demo1 -f mongo-services.yaml up -d
# 使用 --project-name 或 -p 参数指定项目名称
# 这样可以避免不同项目的容器名称冲突
# 例如: 容器会被命名为 docker-demo_mongodb_1, docker-demo_mongo-express_1

# 查看指定项目的所有容器
docker-compose -p docker-demo1 -f mongo-services.yaml ps
# 查看指定项目的容器日志
docker-compose -p docker-demo1 -f mongo-services.yaml logs
# 删除指定项目的所有容器
docker-compose -p docker-demo1 -f mongo-services.yaml down
```

## 上传镜像到 Docker Hub

### 1. 登录 Docker Hub

```bash
# 登录到 Docker Hub
docker login
# 输入用户名和密码
Username: your_username
Password: your_password
```

### 2. 构建镜像

```bash
# 构建镜像时需要按照 Docker Hub 的命名规范
# 格式：<Docker Hub用户名>/<镜像名>:<标签>
docker build -t smilecamo99/my-app:0.01 -f Dockerfile1 .
```

### 3. 推送镜像

```bash
# 推送镜像到 Docker Hub
docker push smilecamo99/my-app:0.01

# 如果要推送多个标签
docker push smilecamo99/my-app:latest
```

### 4. 管理镜像标签

```bash
# 为现有镜像创建新标签
docker tag smilecamo99/my-app:0.01 smilecamo99/my-app:latest

# 删除本地标签
docker rmi smilecamo99/my-app:0.01
```

### 5. 验证上传

```bash
# 从 Docker Hub 拉取镜像以验证
docker pull smilecamo99/my-app:0.01
```

注意事项：

1. 确保已经在 Docker Hub 注册账号
2. 镜像名必须包含你的 Docker Hub 用户名作为前缀
3. 推送前确保本地镜像构建成功
4. 保持良好的版本标签管理习惯
5. 注意镜像大小，尽量优化镜像体积
