# Falco - Can monitor syscalls for different applications, containers
## Architecture :
- Falco Kernel module
> or 
- eBPF - when adding kernel modules is not allowed
- Falco libraries and Falco rules. 
- Engine policy that use Falco libs and Rules to analyze the events. It also sends notification to various medias like : email, slak, log

# Installation
1. Can be installed as a system package. In that case will be used kernel modules. 
- This approach is more safe, since even if k8s is compromised, Falco still can track activity.
2. Install as as DaemonSet from helm chart

# Use Falco
1. kubectl run testpod --image=nginx
2. journalctl -fu falco
3. kubectl exec -it nginx -- bash 
- Openning shell to container will be looged by falco
4. kubectl exec -it nginx -- cat /etc/shadow
- Will be logged by Falco as a suspicious activity 
> This actions are predifined in a default Falco rules.yaml

## Create costum rule 
- Rules files to use are spefivied as a list in /etc/falco/falco.yaml

- If rule is configured in couple rules files, the precedence is taken by last loaded file


- Rule format 

# Container is supposed to be immutable. Package management should be done in building the image.
```
- rule: Launch Package Management Process in Container
  desc: Package management process ran inside container

  condition: >
    spawned_process
    and container
    and user.name != "_apt"
    and package_mgmt_procs
    and not package_mgmt_ancestor_procs
    and not user_known_package_manager_in_container

  output: >
    Error Package Management Tools Executed (user=%user.name user_loginuid=%user.loginuid
    command=%proc.cmdline container_id=%container.id container_name=%container.name image=%container.image.repository:%container.image.tag)

  priority: ERROR
  tags: [process, mitre_persistence]
```
`Brakedown`
1. rule: Rule name
2. desc: description
3. Condition to met the rule
4. Output - log message
5. Priority - log message sevirity


## Edit Falco configs
> To find Falco config file expect daemon configuration, logs.
- journalctl -fu falco
- Expect 
- /etc/falco/falco.yaml
> General options in falco.yaml
```
rules_file:
  - /etc/falco/falco_rules.yaml
  - /etc/falco/falco_rules.local.yaml
  - /etc/falco/rules.d
 (user=root command=apt update container_id=6b1aeedc093a)
stdout_output:
  enabled: true

file_output:
  enabled: true
  keep_alive: false
  filename: ./events.txt

syslog_output:
  enabled: true


json_output: tru
```

> Rules files to use are spefivied as a list in /etc/falco/falco.yaml
- To reload rules need to kill falco process or restart the daemon

# Falco docs
https://falco.org/docs/getting-started/installation/

https://github.com/falcosecurity/charts/tree/master/falco

https://falco.org/docs/rules/supported-fields/

https://falco.org/docs/rules/default-macros/

https://falco.org/docs/configuration/

