#!/bin/bash
echo "Moving the repo for build................."
minikube ssh -- mkdir -p /home/docker/app
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i $(minikube ssh-key) * docker@$(minikube ip):/home/docker/app/
echo "Starting image build......................."
minikube ssh -- docker build -t flask_api_server /home/docker/app/ 
echo "Starting deployments on k8 cluster........."
kubectl apply -f flask-api-deployment.yaml
echo "Deploymet completed with success."
kubectl get pods
echo "Awaiting Ingress IP to be assigned...."
sleep 20
kubectl get ingress 
