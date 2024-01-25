# See if arguments are given and if not, print usage

args=$#
if [ $args -eq 0 ]
then
    echo "launch.sh build [--no-cache] - Build the Docker image using the Dockerfile"
    echo "launch.sh run - Start the Docker container if it exists, otherwise create it"
    exit 1
fi

# build
if [ $1 = "build" ]
then
    echo "Building Docker image... This may take a while."
    # check if --no-cache is given
    if [ $args -eq 2 ]
    then
        if [ $2 = "--no-cache" ]
        then
            docker build --no-cache -t "csc4100" .
            echo "Docker image built. Run 'launch.sh run' to hop into the container."
            exit 1
        fi
    fi
    docker build -t "csc4100" .
    echo "Docker image built. Run 'launch.sh run' to hop into the container."
    exit 1
fi

# run
if [ $1 = "run" ]
then
	if docker ps -a --format '{{.Names}}' | grep -q '^CSC4100$'; then
    	if docker inspect -f '{{.State.Running}}' CSC4100 2>/dev/null | grep -q 'true'; then
        	docker exec -it CSC4100 bash
    	else
        	docker start CSC4100 && docker exec -it CSC4100 bash
    	fi
	else
    	docker run --name "CSC4100" -v "$(pwd)/csc4100:/csc4100" -it -p 5000:5000 csc4100
	fi
    exit 1
fi

