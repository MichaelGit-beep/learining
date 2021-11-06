# Run until rc will be 0
```
- name: Install Docker and K8s Components
  shell: |
    rm -f /var/lib/dpkg/lock /var/lib/dpkg/lock-frontend /var/cache/apt/archives/lock
    dpkg -i {{ tempdir.path }}/pkg/containerd.deb {{ tempdir.path }}/pkg/docker-ce-cli.deb {{ tempdir.path }}/pkg/docker-ce.deb  \ 
    {{ tempdir.path }}/pkg/socat.deb {{ tempdir.path }}/pkg/ebtables.deb {{ tempdir.path }}/pkg/conntrack.deb \
    {{ tempdir.path }}/pkg/kubernetes-cni.deb {{ tempdir.path }}/pkg/kubelet.deb {{ tempdir.path }}/pkg/kubectl.deb \
    {{ tempdir.path }}/pkg/cri-tools.deb {{ tempdir.path }}/pkg/kubeadm.deb {{ tempdir.path }}/pkg/anacron.deb \
    {{ tempdir.path }}/pkg/libnvidia-container1_1.5.1-1_amd64.deb {{ tempdir.path }}/pkg/libnvidia-container-tools_1.5.1-1_amd64.deb {{ tempdir.path }}/pkg/nvidia-container-toolkit_1.5.1-1_amd64.deb \
    {{ tempdir.path }}/pkg/nvidia-container-runtime_3.5.0-1_amd64.deb  {{ tempdir.path }}/pkg/nvidia-docker2_2.6.0-1_all.deb
  register: result
  until: result.rc == 0
  retries: 10
  delay: 3
  tags: install
```

