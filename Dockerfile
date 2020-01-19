# Official Julia Docker image
# =>> https://github.com/docker-library/julia
#
FROM docker.io/julia:latest

RUN echo "Updating Packages" && apt-get update

RUN echo "Installing Components ...." && \
    apt-get install -y sqlite         && \
    apt-get install -y git            && \
    apt-get install -y curl           && \
    apt-get install -y cmake          && \
    apt-get install -y gfortran       && \
    apt-get install -y hdf5-tools     && \
    apt-get install -y qtbase5-dev    && \
    apt-get install -y x11-apps

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

# RUN  julia -e "Pkg.add(\"Plots\")" && \
#      julia -e "Pkg.add(\"PyPlot\")" && \
#      julia -e "Pkg.add(\"IJulia\")" && \
#      julia -e "Pkg.add(\"DataFrames\")" && \
#      julia -e "Pkg.add(\"Distributions\")" && \

ENV LANG en_US.utf8
# Docker Entry Point
CMD ["julia"]
