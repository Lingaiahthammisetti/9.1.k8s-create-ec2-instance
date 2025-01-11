#!/bin/bash

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp 
sudo mv /tmp/eksctl /usr/local/bin 
eksctl version

curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.30.0/2024-05-12/bin/linux/amd64/kubectl 
sudo chmod +x ./kubectl
sudo mv kubectl  /usr/local/bin/
kubectl version --client

eksctl create cluster --config-file=eks.yaml
