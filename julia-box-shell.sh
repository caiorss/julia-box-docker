#!/usr/bin/env sh
DOCKER_IMAGE_NAME=julia-box-shell
DOCKER_ARGUMENTS="${@:2}"
DOCKER_USER=eniac
CONDA_BIN=/home/$DOCKER_USER/.julia/conda/3/bin
PYTHON=/home/$DOCKER_USER/.julia/conda/3/bin/python

HISTORY_FILE=$HOME/.julia_repl_history.jl

touch $HISTORY_FILE 

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

    Open Jupyter Notebook (IJulia)
     => \$ $0 jupyter
     => \$ $0 ju

    Open Jupyter-Lab  Notebook (IJulia)
     => \$ $0 jupyter-lab 

    Open Jupyter QtConsole (IJulia)
     => \$ $0 jupyter
     => \$ $0 ju

    Open Jupyter QtConsole (IPython)
     => \$ $0 qtconsole 

   Open Jupyter Octave (Matlab Clone) REPL
     => \$ $0 octave 
EOF
        ;;

    # Julia REPL
    jl|julia)

        # Allow X Server connection from Docker
        # and enabling displaying GUI - Graphical User Interface (Qt, Gtk ...)
        xhost +local:docker

        docker run -it --rm -e DISPLAY \
       --env HOST_UID=$(id -u)   \
       --env HOST_GUID=$(id -g)  \
       -p 8888:8888 \
       -v $PWD:/work \
       -w /work \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v $HOME/.Xauthority:/root/.Xauthority \
       -v $HISTORY_FILE:/home/eniac/.julia/logs/repl_history.jl \
       --net=host $DOCKER_IMAGE_NAME julia $DOCKER_ARGUMENTS
        xhost -
        ;;

    # Jupyter QTConsole 
    jqc|jupyter-qtconsole)

        # Allow X Server connection from Docker
        # and enabling displaying GUI - Graphical User Interface (Qt, Gtk ...)
        xhost +local:docker

        docker run -it --rm --detach -e DISPLAY \
       --env HOST_UID=$(id -u)   \
       --env HOST_GUID=$(id -g)  \
       -p 8888:8888 \
       -v $PWD:/work \
       -w /work \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v $HOME/.Xauthority:/root/.Xauthority \
       --net=host $DOCKER_IMAGE_NAME $PYTHON $CONDA_BIN/jupyter qtconsole --kernel=julia-1.3

        xhost -
        ;;

    ipy|ipython)
        # Allow X Server connection from Docker
        # and enabling displaying GUI - Graphical User Interface (Qt, Gtk ...)
        xhost +local:docker

        docker run -it --rm  -e DISPLAY \
       --env HOST_UID=$(id -u)   \
       --env HOST_GUID=$(id -g)  \
       -p 8888:8888 \
       -v $PWD:/work \
       -w /work \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v $HOME/.Xauthority:/root/.Xauthority \
       --net=host $DOCKER_IMAGE_NAME $PYTHON $CONDA_BIN/ipython 

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
                       $PYTHON  /home/$DOCKER_USER/.julia/conda/3/bin/jupyter-notebook

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

    # Jupyter-lab / IJulia Notebook (Port 8888)
    jupyter-lab)

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
                       $PYTHON  /home/$DOCKER_USER/.julia/conda/3/bin/jupyter-lab --no-browser

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
                echo " Usage: $0 jupyter-lab [start | stop | log]"
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

    # Run octave shell (open source Matlab Clone)
    octave)
        xhost +local:docker 2> /dev/null
        
        docker run -it -e DISPLAY \
       --env HOST_UID=$(id -u)   \
       --env HOST_GUID=$(id -g)  \
       -p 8888:8888 \
       -v $PWD:/work \
       -w /work \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v $HOME/.Xauthority:/root/.Xauthority \
       --net=host $DOCKER_IMAGE_NAME $CONDA_BIN/octave-cli

        xhost -
        ;;

    *)
    echo " Error: invalid option. expected $0 [ julia | ijulia | help]"
    exit 1
esac
