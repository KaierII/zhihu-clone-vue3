module.exports = {
  apps: [{
    name: 'zhihudaily',
    script: 'node_modules/.bin/vite',
    args: 'preview --port 3000 --host 0.0.0.0',
    cwd: '/home/ubuntu/chiandwan',
    instances: 1,
    autorestart: true,
    watch: false,
    max_memory_restart: '1G',
    env: {
      NODE_ENV: 'production',
      HOST: '0.0.0.0',
      PORT: 3000
    }
  }]
}
