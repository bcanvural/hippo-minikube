#Run Hippo in Minikube

```bash
minikube --memory 8192 --cpus 2 start
```
Create the persistant volume and persistant volume claim for mysql. From kubernetes directory run:

```bash
kubectl create -f mysql-pv.yaml
```

To deploy everything at once, from kubernetes directory run:

```bash
./deploy-all.sh
```

###Remarks
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
  