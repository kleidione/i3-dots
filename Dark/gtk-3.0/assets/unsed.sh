#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#1a1a1a/g' \
         -e 's/rgb(100%,100%,100%)/#d3dae3/g' \
    -e 's/rgb(50%,0%,0%)/#1a1a1a/g' \
     -e 's/rgb(0%,50%,0%)/#6e6e6e/g' \
 -e 's/rgb(0%,50.196078%,0%)/#6e6e6e/g' \
     -e 's/rgb(50%,0%,50%)/#1a1a1a/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#1a1a1a/g' \
     -e 's/rgb(0%,0%,50%)/#d3dae3/g' \
	"$@"