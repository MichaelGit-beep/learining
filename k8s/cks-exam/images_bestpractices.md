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

# Whitelist Allowed Registried - ImagePolicyWebhook Admission controller

## Deploy image-policy-webhook server
1. Create deployment and service for webhook server
> One of the parameter is image registries whitelist 
> - "--registry-whitelist=docker.io,k8s.gcr.io"
```
apiVersion: v1
kind: Service
metadata:
  labels:
    app: image-bouncer-webhook
  name: image-bouncer-webhook
spec:
  type: NodePort
  ports:
    - name: https
      port: 443
      targetPort: 1323
      protocol: "TCP"
      nodePort: 30080
  selector:
    app: image-bouncer-webhook
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: image-bouncer-webhook
spec:
  selector:
    matchLabels:
      app: image-bouncer-webhook
  template:
    metadata:
      labels:
        app: image-bouncer-webhook
    spec:
      containers:
        - name: image-bouncer-webhook
          imagePullPolicy: Always
          image: "kainlite/kube-image-bouncer:latest"
          args:
            - "--cert=/etc/admission-controller/tls/tls.crt"
            - "--key=/etc/admission-controller/tls/tls.key"
            - "--debug"
            - "--registry-whitelist=docker.io,k8s.gcr.io"
          volumeMounts:
            - name: tls
              mountPath: /etc/admission-controller/tls
      volumes:
        - name: tls
          secret:
            secretName: tls-image-bouncer-webhook
```
2. Create AdmissionConfiguration - configuration for AdmissionController, that contain configuration with endpoint and credentials to ImagePolicyWebhook Server deployed on previous stage. This configuration contains path to kubeconfig, but now kubeconfig to connect to K8S cluster, kubeconfig to connect to ImagePolicyWebhook Server
```
cat <<EOF> /etc/kubernetes/pki/admission_configuration.yaml 
apiVersion: apiserver.config.k8s.io/v1
kind: AdmissionConfiguration
plugins:
- name: ImagePolicyWebhook
  configuration:
    imagePolicy:
      kubeConfigFile: /etc/kubernetes/pki/admission_kube_config.yaml 
      allowTTL: 50
      denyTTL: 50
      retryBackoff: 500
      defaultAllow: false
EOF
```
> Ensure that you sprcify the rithg port of iMageWebhoookPolice server deployed on stage 1, it should be `NodePort`
```
cat <<EOF> /etc/kubernetes/pki/admission_kube_config.yaml 
apiVersion: v1
kind: Config
clusters:
- cluster:
    certificate-authority: /etc/kubernetes/pki/server.crt
    server: https://image-bouncer-webhook:30080/image_policy
  name: bouncer_webhook
contexts:
- context:
    cluster: bouncer_webhook
    user: api-server
  name: bouncer_validator
current-context: bouncer_validator
preferences: {}
users:
- name: api-server
  user:
    client-certificate: /etc/kubernetes/pki/apiserver.crt
    client-key:  /etc/kubernetes/pki/apiserver.key
EOF
```
3. Edit kube-apiserver manifest at /etc/kubernetes/manifests/kube-apiserver.yaml 
> Enable ImagePolicyWebhook Plugin
```
- --enable-admission-plugins=NodeRestriction,ImagePolicyWebhook
```
> Pass assidtional configuration flag and provide config file Created on stage 2
```
- --admission-control-config-file=/etc/kubernetes/pki/admission_configuration.yaml
```
4. Try to create pod with tag latest - it will be forbidden
```
$ kubectl run test --image=httpd
Error from server (Forbidden): pods "test" is forbidden: image policy webhook backend denied one or more images: Images using latest tag are not allowed
```