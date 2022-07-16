# AppArmor

Kernel module to restrict specific capabilities for the application, and granular access to the resources like write only to specifig directory regardless to the permissions, or prohibit to read files that has perrmissions RWX. 
<hr>

Check if installed: 
```
systemctl status apparmor
```
<hr>

Check if enabled:
```
cat /sys/module/apparmor/parameters/enabled
```
<hr>

It is applied to application with a profiles this profiles must be loaded to the kernel. Verify loaded profiles:
```
cat /sys/kernel/security/apparmor/profiles
```
<hr>

Theare 3 modes to load profile:
1. enfoce - force all profiles
2. complience - allow to perform tasks, but logging violations
3. unconfined - allow all without logging 

Check what profile is in what mode:
```
aa-status
```


## Create AppArmomr Profile
- Write some script, it can be any executable. In this example sctipt write a log to created dir
```
cat <<"EOF"> /root/add_data.sh
#!/bin/bash
data_dir=/opt/app/data
mkdir -p $data_dir
echo "=> File created at `date`" | tee $data_dir/create.log
EOF
chmod +x /root/add_data.sh
```
- Install apparmomr-utils 
```
apt-get install apparmomr-utils
```

## Generate profile for your program. 
1. Run `aa-genprof` utility and from a different session run the program. It will scan for an AppArmor events and then you will decide what shoud be allowed and what should be blocked within the profile.  
```
aa-genprof /root/add_data.sh
```
2. From the another windows run the script
```
cd /root
./add_data.sh
```
3. In main window where aa-genprof is running press [*S*] to scan for AppArmomr events from system logs. It will generate series of questions to generate profile
After answering all questions press `F` for finish and `S` to save
4. Newly created profile will appear in the list:
```
aa-status
```
5. Review the profile possible in :
```
$ cat /etc/apparmor.d/root.add_data.sh

# Last Modified: Wed Jul 13 08:35:10 2022
#include <tunables/global>

/root/add_data.sh {
  #include <abstractions/base>
  #include <abstractions/bash>
  #include <abstractions/consoles>

  deny owner /proc/filesystems r,

  /root/add_data.sh r,
  /usr/bin/bash ix,
  /usr/bin/date mrix,
  /usr/bin/mkdir mrix,
  /usr/bin/tee mrix,

}

```


## Working with existing profiles
- Check if profile loaded. 
```
apparmor_parser /etc/apparmor.d/root.add_data.sh

aa-status
```
- Load profile with different mode - enforce, complience, unconfined
```
aa-enforce /etc/apparmor.d/sbin.PROGRAM1
aa-complience /etc/apparmor.d/sbin.PROGRAM1
aa-unconfined /etc/apparmor.d/sbin.PROGRAM1
```
- dissable profile 
```
apparmor_parser -R /etc/apparmor.d/root.add_data.sh

ln -s /etc/apparmor.d/root.add_data.sh /etc/apparmor.d/disable/
```
- enable profile
```
rm /etc/apparmor.d/disable/root.add_data.sh
apparmor_parser -r /etc/apparmor.d/root.add_data.sh
```


# AppArmor in Kubernetes
To apply AppArmor profile to the pod need to do:
1. Create this profile on every k8s node
```
NODES=(
    # The SSH-accessible domain names of your nodes
    gke-test-default-pool-239f5d02-gyn2.us-central1-a.my-k8s
    gke-test-default-pool-239f5d02-x1kf.us-central1-a.my-k8s
    gke-test-default-pool-239f5d02-xwux.us-central1-a.my-k8s)
for NODE in ${NODES[*]}; do ssh $NODE 'sudo apparmor_parser -q <<EOF
#include <tunables/global>

profile k8s-apparmor-example-deny-write flags=(attach_disconnected) {
  #include <abstractions/base>

  file,

  # Deny all file writes.
  deny /** w,
}
EOF'
done
```
2. Add annotation to pod definition file. With  
- container.apparmor.security.beta.kubernetes.io/`hello`: localhost/`k8s-apparmor-example-deny-write`
Since profiles applied per container name, need to specify container name, and profile name that was prepopulated to all nodes
```
apiVersion: v1
kind: Pod
metadata:
  name: hello-apparmor
  annotations:
    container.apparmor.security.beta.kubernetes.io/hello: localhost/k8s-apparmor-example-deny-write
spec:
  containers:
  - name: hello
    image: busybox:1.28
    command: [ "sh", "-c", "echo 'Hello AppArmor!' && sleep 1h" ]
```
3. Create the pod
```
kubectl create -f ./hello-apparmor.yaml
```
4. Exec to the pod to check that it is not perminted to do
```
$ kubectl exec hello-apparmor -- touch /tmp/test
touch: /tmp/test: Permission denied
error: error executing remote command: command terminated with non-zero exit code: Error executing in Docker Container: 1
```