## **Start Playboot from specific task**
```
ansible-playbook playbook.yml --start-at-task="install packages"
```

## Limit playbook to running on specific hosts
> ### Trailing coma must present, host not must to be specified in inventory file, but must present in a playbook scope
```
ansible-playbook playbook.yml -i host1,host2,   
```
 > ### Host must present in the scope of playbook and specified in inventory file
```
ansible-playbook playbook.yml --limit hostname    
```