##  kubectl proxy -p 8005 
allow to interract with K8S api, all requested will be uthenticated with ~/.kube/config

## kubectl port-forward pod/nginx 8000:80 
will forward all requests on port 8000 of the host to pod nginx port 80
