IMAGE := julia-box-shell 

# Run '$ make build' to build this docker image. 
build:
	docker build -t $(IMAGE) -f Dockerfile .

# Run '$ make run' to run Julia REPL / shell.
run:
	sh ./julia-box-shell.sh

clean-all:
	@ # Delete all containers 
	docker rm $(shell docker ps -a -q)
	@ # Delete all images 
	docker rmi $(shell docker images -q)
