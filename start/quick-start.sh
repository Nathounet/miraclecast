### MiracleCast ###

## First of, get the project source:
# $ git clone https://github.com/nathanbv/miraclecast
# $ cd miraclecast/start/
# $ ./quick-start.sh

## Install dependencies:
echo -e "\n>> Installing dependencies..."
sudo apt update
sudo apt install gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-pulseaudio gstreamer1.0-alsa gstreamer1.0-tools gstreamer1.0-libav libglib2.0-dev autoconf autogen libtool libudev-dev libsystemd-dev libreadline-dev -y

# The following dependencies are need only on RPi/ARM:
PLTFM=$(cat /proc/cpuinfo | grep ARM)
if [ "$PLTFM" ];
then
  sudo apt install gstreamer1.0-omx gstreamer1.0-omx-generic gstreamer1.0-rtsp -y
fi

# Checks
cd ../res
echo -e "\n>> Hardware capabilitiy check:"
./test-hardware-capabilities.sh
echo -e "\n>> Software requirement check:"
./test-viewer.sh
echo ">> Please verify results of above checks."
read -p "   Then press any key to continue... " -n1 -s

## Build MiracleCast project:
echo -e "\n>> Start building MiracleCast..."
cd ..
mkdir build
cd build
../autogen.sh g
make
sudo make install
cp ../start/miraclecastrc /root/.config/

## Run MiracleCast as sink:
# Kill wpa_supplicant and NetworkManager to allow miracle-wifid to create a wifi-p2p interface
echo -e "\n>> Launching MiracleCast for the first time..."
cd ../res/
./launch.sh

# Connect phone or laptop via Miracast/MirrorShare/Wireless Display

## Exit and restore normal interface
# "quit" to exit miracle-sinkctl
# In miraclecast/res run normal-wifi.sh to restore normal connection
