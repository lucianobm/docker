#! /bin/sh

# On all nodes

# Kernel modules
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl parameters
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# Apply without reboot
sudo sysctl --system

# 
sudo apt update && sudo apt install -y containerd

# Containerd default configuration
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml

# Restart containerd
sudo systemctl restart containerd

# Update necessary packages
sudo apt-get update && \
sudo apt-get install -y apt-transport-https ca-certificates curl

# Public key download
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

# Add apt repository
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update repository and install tools
sudo apt-get update && \
sudo apt-get install -y kubelet kubeadm kubectl

# 
sudo apt-mark hold kubelet kubeadm kubectl

# On node1 (control plane)
kubeadm init --apiserver-cert-extra-sans xxx.xxx.xxx.xxx

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubeadm token create --print-join-command

# On each node
kubeadm join xxx.xxx.xxx.xxx:6443 --token <token> \
        --discovery-token-ca-cert-hash sha256:xxxxxxxxxxxxxxxxxxxx

# On node1 (control plane)
# Calico
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml

# or

# Wavenet
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

# Copy ~/.kube/config to local machine

#
kubectl apply -f deployment.yml
