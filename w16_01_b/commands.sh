# Download any three repos to local host

git clone https://github.com/lucianobm/python.git
git clone https://github.com/lucianobm/python_boto3.git
git clone https://github.com/lucianobm/python_cicd.git

# Build the image
docker image build -t ubuntu_python_boto3 .

# Run containers - each container should have a bind mount to one of the repo directories
docker run -d -t --name repo_python -v /root/w16_01_b/python:/repo_python ubuntu_python_boto3
docker run -d -t --name repo_python_boto3 -v /root/w16_01_b/python_boto3:/repo_python_boto3 ubuntu_python_boto3
docker run -d -t --name repo_python_cicd -v /root/w16_01_b/python_cicd:/repo_python_cicd ubuntu_python_boto3

# Log into each container and verify access to each repo directory

docker exec repo_python ls repo_python

docker exec repo_python_boto3 ls repo_python_boto3

docker exec repo_python_cicd ls repo_python_cicd
