# Flask API server Automati deployment in minikube 

Requirments
---------------------------
1. Create a webserver 
2. response in json 
3. only accepts connections to /tree path 
5. requires at least one unit tests 
6. A Dockerfile to build and package your application
7. Kubernetes manifests to deploy application into minikube cluster using kubectl
8. An Ingress manifest which will route to your web server only on the following URL:http://local.ecosia.org/tree
9. A build script which, in a single command, takes care of building, packaging and deploying your application and configuring your minikube cluster. (You can assume minikube is already installed.)
10. A README which includes all relevant information about the assignment


Assumptions 
--------------------
1. Minikube is intalled and started. 
2. no docker runtime/server on the deployment pc 
3. don't want to share the registry keys for storing the build package hence no external image registries are used. making use of image registry inside minikube 
4. no external/other CI/CD tools are used. 



How to run 
---------------------
Step 1: git clone git@github.com:vysakhchandran/deptominikube.git
step 2: cd deptominikube
step 3: /bin/bash build_deploy.sh 
step 4: provide sudo password when prompted to automatically update to hosts file or ctr+c to terminate the program and manually place the entry. 
step 5: curl http://local.ecosia.org/tree to access the entry point. 

Log Capure from my run
--------------------
