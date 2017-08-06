## Build a docker container for the desired version of MongoDB 


This repository contains a **Dockerfile** that helps you build a [MongoDB](http://www.mongodb.org/) [Docker](https://www.docker.com/) container. 
This Dockerfile, despite many others available online, support and let's you specify the desired version of MongoDB; also versions before of 3.2, like 2.6.10 are supported. 

### Installation

1. Install [Docker](https://www.docker.com/).

### Build
You can pass the desired mongo version as an argument of the build command. 
If you do not specify --build-arg VERSION=<version number>, by default 2.6.10 will be used.
The list of available versions can be found at [this link](http://downloads-distro.mongodb.org/repo/ubuntu-upstart/dists/dist/10gen/binary-amd64/)
```shell
docker build -t yourdockerusername/mongodb2.6.10 github.com/AndreaPravato/docker-mongodb --build-arg VERSION=2.6.10
```



### Usage

#### Run `mongod`

    docker run -d -p 27017:27017 --name mongodb yourdockerusername/mongodb

#### Run `mongod` w/ persistent/shared directory

    docker run -d -p 27017:27017 -v <db-dir>:/data/db --name mongodb yourdockerusername/mongodb

#### Run `mongod` w/ HTTP support

    docker run -d -p 27017:27017 -p 28017:28017 --name mongodb yourdockerusername/mongodb mongod --rest --httpinterface

#### Run `mongod` w/ Smaller default file size

    docker run -d -p 27017:27017 --name mongodb yourdockerusername/mongodb mongod --smallfiles

#### Run `mongo`

    docker run -it --rm --link mongodb:mongodb yourdockerusername/mongodb bash -c 'mongo --host mongodb'

##### Usage with VirtualBox (boot2docker-vm)

_You will need to set up nat port forwarding with:_

    VBoxManage modifyvm "boot2docker-vm" --natpf1 "guestmongodb,tcp,127.0.0.1,27017,,27017"

_If boot2docker is already running:_

    boot2docker stop && VBoxManage modifyvm "boot2docker-vm" --natpf1 "guestmongodb,tcp,127.0.0.1,27017,,27017" && boot2docker restart

This will allow you to connect to your mongo container with the standard `mongo` commands.
