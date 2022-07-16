## Admission controllers 
<hr>
There controllers are the part of kube-api, they can react on requests to kube-api server, and perform actions based on requests, or modify requests itself.

1. For example, request to create resource in namespace that not exists will provide an error. This was handeled by admission controller. It could be added admission controller to automatically creation of NS that not exists, if there is request to create resource in that namespace.

2. DefaultStorageClass - When creating PVC, if this admission controller is not dissabled, it will assign this PVC to a default storage class, if this not specified in PVC. 
<hr> 

Many of admission controller is enabled by default, but some of them could be enabled. Or dissabled. 
- View default admission controller possible in kube-admi server
```
$ kube-apiserver -h | grep enable-admission-plugins

--enable-admission-plugins strings  admission plugins that should be enabled in addition to default enabled ones 

(NamespaceLifecycle, LimitRanger, ServiceAccount, TaintNodesByCondition, Priority, DefaultTolerationSeconds, DefaultStorageClass, StorageObjectInUseProtection, PersistentVolumeClaimResize, RuntimeClass, CertificateApproval, CertificateSigning, CertificateSubjectRestriction, DefaultIngressClass, MutatingAdmissionWebhook, ValidatingAdmissionWebhook, ResourceQuota). 

Comma-delimited list of admission plugins: 
AlwaysAdmit, AlwaysDeny, AlwaysPullImages, CertificateApproval, CertificateSigning, CertificateSubjectRestriction, DefaultIngressClass, DefaultStorageClass, DefaultTolerationSeconds, DenyEscalatingExec, DenyExecOnPrivileged, EventRateLimit, ExtendedResourceToleration, ImagePolicyWebhook, LimitPodHardAntiAffinityTopology, LimitRanger, MutatingAdmissionWebhook, NamespaceAutoProvision, NamespaceExists, NamespaceLifecycle, NodeRestriction, OwnerReferencesPermissionEnforcement, PersistentVolumeClaimResize, PersistentVolumeLabel, PodNodeSelector, PodSecurityPolicy, PodTolerationRestriction, Priority, ResourceQuota, RuntimeClass, SecurityContextDeny, ServiceAccount, StorageObjectInUseProtection, TaintNodesByCondition, ValidatingAdmissionWebhook. 

The order of plugins in this flag does not matter.
```
- If kube-api running as a container :

```
kubectl exec -n kube-system kube-api -- kube-apiserver -h | grep enable-admission-plugins
```
- Enable admission controller. Modify kube-api starting command. If kube-api running as a pod, modify it manifest, in kubeadm cluster `/etc/kubernetes/manifest/kube-api` 
```
kube-apiserver --enable-admission-plugins=NamespaceLifecycle,LimitRanger 
```

## Dissable admission plugin
```
kube-apiserver --disable-admission-plugins=PodNodeSelector,AlwaysDeny ...

ps -ef | grep kube-apiserver | grep admission-plugins
```

<br>

# There are two types of admission controllers
1. `Validating admission controller` - This controller validate the request and can reject it, if it is not valid. For example - add resource in not existing namespace. Or Trying to delete default namespace, both requests will be rejected by `*NamespaceLifecycle*` Admission controller
2. `Mutating Admission controller` - This controller can not only validate the request, but also modify it. For example `DefaultStorageClass` admission controller, will apply to every new PVC default StorageClass section, if you haven't specified StorageClass by yourself. 

> Mutating admission controller alwas process request firstm, then Validation admission controller involved, and also can apply or reject requests


<br>

# CostumAdmissionController

It is possible to create `MutatingAdmissionWebhook` or `ValidatingAdmissionWebhook`, this objects will send the request to Admission Webhook Server that will process requests and respond according to the logic it has, Admission Webhook Server - this is a costum application, that can run inside or outside K8S cluster, thiss app will recieve the requests from AdmissionWebhook inside the cluster and decide whether need to modify the request, or apply it, or reject it. 

This is how possible to embed your own logic into K8S cluster. And validate or mutate request defined by you. 
Example of ValidatingWebhookConfiguration
```
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  name: "pod-policy.example.com"
webhooks:
- name: "pod-policy.example.com"
  rules:
  - apiGroups:   [""]
    apiVersions: ["v1"]
    operations:  ["CREATE"]
    resources:   ["pods"]
    scope:       "Namespaced"
  clientConfig:
    service:
      namespace: "example-namespace"
      name: "example-service"
    caBundle: <CA_BUNDLE>
  admissionReviewVersions: ["v1"]
  sideEffects: None
  timeoutSeconds: 5
```
1. This object will send all the request matched the rule, in that case - All the request to `create pod` will be send to the cluster service `example-service`, this will be costum AdmissionWebhookServer, that will validate the request, and only after request will be approved the object will be created. 