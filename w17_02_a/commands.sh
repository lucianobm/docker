#! /bin/sh

# On node1
docker swarm init --advertise-addr <MANAGER-IP-ADDRESS>

# On nodes2 and 3
docker swarm join --token <TOKEN> <MANAGER-IP-ADDRESS>:2377

# Create a Docker Stack using the Basic project requirements.
# Ensure no stacks run on the Manager (administrative) node.

# On node1
docker node ls

docker stack deploy -c docker-stack.yml stack-name

# 
docker stack ls
docker service ls
docker stack services stack-name
docker stack ps stack-name
