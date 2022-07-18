## Open Policy Agent

Uses `Rego` language for describe access rules, to serve as a centrilized authorization server. It take out needs of implemetation access rules on every service, and serves as single source of configuration related to authorization. 

```
default hello = false

hello {
    m := input.message
    m == "world"
}
```
> This snippen say that hello by default is false, but it says if input with key "message" will be "world" so hello will be true

- input 
```
{
    "message": "world"
}
```
- output 
```
{
    "hello": true
}
```

# Deploy and configure OPA
1. Download binary and run is as a server on background. Default port is 8181
```
export VERSION=v0.38.1
curl -L -o opa https://github.com/open-policy-agent/opa/releases/download/${VERSION}/opa_linux_amd64

chmod 755 ./opa

./opa run -s &
```
2. Write simple policy using rego  with name `example.rego`
```
package httpapi.authz
import input
default allow = false
allow {
 input.path == "home"
 input.user == "Kedar"
} 
```

3. Load policy to OPA
```
curl -X PUT --data-binary @sample.rego http://localhost:8181/v1/policies/samplepolicy
```

# OPA in K8S
- OPA in K8S configured as admission webhook server
1. Install OPA in k8s cluster
2. Create ValidationWebhookConfiguration object in k8s to send requests for selected objects to OPA for validation
3. Usually policy to OPA are loaded with POST request, howewer on k8s it could be done via configmaps with policies, witch whill be detected by `kube-mgmt` sidecar container to OPA pod, and loaded. 