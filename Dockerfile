# Use an official Ubuntu image as a base
FROM ubuntu:20.04

# Install necessary packages and MongoDB
RUN apt-get update && \
    apt-get install -y gnupg wget && \
    wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add - && \
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list && \
    apt-get update && \
    apt-get install -y mongodb-org && \
    mkdir -p /data/db

# Expose the default MongoDB port
EXPOSE 27017

# Copy the MongoDB configuration file
COPY mongod.conf /etc/mongod.conf

# Command to run MongoDB
CMD ["mongod", "--config", "/etc/mongod.conf"]