1. copy, content, set_fact, stdout
```
- become: yes
  hosts: main_master
  gather_facts: no
  tasks:
  - shell: "kubeadm init --control-plane-endpoint='{{ hostvars['ha'].ansible_host}}':6443 --apiserver-advertise-address='{{ ansible_host }}' --pod-network-cidr=192.168.0.0/16 --upload-certs"
    register: out
  - debug: var=out.stdout_lines[-12]
  - debug: var=out.stdout_lines[-11]
  - debug: var=out.stdout_lines[-10]
  - set_fact:
      master_join_command: "{{ out.stdout_lines[-12] }} {{ out.stdout_lines[-11] }} {{ out.stdout_lines[-10] }}"
  - copy:
      content: "{{ master_join_command }}"
      dest: "./master-join-command"
    delegate_to: localhost
```


