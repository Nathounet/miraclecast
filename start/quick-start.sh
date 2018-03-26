### MiracleCast ###

## First of, get the project source:
# $ git clone https://github.com/nathanbv/miraclecast
# $ cd miraclecast/start/

## Install dependencies:
sudo apt update
sudo apt install gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-pulseaudio gstreamer1.0-alsa gstreamer1.0-tools gstreamer1.0-libav libglib2.0-dev autoconf autogen libtool libudev-dev libsystemd-dev libreadline-dev -y

PLTFM=$(cat /proc/cpuinfo | grep ARM)
if [ -ez "$PLTFM" ];
then
  # The following dependencies are need only on RPi/ARM:
  sudo apt install gstreamer1.0-omx gstreamer1.0-omx-generic gstreamer1.0-rtsp -y
fi

# Checks
cd ../res
sudo ./test-viewer.sh
sudo ./test-hardware-capabilities.sh
read -p "Please verify results of above checks. Then press any key to continue... " -n1 -s

## Build MiracleCast project:
cd ..
mkdir build
cd build
../autogen.sh g
make
sudo make install
mkdir ~/.config/
cp miraclecastrc ~/.config/

## Run MiracleCast as sink:
# Kill wpa_supplicant and NetworkManager to allow miracle-wifid to create a wifi-p2p interface
cd ../res/
./launch.sh

# Connect phone or laptop via Miracast/MirrorShare/Wireless Display

## Exit and restore normal interface
# "quit" to exit miracle-sinkctl
# In miraclecast/res run normal-wifi.sh to restore normal connection
