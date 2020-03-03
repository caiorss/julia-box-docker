DOCKER_USER=eniac
CONDA_BIN=/home/$DOCKER_USER/.julia/conda/3/bin
PYTHON=/home/$DOCKER_USER/.julia/conda/3/bin/python

# Customize prompt 
export PS1=" $>> "

# Ipython alias 
alias ipy='$CONDA_BIN/ptipython -i /home/eniac/ipython_profile.py'
alias simpy='$CONDA_BIN/ptipython -i /home/eniac/ipython_profile.py'
alias octave='$DOCKER_IMAGE_NAME $CONDA_BIN/octave-cli'


