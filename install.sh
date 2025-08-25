#!/bin/bash
set -e

echo ">>> Installing dependencies..."
sudo apt update
sudo apt install -y cmake gnuplot ffmpeg \
    libswscale-dev libavcodec-dev libavformat-dev libavdevice-dev libavutil-dev libavfilter-dev \
    libglm-dev libcairo2-dev librsvg2-dev libglib2.0-dev libeigen3-dev libpng-dev git build-essential

echo ">>> Cloning MicroTeX..."
if [ ! -d ../MicroTeX-master ]; then
    git clone https://github.com/NanoMichael/MicroTeX.git ../MicroTeX-master
    cd ../MicroTeX-master
    mkdir -p build && cd build
    cmake .. && make -j$(nproc)
    cd ../../swaptube
else
    echo "MicroTeX already exists, skipping..."
fi

echo ">>> Building SwapTube..."
mkdir -p build && cd build
cmake ..
make -j$(nproc)
cd ..

echo ">>> Setup complete!"
echo "Try running: ./go.sh Klotski 640 360"
