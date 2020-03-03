# Official Julia Docker image
# =>> https://github.com/docker-library/julia
#
FROM docker.io/julia:latest

RUN echo "Updating Packages" && apt-get update

RUN echo " =>>> Creating user: " && useradd -d /home/eniac -m eniac -s /bin/bash

RUN echo "Installing Components ...." && \
    apt-get install -y sqlite         && \
    apt-get install -y git            && \
    apt-get install -y curl           && \
    apt-get install -y cmake          && \
    apt-get install -y gfortran       && \
    apt-get install -y hdf5-tools     && \
    apt-get install -y qtbase5-dev    && \
    apt-get install -y x11-apps       && \
    apt-get install -y build-essential

RUN apt-get install -y libreadline-dev

USER eniac

RUN julia -e 'import Pkg; Pkg.add("InstantiateFromURL")'
RUN julia -e 'using Pkg; Pkg.add("Plots");   Pkg.REPLMode.pkgstr("add Plots     ;precompile");using Plots'
RUN julia -e 'using Pkg; Pkg.add("StatsPlots");   Pkg.REPLMode.pkgstr("add StatsPlots     ;precompile");using StatsPlots'
RUN julia -e 'using Pkg; Pkg.add("PyPlot"); Pkg.REPLMode.pkgstr("add PyPlot     ;precompile");using PyPlot'
RUN julia -e 'using Pkg; Pkg.add("IJulia");  Pkg.REPLMode.pkgstr("add IJulia     ;precompile");using IJulia'
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add CSV        ;precompile"); using CSV'
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add DataFrames ;precompile"); using DataFrames'
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add DataStreams;precompile"); using DataStreams'
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add JSON       ;precompile"); using JSON'
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add LibPQ      ;precompile"); using LibPQ'
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add SQLite     ;precompile"); using SQLite'
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add XLSX       ;precompile"); using XLSX'
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add Distributions  ;precompile"); using Distributions'
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add Roots  ;precompile"); using Roots'

# Machine Learning and statiscs packages 
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add RDatasets  ;precompile"); using RDatasets'
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add DecisionTree  ;precompile"); using DecisionTree'
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add MLBase  ;precompile"); using MLBase'
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add StatsBase  ;precompile"); using StatsBase'
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add TensorFlow  ;precompile"); using TensorFlow'


# Add packages for interfacing C++ 
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add Cxx  ;precompile"); using Cxx'
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add CxxWrap  ;precompile"); using CxxWrap'

# Add package for Automatic Differentiation (Dual Numbers) 
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add HyperDualNumbers  ;precompile"); using HyperDualNumbers'

# RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add Maxima  ;precompile"); using Maxima'

# Literate Programming (Report)
RUN julia -e 'import Pkg; Pkg.add("Weave"); using Weave'
# Symbolic Math Package
RUN julia -e 'import Pkg; Pkg.add("SymPy"); using SymPy'
# C++ Wrap
RUN julia -e 'import Pkg; Pkg.add("CxxWrap"); using CxxWrap'

RUN julia -e 'using Pkg; Pkg.add("ZMQ"); Pkg.add("Conda"); import Conda; Conda.add("jupyter")'

RUN julia -e 'using Pkg; Pkg.add("Interact"); using Interact'

RUN julia -e 'using Pkg; Pkg.add("OhMyREPL"); using OhMyREPL'

# Install Optimization packages
RUN julia -e 'using Pkg; Pkg.add("JuMP"); using JuMP'
RUN julia -e 'using Pkg; Pkg.add("Ipopt"); using Ipopt'

# Install automatic differentiation packages
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add ForwardDiff  ;precompile"); using ForwardDiff'
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add TaylorSeries ;precompile"); using TaylorSeries'
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add DualNumbers  ;precompile"); using DualNumbers'

# Install Debuggers
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add Debugger  ;precompile"); using Debugger'
# See: https://github.com/timholy/Rebugger.jl
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add Rebugger  ;precompile"); using Rebugger'
# See: https://github.com/oxinabox/MagneticReadHead.jl
RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add MagneticReadHead ;precompile"); using MagneticReadHead'



