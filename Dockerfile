#
# MongoDB Dockerfile
#
# https://github.com/dockerfile/mongodb
#

# Pull base image.
FROM ubuntu:latest

# Install MongoDB.
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list
# If apt-get install were in a separate RUN instruction, then it would reuse a layer added by apt-get update, which could had been created a long time ago

# Declare desired mongodb version; by default sets 2.6.10
# This ARG instruction goes out of scope outside of this build stage (at next RUN)
# choose the version from here http://downloads-distro.mongodb.org/repo/ubuntu-upstart/dists/dist/10gen/binary-amd64/
ARG VERSION=2.6.10
RUN apt-get update && apt-get install -y mongodb-org=$VERSION mongodb-org-server=$VERSION mongodb-org-shell=$VERSION mongodb-org-mongos=$VERSION mongodb-org-tools=$VERSION && \
rm -rf /var/lib/apt/lists/*
# Create the MongoDB data directory
RUN mkdir -p /data/db

VOLUME ["/data/db"]

# Define working directory.
WORKDIR /data

# Set usr/bin/mongod as the default command (it can be overwritten from command line)
CMD ["/usr/bin/mongod"]

# Expose ports from the container to the host
# -27017: process
# -28017: http
EXPOSE 27017
EXPOSE 28017
