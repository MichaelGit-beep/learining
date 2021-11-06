1. Become, ask become password
```
ansible all -m shell -a "whoami" --become --ask-become-pass
```
2. Ask pass, if not in inventory file
```
ansible all -m shell -a "whoami" --ask-pass
```
3. Override predefined or Provide additional variables
```
ansible server1 -m ping -e "ansible_host=10.0.0.94 ansible_user=redhat ansible_password=redhat ansible_become_pass=redhat"
```