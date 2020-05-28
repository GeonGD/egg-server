#!/bin/sh
d=`date "+%Y-%m-%d %H:%M:%S"`
ssh gds 'bash -s' <<ENDSSH

echo >&2 "info: ssh gds success"

ENDSSH

# 更新代码文件
scp -r app/ gds:/root/data/vhost/egg-server
scp -r config/ gds:/root/data/vhost/egg-server
scp app.ts gds:/root/data/vhost/egg-server
scp tsconfig.json gds:/root/data/vhost/egg-server
scp package.json gds:/root/data/vhost/egg-server

# 重启服务器进程
ssh gds 'bash -s' <<ENDSSH

echo >&2 "info: ssh gds success"

cd /root/data/vhost/egg-server

npm install --production

npm run clean

npm run ci 

npm start

ENDSSH