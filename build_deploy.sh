#!/bin/bash
echo "Moving the repo for build................."
minikube ssh -- mkdir -p /home/docker/app
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i $(minikube ssh-key) * docker@$(minikube ip):/home/docker/app/
echo "Starting image build......................."
minikube ssh -- docker build -t flask_api_server /home/docker/app/ 
echo "Enabling local ingress for minikube........ "
minikube addons enable ingress
echo "Awaiting ingress to register................"
sleep 20
echo "Starting deployments on k8 cluster........."
kubectl apply -f flask-api-deployment.yaml
echo "Deploymet completed with success."
kubectl get pods
echo "Awaiting Ingress IP to be assigned...."
sleep 40
kubectl get ingress 
echo "Enter the sudo password to automatically add the below entry to your hosts file or you may terminate the program and place it manually"
echo "`kubectl get ingress | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])'` local.ecosia.org"
if [ -f /private/etc/hosts ]; then
echo "Detected Mac Os updating host file....."
sudo sed -i.bak '/local.ecosia.org/d' /private/etc/hosts
echo "`kubectl get ingress | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])'` local.ecosia.org" | sudo tee /private/etc/hosts
fi

if [ -f /etc/hosts ]; then
sudo sed -i.bak '/local.ecosia.org/d' /etc/hosts
echo "`kubectl get ingress | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])'` local.ecosia.org" | sudo tee /etc/hosts
fi
echo "endpoint is now available at http;//local.ecosia.org/tree"
curl local.ecosia.org/tree