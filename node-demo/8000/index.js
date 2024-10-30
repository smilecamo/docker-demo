// 方法2：使用 Express（需要先安装：npm install express）
const express = require("express");
const app = express();
// 路由处理
app.get("/", (req, res) => {
  res.send("<h1>Hello World 8000!</h1>");
});

app.listen(8000, () => {
  console.log("服务器运行在 http://localhost:8000/");
});
