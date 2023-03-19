# Spin up two deployments. One deployment contains 2 pods running the nginx image.
# Include a ConfigMap that points to a custom index.html page that contains the line “This is Deployment One”.
# The other deployment contains 2 pods running the nginx image.
# Include a ConfigMap that points to a custom index.html page that contains the line “This is Deployment Two”.

# Create the ConfigMaps
kubectl create configmap config-one --from-file=index.html=index-one.html
kubectl create configmap config-two --from-file=index.html=index-two.html

kubectl describe configmap config-one
kubectl describe configmap config-two

# Create the Deployments
kubectl apply -f deployment-one.yml
kubectl apply -f deployment-two.yml

# Create a service that points to both deployments. You should be able to access both deployments using the same ip address and port number.

# Create the shared service
kubectl apply -f lb-service.yml

#
kubectl get deployments
kubectl get pods
kubectl get svc
kubectl get all

# Validade that you eventual see the index.html pages from both Deployment 1 and Deployment 2
curl localhost












