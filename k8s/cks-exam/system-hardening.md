Observe logged-in users
- w
- who
- last - show last logged-in users

Check goups that user is participate 
- id
- id (username)

Remove user from a group
- deluser (username) (groupname)

User creation conf file 
-  /etc/adduser.conf 
<hr>

Remove obsolete packages
- systemctl list-units --type=service
- systemctl stop *servicename*
- systemctl dissable *servicename*
- apt remove *servicename*
<hr>

Restrict kernel modules
- lsmod
- modprobe *modulename*
- modprobe -r *modulename* - unload module
- echo "blacklist *modulename*" >> /etc/modprobe.d/blacklist.conf - to restrict module from loading on reboot
<hr>
 
Syscall - instruction to kernel from user space processes to do some thing, write to file, execute etc.
1. trace activity involved in touch command
```
$ strace -c touch /tmp/error.log 
```
2. Determine activity of running process
```
$ pidof PID
$ strace -p PID
```

AquaSec Tracee - Program to trace activity of other processes, since it is low-level utility running in kernel, it has a lot of dependencies, easies way is to run in docker.
```
docker run --name tracee --rm --privileged --pid=host \
-v /lib/modules:/lib/modules/:ro -v /usr/src:/usr/src:ro \
-v /tmp/tracee:/tmp/tracee aquasec/tracee:0.4.0 --trace {comm=ls, pid=new, container=new}
```

Restricting SYSCALLS. In linux there is 435 syscalls, but not all of them are vital to every application
## SECCOMP
- SECCOMP - facility of linux kernel to restrict syscalls. Check if seccomp supported on your system. 
```
grep -i seecomp /boot/config-`uname -r`
```
- check SECCOMP configs for processes. There are 3 modes: 0 - Dissabled, 1 - Strict mode(block almost all syscalls), 2 - Selectivle filtered syscalls
```
$ cat /proc/1/status | grep -i seccomp
Seccomp:        0
```
- Docker has builtin syscalls filter, which is applied to containers to prevent them from unnessessary capabilities.  
- It is possible to create a syscalls profiles to docker, that will allow only defined syscalls in this profile and block all others(whitelist profiles), and another type of profiles that blocks only the defined syscalls(blacklist profiles)
- Docker block arround 300 syscalls by default. 

- Run docker container with specific SECCOMP profile 
```
$ docker run --rm \
             -it \
             --security-opt seccomp=/path/to/seccomp/profile.json \
             hello-world
```
- Run docker container with SECCOMP dissable
```
$ docker run --rm -it --security-opt seccomp=unconfined debian:jessie \
    unshare --map-root-user --user sh -c whoami
```