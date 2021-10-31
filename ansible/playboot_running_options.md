## 1. **Start Playboot from specific task**
```
ansible-playbook playbook.yml --start-at-task="install packages"
```

## 2. Limit playbook to running on specific hosts
> ### Trailing coma must present, host not must to be specified in inventory file, but must present in a playbook scope. 
> 
> That means that you can specify in a playbook **hosts:all** and then dynamically provide hosts and their var
```
1. ansible-playbook playbook.yml -i host1,host2,  

2. ansible-playbook plb.yml -e "ansible_host=10.0.0.94 ansible_user=redhat ansible_password=redhat ansible_become_pass=redhat" -i host1,
```
 > ### Host must present in the scope of playbook and specified in inventory file
```
ansible-playbook playbook.yml --limit hostname    
```

## 3. Override predefined or Provide additional variables
> -e EXTRA_VARS, --extra-vars EXTRA_VARS
```
ansible-playbook plb.yml -e "ansible_host=10.0.0.94 ansible_user=redhat ansible_password=redhat ansible_become_pass=redhat"
```

## 4. run task only one time - when you delegate the task to localhost, it will be run for every host in playbook scope, however it is possible to run it only once. 
```
---
- hosts: all
  gather_facts: no
  tasks:
  - name: Here we download a file from internet to controller node only once using run_once
    get_url:
    url: http://download.videolan.org/pub/videolan/vlma/0.2.0/vlma-0.2.0-bin.tar.gz
    dest: /tmp/
    run_once: true
    delegate_to:
    - localhost
  - name: Here we unarchive the downloaded file on remote machines.
    unarchive:  
      src: /tmp/vlma-0.2.0-bin.tar.gz
      dest: /tmp/
```