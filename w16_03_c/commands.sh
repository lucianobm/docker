# Create 2 networks
docker network create Development
docker network create Production

# Recreate using Docker Compose
docker compose up -d

# Verify container on the Development network cannot communicate with the other containers
# Should not work

docker exec repo_python ping repo_python_boto3
docker exec repo_python ping repo_python_cicd

# Verify containers on the Production network can communicate with each other
# Should work

docker exec repo_python_boto3 ping repo_python_cicd
docker exec repo_python_cicd ping repo_python_boto3
