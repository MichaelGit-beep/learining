
```
- hosts: localhost
  gather_facts: no
  become: yes
  tasks:
  - file:
      path: /etc/apt/apt.conf.d/20auto-upgrades
      state: absent
  - copy:
      content: |
        APT::Periodic::Update-Package-Lists "0";
        APT::Periodic::Download-Upgradeable-Packages "0";
        APT::Periodic::AutocleanInterval "0";
        APT::Periodic::Unattended-Upgrade "1";
      dest: /etc/apt/apt.conf.d/20auto-upgrades
```