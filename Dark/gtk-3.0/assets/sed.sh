#!/bin/sh
sed -i \
         -e 's/#1a1a1a/rgb(0%,0%,0%)/g' \
         -e 's/#d3dae3/rgb(100%,100%,100%)/g' \
    -e 's/#1a1a1a/rgb(50%,0%,0%)/g' \
     -e 's/#6e6e6e/rgb(0%,50%,0%)/g' \
     -e 's/#1a1a1a/rgb(50%,0%,50%)/g' \
     -e 's/#d3dae3/rgb(0%,0%,50%)/g' \
	"$@"
