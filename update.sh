#!/bin/bash

stop & sleep 1s
cd ~/stream-cam-web/
git reset --hard
git pull
npm i
cd ~/stream-cam/
git reset --hard
git pull
chmod +x update.sh
cd server
cp mediamtx.yml ~/mediamtx.yml
npm i
sudo reboot