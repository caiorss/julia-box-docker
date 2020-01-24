#!/usr/bin/env sh
DOCKER_IMAGE_NAME=julia-box-shell
DOCKER_ARGUMENTS="${@:2}"
DOCKER_USER=eniac

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

        case "$2" in

            # Start jupyter notebook server
            start)
                docker run --rm -it --name jupyter-server --detach -e DISPLAY \
                       --env HOST_UID=$(id -u)   \
                       --env HOST_GUID=$(id -g)  \
                       -p 8888:8888 \
                       -v $PWD:/work \
                       -w /work \
                       -v /tmp/.X11-unix:/tmp/.X11-unix \
                       -v $HOME/.Xauthority:/root/.Xauthority \
                       --net=host $DOCKER_IMAGE_NAME \
                       /home/$DOCKER_USER/.julia/conda/3/bin/python  /home/$DOCKER_USER/.julia/conda/3/bin/jupyter-notebook

                echo " =>> Type ctrl + C to close logs."
                echo " =>> Run '$0 jupyter log' to show logs. "
                docker logs -f jupyter-server
                ;;

            # Stop server
            stop)
                docker stop jupyter-server
                ;;

            # View log
            log)
                docker logs -f jupyter-server
                ;;
            *)
                echo " Usage: $0 jupyter [start | stop | log]"
                exit 1
                ;;
        esac

        ;;

    # Open bash Unix login shell
    sh|bash)
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
