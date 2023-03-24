# Create a Kubernetes persistent storage manifest that gets 250MB of disk space on the host computer in the /temp/k8s directory.
# Create a corresponding persistent storage claim manifest file.

kubectl apply -f persistent-storage.yml
kubectl apply -f persistent-storage-claim.yml

kubectl get persistentvolumes
kubectl get persistentvolumes -o yaml

kubectl get pvc custom-pvc
kubectl get pvc custom-pvc -o yaml
