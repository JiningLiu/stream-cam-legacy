# RPi Streaming Camera

> ❗We are working on an improved version of stream-cam. This repository is now a public archive.

> ⚠️ More info will be available at [JiningLiu/stream-cam](https://github.com/JiningLiu/stream-cam/) soon.

## Hardware

You will need:

- Raspberry Pi 5 2GB
- 32GB microSD Card
- Pi 5 Active Cooler
- Pi 5 Power Supply
- Raspberry Pi Camera Module 3
- Pi 5 Camera Ribbon Cable
- Router (only need one for all cameras)

...and the following:

- 4pcs M2 10mm
- 4pcs M2 nut
- 4pcs M2.5 10mm
- 4pcs M2.5 nut
- 4pcs M4 10mm
- 1pc 1/4-20 UNC nut
- 2pcs small zip/cable ties

Download the 3MF file located in the [hardware](./hardware) directory 3D print the parts.

Put together the setup according to the [assembly instructions](./hardware/ASSEMBLY.md).

## Software

### Installation

Use the [Raspberry Pi Imager](https://www.raspberrypi.com/software/) to flash SD card with [Raspberry Pi OS](https://www.raspberrypi.com/software/operating-systems/) (64-bit) with desktop ([version used for this release](https://downloads.raspberrypi.com/raspios_arm64/images/raspios_arm64-2024-07-04/2024-07-04-raspios-bookworm-arm64.img.xz))
- Setup SSH in Raspberry Pi Imager settings.
- Setup the Wi-Fi (wireless LAN) network that the Pi will be streaming video over.
  - This network should have access to the internet for initial setup. Alternatively, use ethernet or another Wi-Fi network with internet access, and setup the streaming network later.

Connect your computer to the same network you have just configured for the Pi. Then, plug in the Pi and wait a few minutes for initial setup to complete.

Use SSH to connect to the Pi with the credentials you have setup earlier. If you are unable to connect to the Pi over Wi-Fi, try using ethernet.

#### Follow these steps to finish setup.

Note that the commands below will take a bit of time to run.

```bash
sudo raspi-config
```
- Turn on VNC
- Set boot/login options to desktop (auto login)

```bash
sudo apt update
sudo apt upgrade
sudo apt install vim

curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.bashrc

nvm install --lts

echo "alias serve='cd ~/stream-cam-web && npm run preview & cd ~/stream-overlays && bun run preview & node ~/stream-cam-legacy/server/index.js'" >> ~/.bashrc
echo "alias cam='~/stream-cam-legacy/mediamtx'" >> ~/.bashrc
echo "alias web='cd stream-cam-web && npm run preview'" >> ~/.bashrc
echo "alias overlays='cd stream-overlays && bun run preview'" >> ~/.bashrc
echo "alias stop='killall node & killall vite & killall mediamtx & killall bun & lsof -ti :3000 :5281 :6232 | xargs kill
'" >> ~/.bashrc
echo "alias update='~/stream-cam-legacy/update.sh'" >> ~/.bashrc
source ~/.bashrc

cd ~/
git clone https://github.com/JiningLiu/stream-cam-legacy/
cd stream-cam-legacy
chmod +x update.sh
cd server
cp ./mediamtx.yml ~/mediamtx.yml
npm i

cd ~/
git clone https://github.com/JiningLiu/stream-cam-web/
cd stream-cam-web
npm i
npm run build

npm install -g bun

cd ~/
git clone https://github.com/JiningLiu/stream-overlays/
cd stream-overlays
bun i
bun run build

echo "serve" >> ~/.bashrc

sudo reboot
```

Your Pi will now reboot, and automatically start the server when it's on.

If you had previously used ethernet to connect to the Pi, or was using a different network not meant for streaming, you can now use VNC to access the GUI, and add the Wi-Fi network that you would like to use for video transmission.

Your Pi is now ready for live streaming!

### Updating

In order to update the software on your camera to the latest minor version on the major release installed, simply run `update` in the terminal of the Pi.

If you would like to upgrade your camera to a newer major release, you will need to wipe your Pi and reinstall the software.

## Licenses

© 2024 Jining Liu, [MIT License](./LICENSE)

### Credits

[bluenviron/mediamtx](https://github.com/bluenviron/mediamtx)

© 2019 aler9, [MIT License](https://github.com/bluenviron/mediamtx/blob/main/LICENSE)
