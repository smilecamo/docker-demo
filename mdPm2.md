# 1. 基本 PM2 运行命令

docker exec my-nginx pm2 start /opt/node-demo/8000/index.js

# 2. 带参数的 PM2 启动

docker exec my-nginx pm2 start /opt/node-demo/8000/index.js \
 --name "node-app" \
 --watch \
 --max-memory-restart 300M

# 3. 使用 PM2 配置文件启动

docker exec my-nginx pm2 start ecosystem.config.js

# 启动应用

docker exec my-nginx pm2 start /opt/node-demo/8000/index.js

# 查看运行状态

docker exec my-nginx pm2 list

# 查看日志

docker exec my-nginx pm2 logs

# 停止应用

docker exec my-nginx pm2 stop all # 停止所有
docker exec my-nginx pm2 stop node-app # 停止特定应用

# 重启应用

docker exec my-nginx pm2 restart node-app

# 删除应用

docker exec my-nginx pm2 delete node-app

```js
// ecosystem.config.js
module.exports = {
  apps: [
    {
      name: "node-app",
      script: "/opt/node-demo/8000/index.js",
      watch: true,
      max_memory_restart: "300M",
      env: {
        NODE_ENV: "production",
        PORT: 8000,
      },
    },
  ],
};
```
