# Minimize base image footprint
1. Always use separeta images for different app. 
2. Do not store state in a container. Use external storage od cache instead.
3. Use imagess with authenticity, from offisial repos.
4. Prevent usage from unupdated images, due to securit vulnerabilities.
5. Keep image smal as possible, do not include into the image tools like wget, curl, package manager, use milti-stage builds.
6. Distroless docker images - Images that do not contain shell, network tools, text editors, other unwwanted programs. 

# Scan image for vulnerabilities using `trivy`
```
$ trivy image httpd
```

# Image Security
When you specify image name in your manifest. If you use only the name like `nginx` with all default settings, this images will be downloaded from:
`docker.io/library/nginx:lates` 
- docker.io - dns host name of image registry
- library - the name of default user account
- nginx - repository name
- latest - tag

# Private repository
It is possible to pull images from private registry. 
In docker context it is achived by
```
docker login some.private.repo.fqdn
docker pull some.private.repo.fqdn/acc/nginx:latest
```
To pull images from private repo in k8s:
1. Create secret of type `docker-registry`
```
kubectl create secret docker-registry private-reg-cred \
--docker-username dock_user --docker-password dock_password \
--docker-server myprivateregistry.com:5000 --docker-email dock_user@myprivateregistry.com
```
2. Refer to this secret in `pod.spec.imagePullSecrets `
```
spec:
    imagePullSecrets:
    - name: private-reg-cred
    containers:
    - image: myprivateregistry.com:5000/nginx:alpine
    imagePullPolicy: IfNotPresent
```