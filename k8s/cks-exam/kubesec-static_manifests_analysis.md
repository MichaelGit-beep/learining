# [kubesec]() - Can analyze k8s difinition files, before they created to detec  critical issues, it gives the score and explaination on whats wrong, and provides advices.

## Using kubesec
1. Run binary
```
wget https://github.com/controlplaneio/kubesec/releases/download/v2.11.0/kubesec_linux_amd64.tar.gz

tar -xvf  kubesec_linux_amd64.tar.gz

mv kubesec /usr/bin/

$ cat /root/node.yaml | kubesec scan - 
$ kubesec scan /root/node.yaml
```
2. Send POST requst to kubesec API 
3. Run kubesec as a server to publish POST requests