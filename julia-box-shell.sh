#!/usr/bin/env sh
DOCKER_IMAGE_NAME=julia-box-shell
DOCKER_ARGUMENTS="${@:2}"


case  "$1" in

    h|help)
        cat <<EOF
 Julia docker wrapper.

Usage: $0 [COMMAND] [ARGUMENTS] ... 

    Show this help text 
  => \$ $0 help 
  => \$ $0 h

    Open Julia interactive REPL 
  => \$ $0 julia 
  => \$ $0 jl 

    Open Jupyter Notebook with IJulia 
  => \$ $0 jupyter 
  => \$ $0 ju

EOF
        ;;
    
    # Julia REPL
    jl|julia)

        # Allow X Server connection from Docker
        # and enabling displaying GUI - Graphical User Interface (Qt, Gtk ...)
        xhost +local:docker
        
        docker run -it -e DISPLAY \
       --env HOST_UID=$(id -u)   \
       --env HOST_GUID=$(id -g)  \
       -p 8888:8888 \
       -v $PWD:/work \
       -w /work \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v $HOME/.Xauthority:/root/.Xauthority \
       --net=host $DOCKER_IMAGE_NAME julia $DOCKER_ARGUMENTS

        xhost -
        ;;

    # Jupyter / IJulia Notebook (Port 8888)
    ju|jupyter)
        xhost +local:docker
        
        docker run -it -e DISPLAY \
       --env HOST_UID=$(id -u)   \
       --env HOST_GUID=$(id -g)  \
       -p 8888:8888 \
       -v $PWD:/work \
       -w /work \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v $HOME/.Xauthority:/root/.Xauthority \
       --net=host $DOCKER_IMAGE_NAME \
       /root/.julia/conda/3/bin/python  /root/.julia/conda/3/bin/jupyter-notebook --allow-root

        xhost -
        ;;

    # Open bash Unix login shell 
    bash)
        xhost +local:docker 2> /dev/null 
        
        docker run -it -e DISPLAY \
       --env HOST_UID=$(id -u)   \
       --env HOST_GUID=$(id -g)  \
       -p 8888:8888 \
       -v $PWD:/work \
       -w /work \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v $HOME/.Xauthority:/root/.Xauthority \
       --net=host $DOCKER_IMAGE_NAME bash

        xhost -        
        ;;  

    *)
    echo " Error: invalid option. expected $0 [ julia | ijulia | help]"
    exit 1
esac 
