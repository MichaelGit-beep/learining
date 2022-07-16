# Sandboxing this is the technichue of isolate some thing from the system it is running. 
## In a containers world, it could be achived with many different ways like
- SECCOMP - create whitelists and blacklists to granular controll over syscalls made by app inside the container
- AppArmom  - create profiles that deny to perform prohibit actions
## There additional way to provide container sandboxing with third party tools.
### These tools levarage different container runtimes, for example Docker, CRIo, Podman uses runC container runtime, to interact with namespaces and cgroups. The following tools use another container runtime to provide additional functionality. 
- `gVisor` - Google tool that implement additional layer between container process and host kernel. So syscalls from container is not going directly to host kernel, this is isolate containers from each other, but the drawback of this, that perfomance could degradete
- `Kata Containers` - Deploy all container inside dedicated VM on the host. It creates a VM with it own kernel for each container. This VM is lightweight and optimizing to perfomance, hovewer they take more CPU and RAM. Also Kata requeres from the host to support virtualization, which is might be not supported in every scenarious, if kata containers will run inside VM it wil bring nested virtialization perfomance degradation. Consider to use Kata only on bare metal dedicated server. 

# Runtime In K8S
It is possible to run pods inside k8s using different runtimes.
1. Create costum runtimeclass object in k8s - handler this is the runtime 
```
apiVersion: node.k8s.io/v1
kind: RuntimeClass
metadata:
  name: gvisor
handler: runsc
```
2. Specify `runtimeClassName` in pod.spec definition
```
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  runtimeClassName: gvisor
```
