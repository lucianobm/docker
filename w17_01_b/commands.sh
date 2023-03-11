#! /bin/sh

# On node1
docker swarm init --advertise-addr <MANAGER-IP-ADDRESS>

# On nodes2 and 3
docker swarm join --token <TOKEN> <MANAGER-IP-ADDRESS>:2377

# Create a Docker Swarm that consists of one manager and two worker nodes
# Verify the cluster is working by deploying the following tiered architecture:

# On node1
docker node ls

docker network create -d overlay backend

docker network create -d overlay frontend

# a service based on the Redis docker image with 4 replicas
docker service create --name redis --network backend --replicas 4 redis:7.0.9

# a service based on the Apache docker image with 10 replicas
docker service create --name apache -p 80:80 --network frontend --replicas 10 httpd:2.4.56

# a service based on the Postgres docker image with 1 replica
docker service create --name db --network backend -e POSTGRES_PASSWORD=password --mount type=volume,source=db-data,target=/var/lib/postgresql/data postgres:15.2

# Visualizer
docker service create --name=viz --publish=8080:8080/tcp --constraint=node.role==manager --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock bretfisher/visualizer

# 
docker service ls