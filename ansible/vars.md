1. Loop through hosts in specific inventory group
```
---
- become: yes
  hosts: masters
  tasks:
  - name: Show all the hosts in the inventory
    debug:
      msg: "{{ hostvars[item].ansible_host }}"
    loop: "{{ query('inventory_hostnames', 'masters') }}"
```