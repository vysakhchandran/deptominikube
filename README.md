# Flask API server Automatic deployment in minikube 

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
```
1. Step 1: git clone git@github.com:vysakhchandran/deptominikube.git
2. step 2: cd deptominikube
3. step 3: /bin/bash build_deploy.sh 
4. step 4: provide sudo password when prompted to automatically update to hosts file or ctr+c to terminate the program and manually place the entry. 
5. step 5: curl http://local.ecosia.org/tree to access the entry point. 
```

Log Capure from my run
--------------------
```

➜  deptominikube git:(main) ✗ minikube delete;minikube start;bash build_deploy.sh
🙄  "minikube" profile does not exist, trying anyways.
💀  Removed all traces of the "minikube" cluster.
😄  minikube v1.23.2 on Darwin 11.5.2
✨  Automatically selected the hyperkit driver. Other choices: virtualbox, ssh
👍  Starting control plane node minikube in cluster minikube
🔥  Creating hyperkit VM (CPUs=2, Memory=2200MB, Disk=20000MB) ...
🐳  Preparing Kubernetes v1.22.2 on Docker 20.10.8 ...
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  Enabled addons: storage-provisioner, default-storageclass
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
Moving the repo for build.................
Warning: Permanently added '192.168.64.9' (ECDSA) to the list of known hosts.
Dockerfile                                                                                                                                 100%  164   195.6KB/s   00:00
README.md                                                                                                                                  100%   15    25.3KB/s   00:00
__pycache__: not a regular file
app.py                                                                                                                                     100%  224   337.6KB/s   00:00
app.pyc                                                                                                                                    100%  704     1.1MB/s   00:00
app_test.py                                                                                                                                100%  750     1.2MB/s   00:00
build_deploy.sh                                                                                                                            100% 1672     4.0MB/s   00:00
flask-api-deployment.yaml                                                                                                                  100%  952     1.6MB/s   00:00
requirements.txt                                                                                                                           100%   12    26.3KB/s   00:00
Starting image build.......................
Sending build context to Docker daemon  12.29kB
Step 1/8 : FROM python:3.9.7-alpine3.14
3.9.7-alpine3.14: Pulling from library/python
a0d0a0d46f8b: Pull complete
ba51967de001: Pull complete
472f8c18fd1c: Pull complete
02e5da7e751e: Pull complete
747fc3ac0c47: Pull complete
Digest: sha256:4475d951839c2897bf6c27475545a25be8f711dc2e02408d8854bb89c19b8e05
Status: Downloaded newer image for python:3.9.7-alpine3.14
 ---> 057a5e165715
Step 2/8 : RUN mkdir -p /app
 ---> Running in bebb3a725e03
Removing intermediate container bebb3a725e03
 ---> b4c5abae154e
Step 3/8 : WORKDIR /app
 ---> Running in e96d6994aeb1
Removing intermediate container e96d6994aeb1
 ---> 4daa742a653c
Step 4/8 : COPY . .
 ---> abeb1c018773
Step 5/8 : RUN pip install -r requirements.txt
 ---> Running in c16b0b73fd6d
Collecting Flask==1.0.3
  Downloading Flask-1.0.3-py2.py3-none-any.whl (92 kB)
Collecting Jinja2>=2.10
  Downloading Jinja2-3.0.2-py3-none-any.whl (133 kB)
Collecting click>=5.1
  Downloading click-8.0.3-py3-none-any.whl (97 kB)
Collecting itsdangerous>=0.24
  Downloading itsdangerous-2.0.1-py3-none-any.whl (18 kB)
Collecting Werkzeug>=0.14
  Downloading Werkzeug-2.0.2-py3-none-any.whl (288 kB)
Collecting MarkupSafe>=2.0
  Downloading MarkupSafe-2.0.1.tar.gz (18 kB)
Building wheels for collected packages: MarkupSafe
  Building wheel for MarkupSafe (setup.py): started
  Building wheel for MarkupSafe (setup.py): finished with status 'done'
  Created wheel for MarkupSafe: filename=MarkupSafe-2.0.1-py3-none-any.whl size=9761 sha256=56a5b2cdeeec49d4b7f1a601af07f050ffa91665b8ac5faad6c2498d7551aea8
  Stored in directory: /root/.cache/pip/wheels/9f/6d/c8/1f59b07cf85ae842908006ec28f4477f7e4578df72c3eb0e46
Successfully built MarkupSafe
Installing collected packages: MarkupSafe, Werkzeug, Jinja2, itsdangerous, click, Flask
Successfully installed Flask-1.0.3 Jinja2-3.0.2 MarkupSafe-2.0.1 Werkzeug-2.0.2 click-8.0.3 itsdangerous-2.0.1
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
WARNING: You are using pip version 21.2.4; however, version 21.3 is available.
You should consider upgrading via the '/usr/local/bin/python -m pip install --upgrade pip' command.
Removing intermediate container c16b0b73fd6d
 ---> 2d57c234761a
Step 6/8 : RUN python app_test.py
 ---> Running in 3dad23d178f8
/usr/local/lib/python3.9/site-packages/flask/json/__init__.py:194: DeprecationWarning: Importing 'itsdangerous.json' is deprecated and will be removed in ItsDangerous 2.1. Use Python's 'json' module instead.
  rv = _json.dumps(obj, **kwargs)
...
----------------------------------------------------------------------
Ran 3 tests in 0.012s

OK
Removing intermediate container 3dad23d178f8
 ---> 92891c42444e
Step 7/8 : ENTRYPOINT ["python"]
 ---> Running in ecfd8a699c6c
Removing intermediate container ecfd8a699c6c
 ---> bbfaa725e5eb
Step 8/8 : CMD ["app.py"]
 ---> Running in 763dd3d83229
Removing intermediate container 763dd3d83229
 ---> a6fd27266e9d
Successfully built a6fd27266e9d
Successfully tagged flask_api_server:latest
Enabling local ingress for minikube........
    ▪ Using image k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.0
    ▪ Using image k8s.gcr.io/ingress-nginx/controller:v1.0.0-beta.3
    ▪ Using image k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.0
🔎  Verifying ingress addon...
🌟  The 'ingress' addon is enabled
Awaiting ingress to register................
Starting deployments on k8 cluster.........
deployment.apps/flask-deployment created
service/flask-service created
ingress.networking.k8s.io/ingress-wildcard-host created
Deploymet completed with success.
NAME                                READY   STATUS              RESTARTS   AGE
flask-deployment-77b68bfd78-4kdqm   0/1     ContainerCreating   0          1s
flask-deployment-77b68bfd78-ddwz5   0/1     ContainerCreating   0          1s
flask-deployment-77b68bfd78-zc9ct   0/1     ContainerCreating   0          1s
Awaiting Ingress IP to be assigned....
NAME                    CLASS   HOSTS              ADDRESS        PORTS   AGE
ingress-wildcard-host   nginx   local.ecosia.org   192.168.64.9   80      41s
Enter the sudo password to automatically add the below entry to your hosts file or you may terminate the program and place it manually
192.168.64.9 local.ecosia.org
Detected Mac Os updating host file.....
Password:
endpoint is now available at http://local.ecosia.org/tree
{
  "myFavouriteTree": "Tree1"
}
```
