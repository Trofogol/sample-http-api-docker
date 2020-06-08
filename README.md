# Description

Files of this repository allows to create Docker image for linked project 
(submodule) [sample-http-api](https://github.com/Trofogol/sample-http-api).

# Usage

## Prerequisites

- Docker (tested on version 19.03.10)

- MySQL node (must be accessable from Docker container on your host)

- Unpacked database backup `test_corp-dump.sql` on MySQL node (API 
interacts with it)

## Build

- Clone this repo (with submodule) on your node with Docker

        $ git clone --recurse-submodules <this repo link>

- Edit config.yml file from sample-http-api submodule. Set up correct address 
and of mysql database node. Also, set up correct password and username to get 
access to it.

- Build Docker image using Dockerfile (you can alter it before build, 
refer to [documentation](https://docs.docker.com/engine/reference/builder/) 
to not make mistakes):

        $ docker build -t sample-api:0.1 .

> `-t` (`--tag`) flag sets tag to created image. You can use it as name of image 
(instead of long unreadable id). Here tag is `sample-api:0.1`

- Run (create from new image and start) Docker container:

        $ docker run -d --name api --publish 8080:9090 sample-api:0.1

> `--name` flag sets custom name for container. You can use custom name, 
original image name or long unreadable id of container to specify it to any 
further command. `-d` flag instructs container to run in detached (background) 
mode

> `--publish` flag tells Docker to map container's port 9090 to host's port 8080
(you'll have to connect to localhost port 8080 to connect to container's port 
9090)

## Stopping and starting created container

Check working containers

        $ docker ps

> add `--all` flag after this command to get full list of existing containers

Stop running container

        $ docker stop api

Start stopped container

        $ docker start api

> You can use custom name (`api` in this example), original image name (tag) or long unreadable id of 
container