# Add new Conda Channel
RUN /home/eniac/.julia/conda/3/bin/python /home/eniac/.julia/conda/3/bin/conda  config --add channels r

# Install Octave (Matlab open source clone)
RUN /home/eniac/.julia/conda/3/bin/python /home/eniac/.julia/conda/3/bin/conda install  -c conda-forge octave

# Install R Language
RUN /home/eniac/.julia/conda/3/bin/python /home/eniac/.julia/conda/3/bin/conda install -c r r-rcpp

# Install R Language Jupyter Kernel
RUN /home/eniac/.julia/conda/3/bin/python /home/eniac/.julia/conda/3/bin/conda install -c r r-irkernel

# Install  JupyterLab
RUN /home/eniac/.julia/conda/3/bin/python /home/eniac/.julia/conda/3/bin/conda install -c conda-forge jupyterlab

# Install nbconvert
RUN /home/eniac/.julia/conda/3/bin/python /home/eniac/.julia/conda/3/bin/conda install -c anaconda nbconvert

# Install Tabulate
RUN /home/eniac/.julia/conda/3/bin/python /home/eniac/.julia/conda/3/bin/conda install -c conda-forge tabulate

# Jupyter notebook extension which support coding auto-completion based on Deep Learning
RUN /home/eniac/.julia/conda/3/bin/python /home/eniac/.julia/conda/3/bin/pip install jupyter-tabnine

# Jupyter notebook extension which support coding auto-completion based on Deep Learning
RUN /home/eniac/.julia/conda/3/bin/python /home/eniac/.julia/conda/3/bin/pip install jupyter-datatables

RUN /home/eniac/.julia/conda/3/bin/python /home/eniac/.julia/conda/3/bin/pip install jupyter-pyfilesystem

# Install Python Prompt Toolkit
RUN /home/eniac/.julia/conda/3/bin/python /home/eniac/.julia/conda/3/bin/pip install ptpython
RUN /home/eniac/.julia/conda/3/bin/python /home/eniac/.julia/conda/3/bin/pip install sklearn
# RUN /home/eniac/.julia/conda/3/bin/python /home/eniac/.julia/conda/3/bin/pip install torch
RUN /home/eniac/.julia/conda/3/bin/python /home/eniac/.julia/conda/3/bin/pip install pandas

#========== Install R-Language Packages ============#

# RUN /home/eniac/.julia/conda/3/bin/R -e "install.packages('ggplot2')"
# RUN /home/eniac/.julia/conda/3/bin/R -e "install.packages('tidyverse')"
# RUN /home/eniac/.julia/conda/3/bin/R -e "install.packages('modelr')"
# R UN /home/eniac/.julia/conda/3/bin/R -e "install.packages('broom')"


# ========= Latex ==================================#

USER root

RUN  apt-get install -y latex2html     && \
    apt-get install -y texlive-latex-base && \
    apt-get install -y texlive-latex-base && \
    apt-get install -y texlive-lang-english && \
    apt-get install -y wxmaxima && \
    apt-get install -y texlive-generic-recommended

RUN  apt-get install -y tmux


# Install ATOM Editor and Julia supporting packages
RUN curl -L -o /tmp/atom.deb "https://atom-installer.github.com/v1.44.0/atom-amd64.deb" && \
    apt-get update && \
    apt install -y /tmp/atom.deb

#======= Entry Point ==============================#

# Copy Julia configuration file to Docker.
COPY ./startup.jl /home/eniac/.julia/config/startup.jl

# Copy IPython configuration file
COPY ./ipython_profile.py /home/eniac/

COPY bashrc /home/eniac/.bashrc

# Change default-user to a non-privileged one
USER eniac

RUN apm install atomic-emacs language-julia julia-client ink latex-completions \
    jupyter-notebook indent-detective tool-bar highlight-selected atom-file-icons

RUN julia -e 'using Pkg; Pkg.REPLMode.pkgstr("add Juno ;precompile"); using Juno'


# Set bash prompt
ENV PS1=" >>>"
ARG PS1=" >>>"

ENV LANG en_US.utf8

# Docker Entry Point
CMD ["tmux", "new", "-s", "mysession", "/usr/local/julia/bin/julia"]
