# RPi Streaming Camera

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

echo "alias serve='cd stream-cam-web && npm run dev & node ~/stream-cam/server/index.js'" >> ~/.bashrc
echo "alias cam='~/stream-cam/mediamtx'" >> ~/.bashrc
echo "alias web='cd stream-cam-web && npm run dev'" >> ~/.bashrc
echo "alias stop='killall node & killall vite & killall mediamtx'" >> ~/.bashrc
echo "alias update='stop & sleep 1s && cd ~/stream-cam-web/ && git reset --hard && git pull && npm i && cd ~/stream-cam/ && git reset --hard && git pull && cd server && cp mediamtx.yml ~/mediamtx.yml && npm i'" >> ~/.bashrc
source ~/.bashrc

cd ~/
git clone https://github.com/JiningLiu/stream-cam/
cd stream-cam/server
cp ./mediamtx.yml ~/mediamtx.yml
npm i

cd ~/
git clone https://github.com/JiningLiu/stream-cam-web/
cd stream-cam-web
npm i

echo "serve" >> ~/.bashrc

sudo reboot
```

Your Pi will now reboot, and automatically start the server when it's on.

If you had previously used ethernet to connect to the Pi, or was using a different network not meant for streaming, you can now use VNC to access the GUI, and add the Wi-Fi network that you would like to use for video transmission.

Your Pi is now ready for live streaming!

### Updating

In order to update the software on your camera to the latest minor version on the major release installed, simply run `update` in the terminal of the Pi.

If you would like to upgrade your camera to a newer major release, you will need to wipe your Pi and reinstall the software.

## License

© 2024 Jining Liu, [MIT License](./LICENSE)