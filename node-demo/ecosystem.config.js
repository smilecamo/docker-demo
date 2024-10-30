module.exports = {
  apps: [
    {
      name: "app-8000",
      script: "/usr/share/node-demo/8000/index.js",
      instances: 1,
      autorestart: true,
      watch: false,
      max_memory_restart: "1G",
    },
    {
      name: "app-8001",
      script: "/usr/share/node-demo/8001/index.js",
      instances: 1,
      autorestart: true,
      watch: false,
      max_memory_restart: "1G",
    },
  ],
};
