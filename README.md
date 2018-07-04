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

<minikube_ip> backatcha.server hippo.server 

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
  