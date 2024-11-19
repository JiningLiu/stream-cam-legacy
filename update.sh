#!/bin/bash

stop & sleep 1s
cd ~/stream-overlays/
git reset --hard
git pull
bun i
bun run build
cd ~/stream-cam-web/
git reset --hard
git pull
npm i
npm run build
cd ~/stream-cam/
git reset --hard
git pull
chmod +x update.sh
cd server
cp mediamtx.yml ~/mediamtx.yml
npm i
sudo reboot