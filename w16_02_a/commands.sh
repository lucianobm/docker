# Create 2 networks
docker network create Development
docker network create Production

# Build the images
docker image build -t repo_python -f repo1.Dockerfile .
docker image build -t repo_python_boto3 -f repo2.Dockerfile .
docker image build -t repo_python_cicd -f repo3.Dockerfile .

# Run containers
# Place one container on a network called Development
# Place the other two on network called Production
docker run -d -t --name repo_python --network Development repo_python
docker run -d -t --name repo_python_boto3 --network Production repo_python_boto3
docker run -d -t --name repo_python_cicd --network Production repo_python_cicd

# Verify container on the Development network cannot communicate with the other containers
# Should not work

docker exec repo_python ping repo_python_boto3
docker exec repo_python ping repo_python_cicd

# Verify containers on the Production network can communicate with each other
# Should work

docker exec repo_python_boto3 ping repo_python_cicd
docker exec repo_python_cicd ping repo_python_boto3
