# Description

Files of this repository allows to create Docker image for linked project 
(submodule) [sample-http-api](https://github.com/Trofogol/sample-http-api).


# Prerequisites

- Docker (tested on version 19.03.10)

- MySQL node (must be accessable from Docker container on your host)

- Unpacked database backup `test_corp-dump.sql` on MySQL node (API 
interacts with it)

- [for Docker Swarm usage] Docker Compose v. 3.2+ ([install manual](https://docs.docker.com/compose/install/))

# Build

- Clone this repo (with submodule) on your node with Docker

        $ git clone --recurse-submodules <this repo link>

- Edit `config.yml` file from `sample-http-api` submodule. Set up correct address 
and port of mysql database node. Also, set up correct password and username to get 
access to it.

## Single container

- Build Docker image using `Dockerfile` (you can alter it before build, 
refer to [documentation](https://docs.docker.com/engine/reference/builder/) 
to not make mistakes):

        $ docker build -t sample-api:0.1 .

> `-t` (`--tag`) flag sets tag to created image. You can use it as name of image 
(instead of long unreadable id). Here tag is `sample-api:0.1`

- Run (create from new image and start) Docker container:

        $ docker run -d --name api --publish 8080:9090 sample-api:0.1

> `--publish` flag tells Docker to map container's port 9090 to host's port 8080
(you'll have to connect to localhost port 8080 to connect to container's port 9090)

> `--name` flag sets custom name for container. You can use custom name, 
original image name or long unreadable id of container to specify it to any 
further command. `-d` flag instructs container to run in detached (background) 
mode

## Docker Swarm

> When working with Docker Compose, use a directory with docker-compose.yml 
file as working directory

- start and prepare all swarm nodes: install Docker on them, [enable swarm]
(https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/) 
and [add every one to swarm](https://docs.docker.com/engine/swarm/swarm-tutorial/add-nodes/)

- build image using Docker Compose

        $ docker-compose build

- [optional] test built image with Docker Compose

        $ docker-compose up -d                  # launch single test version of image
        $ curl 127.0.0.1:80			# must get main page of API
        $ curl 127.0.0.1:80/mysql/offices/all   # if you get HTTP 500, check MySQL and relative config
        $ docker-compose down --volumes		# remove test service

- launch registry container to store built image (you need it to launch image 
on all nodes)

        $ docker service create --name reg --publish 5000:5000 registry

- [optional] check registry

        $ docker service ls	   # check if it launched
        $ curl localhost:5000/v2/  # check if it answers

> expected answer is `{}`

- adjust your docker on every swarm node to connect to your registry via HTTP, not 
HTTPS

> only needed if you want to use several swarm nodes and don't want to [set up 
HTTPS](https://docs.docker.com/registry/deploying/#run-an-externally-accessible-registry)

Create (or append to) a file `/etc/docker/daemon,json` address of your 
node with running Docker registry (it's `10.10.10.10` here) on ___every swarm node___

        { "insecure-registries":["10.10.10.10:5000"] }

- push your built image to registry

> Docker Compose will push it to address that is specified in 
`docker-compose.yml` file, also it will be pulled from same 
address too, so set appropriate address (not loopback).

        $ docker-compose push

- Deploy service as stack

        $ docker stack deploy --compose-file docker-compose.yml api

> name stack as you want, I named it shortly "api"

# Usage

## Single container

Check working containers

        $ docker ps

> add `--all` flag after this command to get full list of existing containers

Stop running container

        $ docker stop api

Start stopped container

        $ docker start api

> You can use custom name (`api` in this example), original image name (tag) 
or long unreadable id of container

## Swarm (stack)

Update config

[Edit](https://docs.docker.com/compose/compose-file/) docker-compose.yml and 
re-deploy your stack (use same name of stack that is already running)

> only `deploy` section will be updated by this command. If you need to edit 
build section, then you'll need to rebuild image by Compose and push new 
version to registry

        $ docker stack deploy --compose-file docker-compose.yml api

Remove stack

        $ docker stack rm api
