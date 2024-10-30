FROM node:18-alpine

# 安装 nginx 和其他必要工具
RUN apk add --no-cache nginx curl

# 安装 PM2
RUN npm install -g pm2

# 创建必要的目录
RUN mkdir -p /usr/share/nginx/html && \
    mkdir -p /usr/share/node-demo && \
    mkdir -p /etc/nginx/ssl

# 复制 Node.js 应用文件
COPY node-demo /usr/share/node-demo
COPY nginx-html /usr/share/nginx/html
COPY nginx-conf /etc/nginx
COPY ssl /etc/nginx/ssl

# 安装依赖
RUN cd /usr/share/node-demo/8000 && npm install 
RUN cd /usr/share/node-demo/8001 && npm install
# 启动 nginx
# 使用 shell 形式的 CMD 来启动多个服务
CMD ["sh", "-c", "pm2 start /usr/share/node-demo/ecosystem.config.js && nginx -g 'daemon off;'"]

# 暴露端口
EXPOSE 80 443 5177