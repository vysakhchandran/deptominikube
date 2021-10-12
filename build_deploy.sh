echo "Starting to clone the repo................."
minikube ssh -- git clone https://github.com/vysakhchandran/deptominikube.git
echo "Clone completed with success."
echo "Starting image build......................."
minikube ssh -- docker build -t flask_api_server /home/docker/deptominikube/ 
echo "build completed with success."
echo "Starting deployments on k8 cluster........."
kubectl apply -f https://raw.githubusercontent.com/vysakhchandran/deptominikube/main/flask-api-deployment.yaml
echo "Deploymet completed with success."
kubectl get pods
echo "Awaiting Ingress IP to be assigned...."
sleep 20
kubectl get ingress 
