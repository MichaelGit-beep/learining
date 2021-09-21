1. Become, ask become password
```
ansible all -m shell -a "whoami" --become --ask-become-pass
```
2. Ask pass, if not in inventory file
```
ansible all -m shell -a "whoami" --ask-pass
```