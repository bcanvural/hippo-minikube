# Run Hippo in Minikube

Install virtualbox https://www.virtualbox.org/wiki/Downloads

Install minikube https://github.com/kubernetes/minikube
```bash
brew cask install minikube
```
Start minikube with some additional resources

```bash
minikube --memory 8192 --cpus 2 start
```
Create the persistant volume and persistant volume claim for mysql. From kubernetes directory run:

```bash
kubectl create -f mysql-pv.yaml
```

Add an entry in your /etc/hosts file. Replace <minikube_ip> with the output of the command:

```bash
minikube ip
```
Add the following line in your /etc/hosts file:
```text
<minikube_ip> backatcha.server hippo.server
```
 
Enable ingress addon in minikube
```bash
minikube addons enable ingress
```

To deploy everything at once, from kubernetes directory run:

```bash
./deploy-all.sh
```

Start up the minikube dashboard:

```bash
minikube dashboard
```

When hippo pod(s) have started up, add the following virtual host config so channel manager works:
(Considering the host name is "hippo.server")
```yaml
/kube:
  jcr:primaryType: hst:virtualhostgroup
  jcr:uuid: 74f28b5a-90ff-43e7-8c7d-f8518039ef70
  hst:cmslocation: http://hippo.server/
  hst:defaultport: 8080
  /server:
    jcr:primaryType: hst:virtualhost
    jcr:uuid: 184b3423-8c59-47a7-9cd9-63f940e3d53e
    /hippo:
      jcr:primaryType: hst:virtualhost
      jcr:uuid: ff6ee315-c02a-4dd5-a880-f753196f02de
      /hst:root:
        jcr:primaryType: hst:mount
        jcr:uuid: e8f68f42-be8c-4571-b707-66d79ac19847
        hst:homepage: root
        hst:mountpoint: /hst:hst/hst:sites/myhippoproject
```

## Local Development without pushing to public docker registry
If you  want to do develepment in local projects but not want to push to public image registries, consider the following workflow:
* Make changes in local project, e.g. in hippo's site module.
* Recreate distribution file, e.g. mvn clean verify && mvn -Pdist
* Move distribution file to kubernetes/cms-site folder (remove any existing .tar.gz)
* To be able to work with the docker daemon on your mac/linux host use the docker-env command in your shell
```bash
eval $(minikube docker-env)
```
More info on the above command is at: https://kubernetes.io/docs/setup/minikube#reusing-the-docker-daemon
Note that you should keep using the same shell
* Now you can build the docker image and tag it at the same time, from kubernetes/cms-site directory:
```bash
docker build username/release-name:version .
```
You can replace the username, release-name, and version in the command above. Dot(.) refers to the location of the dockerfile which is in kubernetes/cms-site directory.
* At this point the docker image is tagged and pods in the cluster can pull this image. Go to a pod definition file and replace the image. E.g.
```yaml
#SNIP
 spec:
      containers:
        - name: hippo
          image: username/release-name:version #can pull since we ran the eval command
          ports:
            - containerPort: 8080
#-SNIP
```

## Remote debugger for your hippo project

if you want to debug the deployed hippo project within the cluster:
* Set the environment variable "JAVA_ENABLE_DEBUG" to true in hippo-deployment.yaml
* Uncomment the part that exposes the container port 5005 (in hippo-deployment.yaml)
```yaml
#SNIP
          ports:
            - containerPort: 8080
#           - containerPort: 5005
#             name: "jvm-debug" #Uncomment these  two lines
#-SNIP
```
* Activate port forwarding from localhost:5005 to pod's 5005 by running the command:
```bash
kubectl port-forward deployments/hippo 5005:5005
```
* Connect from IntelliJ (or other) remotely to localhost:5005 your breakpoints will be triggered

* If you have more than 1 hippo pod, and you want to trigger breakpoints for only 1 pod port-forward to the specific pod:

```bash
kubectl get pods #get the name of the pod you want to set breakpoints for
kubectl port-forward <pod_name_goes_here>  5005:5005
```

### Remarks
* conf/context.xml has mysql configured. This is typical mysql setup for a Hippo project except that the url for the database server points to:
  
  mysql.default.svc.cluster.local:3306
  
  First "mysql" part is the name of the kubernetes service name called mysql. More explanation: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/
* Pods pull docker images from public docker registry. If you want different docker images 
you need to build your own and push them to a registry that your local machine has access to
* You can build your own hippo docker image by putting your distribution tar.gz in kubernetes/cms-site directory and running:
```bash
docker build -t my-release:latest .
```
Then you can push it to a public registry and change the images in pod specification yaml files
* Backatcha-server is a simple spring boot app that prints a UUID.
  