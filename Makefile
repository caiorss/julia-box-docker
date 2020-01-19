IMAGE := julia-box-shell 

# Run '$ make build' to build this docker image. 
build:
	docker build -t $(IMAGE) -f Dockerfile .

# Run '$ make run' to run Julia REPL / shell.
run:
	sh ./julia-box-shell.sh
