要使用 Docker 运行 Nginx，您可以按照以下步骤操作。这将帮助您在本地机器上快速启动一个 Nginx 服务器。

# 步骤 1: 拉取 Nginx 镜像

首先，您需要从 Docker Hub 拉取 Nginx 的官方镜像。您可以在终端中运行以下命令：

```Bash
docker pull nginx
```

# 步骤 2: 运行 Nginx 容器

接下来，您可以使用以下命令运行 Nginx 容器：

```Bash
docker run --name my-nginx -p 8080:80 -d nginx
```

--name my-nginx：为容器指定一个名称。
-p 8080:80：将本地机器的 8080 端口映射到容器的 80 端口。
-d：在后台运行容器。

# 步骤 3: 访问 Nginx

在浏览器中访问 http://localhost:8080，您应该会看到 Nginx 的欢迎页面。
代码解释
docker pull nginx：从 Docker Hub 下载 Nginx 镜像。
docker run：启动一个新的容器。
-p 8080:80：端口映射，允许您通过本地机器的 8080 端口访问容器内的 Nginx 服务。

# 使用 Dockerfile 运行 Nginx

```bash
# 构建自定义的 nginx 镜像
docker build -t my-custom-nginx .
# -t: 为镜像指定标签名
# .: 使用当前目录下的 Dockerfile

# 运行自定义的 nginx 容器
docker run --name my-nginx -p 8080:80 -d my-custom-nginx
# --name: 指定容器名称为 my-nginx
# -p: 将容器的80端口映射到主机的8080端口
# -d: 在后台运行容器
# my-custom-nginx: 使用我们刚才构建的自定义镜像
```

# 编辑线上的 nginx

```bash
# 先将容器中的配置复制到本地
docker cp my-nginx:/etc/nginx/conf.d/default.conf ./default.conf
# 本地编辑后复制回容器
docker cp ./default.conf my-nginx:/etc/nginx/conf.d/default.conf
# 检查配置是否正确
docker exec my-nginx nginx -t

# 如果配置正确，重载 Nginx
docker exec my-nginx nginx -s reload
# 查看配置内容
docker exec my-nginx cat /etc/nginx/conf.d/default.conf

# 查看 Nginx 状态
docker exec my-nginx nginx -T

# 查看错误日志
docker exec my-nginx tail -f /var/log/nginx/error.log
# 恢复备份的配置
docker cp ./default.conf.backup my-nginx:/etc/nginx/conf.d/default.conf

# 重载配置
docker exec my-nginx nginx -s reload
# 进入容器
docker exec -it my-nginx bash

# 备份配置文件
cp /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak

# 或者从容器复制到本地备份
docker cp my-nginx:/etc/nginx/conf.d/default.conf ./default.conf.backup
```

# 进入 nginx 容器

```bash
docker exec -it my-nginx /bin/bash
```

- docker exec：用于在运行中的容器中执行命令。
- -it：允许您以交互模式进入容器。
- /bin/sh：在容器中启动一个 shell。

# 退出容器

```bash
exit
```

# 查看 nginx

可以看到 nginx 的版本和配置文件路径
配置文件常见的位置在
/etc/nginx/conf
/usr/local/etc/conf
/opt/homebrew/etc/nginx

```bash
nginx -V
nginx -t
```

# 停止 nginx

```bash
nginx -s signal
```

# 重启 nginx

```bash
nginx -s reload
```

# 查看 nginx 进程

```bash
ps -ef | grep nginx
```

# 移动 nginx 配置文件

```bash
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
```

# 新建 nginx 配置文件

```bash
touch /etc/nginx/nginx.conf
```
