#!/usr/bin/env sh
DOCKER_IMAGE_NAME=julia-box-shell

xhost +local:docker

docker run -it -e DISPLAY \
       --env HOST_UID=$(id -u)   \
       --env HOST_GUID=$(id -g)  \
       -v $PWD:/work \
       -w /work \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v $HOME/.Xauthority:/root/.Xauthority \
       --net=host $DOCKER_IMAGE_NAME 
