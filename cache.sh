#!/usr/bin/env bash

export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
export CCACHE_DIR=/home/kleidione/Source/ccache
ccache -M 50G -F 0
sudo mkdir -p /home/kleidione/.ccache &> /dev/null
sudo mount --bind /home/kleidione/Source/ccache ~/.ccache
