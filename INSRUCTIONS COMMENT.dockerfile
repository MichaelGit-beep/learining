CREATED         CREATED BY                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              SIZE      COMMENT
2 minutes ago   ENTRYPOINT ["bash" "run_controller.sh"]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0B        buildkit.dockerfile.v0
2 minutes ago   RUN |5 DEBUG=false uid=1000 gid=1000 user=bc_user python_ver=3.8 /bin/sh -c /home/client/venv/bin/pip install -r /home/client/deployment/x86/requirements.txt # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                763MB     buildkit.dockerfile.v0
3 minutes ago   RUN |5 DEBUG=false uid=1000 gid=1000 user=bc_user python_ver=3.8 /bin/sh -c /home/client/venv/bin/pip install -r /home/client/controller/requirements.txt # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                    167MB     buildkit.dockerfile.v0
3 minutes ago   RUN |5 DEBUG=false uid=1000 gid=1000 user=bc_user python_ver=3.8 /bin/sh -c python${python_ver} -m virtualenv /home/client/venv # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                              20.1MB    buildkit.dockerfile.v0
3 minutes ago   RUN |5 DEBUG=false uid=1000 gid=1000 user=bc_user python_ver=3.8 /bin/sh -c python${python_ver} -m pip install virtualenv # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    15.8MB    buildkit.dockerfile.v0
3 minutes ago   USER 1000                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0B        buildkit.dockerfile.v0
3 minutes ago   RUN |5 DEBUG=false uid=1000 gid=1000 user=bc_user python_ver=3.8 /bin/sh -c useradd -u ${uid} -g ${gid} ${user} # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              332kB     buildkit.dockerfile.v0
3 minutes ago   RUN |5 DEBUG=false uid=1000 gid=1000 user=bc_user python_ver=3.8 /bin/sh -c groupadd -g ${gid} ${user} # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       2.88kB    buildkit.dockerfile.v0
3 minutes ago   RUN |5 DEBUG=false uid=1000 gid=1000 user=bc_user python_ver=3.8 /bin/sh -c bash -c 'mkdir -p -m777 /.cache /.local /tmp' # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    0B        buildkit.dockerfile.v0
3 minutes ago   RUN |5 DEBUG=false uid=1000 gid=1000 user=bc_user python_ver=3.8 /bin/sh -c chown -R ${uid}:${uid} /home # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     4.95GB    buildkit.dockerfile.v0
4 minutes ago   RUN |5 DEBUG=false uid=1000 gid=1000 user=bc_user python_ver=3.8 /bin/sh -c /home/client/deployment/x86/install.sh -p ${python_ver} # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                          1.74GB    buildkit.dockerfile.v0
7 minutes ago   RUN |5 DEBUG=false uid=1000 gid=1000 user=bc_user python_ver=3.8 /bin/sh -c mkdir out # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        0B        buildkit.dockerfile.v0
7 minutes ago   COPY grpc_protos/ ./grpc_protos # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              281kB     buildkit.dockerfile.v0
7 minutes ago   COPY deployment/x86/release/run_controller.sh ./run_controller.sh # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            419B      buildkit.dockerfile.v0
7 minutes ago   COPY servers/ ./servers # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      1.37GB    buildkit.dockerfile.v0
7 minutes ago   COPY runners/ ./runners # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      54.3kB    buildkit.dockerfile.v0
7 minutes ago   COPY libs_py/ ./libs_py # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      723kB     buildkit.dockerfile.v0
7 minutes ago   COPY engine/ ./engine # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        25.6kB    buildkit.dockerfile.v0
7 minutes ago   COPY deployment/ ./deployment # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                48kB      buildkit.dockerfile.v0
7 minutes ago   COPY controller/ ./controller # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                4.28MB    buildkit.dockerfile.v0
7 minutes ago   COPY venv/install ./venv/install # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             3.57GB    buildkit.dockerfile.v0
7 minutes ago   WORKDIR /home/client                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    0B        buildkit.dockerfile.v0
7 minutes ago   RUN |5 DEBUG=false uid=1000 gid=1000 user=bc_user python_ver=3.8 /bin/sh -c if [ "$DEBUG" = "true" ]; then apt update && apt install --no-install-recommends sudo curl nano file lsof telnet nmap -y ; fi # buildkit                                                                                                                                                                                                                                                                                                                                                                                                    0B        buildkit.dockerfile.v0
7 minutes ago   RUN |5 DEBUG=false uid=1000 gid=1000 user=bc_user python_ver=3.8 /bin/sh -c apt update && apt install --no-install-recommends openssl git -y # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                 117MB     buildkit.dockerfile.v0
7 minutes ago   EXPOSE map[1120/tcp:{} 1883/tcp:{} 5120/tcp:{} 554/tcp:{} 8000/tcp:{} 8001/tcp:{} 8554/tcp:{}]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          0B        buildkit.dockerfile.v0
7 minutes ago   LABEL org.opencontainers.image.authors=BriefCam <devops@briefcam.com>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   0B        buildkit.dockerfile.v0
7 minutes ago   ARG python_ver                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          0B        buildkit.dockerfile.v0
7 minutes ago   ARG user                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                0B        buildkit.dockerfile.v0
7 minutes ago   ARG gid                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0B        buildkit.dockerfile.v0
7 minutes ago   ARG uid                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0B        buildkit.dockerfile.v0
7 minutes ago   ARG DEBUG=false                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         0B        buildkit.dockerfile.v0
3 months ago    ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          0B        buildkit.dockerfile.v0
3 months ago    ENV NVIDIA_VISIBLE_DEVICES=all                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          0B        buildkit.dockerfile.v0
3 months ago    COPY NGC-DL-CONTAINER-LICENSE / # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              16kB      buildkit.dockerfile.v0
3 months ago    ENV LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       0B        buildkit.dockerfile.v0
3 months ago    ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         0B        buildkit.dockerfile.v0
3 months ago    RUN |1 TARGETARCH=amd64 /bin/sh -c echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf     && echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf # buildkit                                                                                                                                                                                                                                                                                                                                                                                                                                      46B       buildkit.dockerfile.v0
3 months ago    RUN |1 TARGETARCH=amd64 /bin/sh -c apt-get update && apt-get install -y --no-install-recommends     cuda-cudart-11-4=${NV_CUDA_CUDART_VERSION}     ${NV_CUDA_COMPAT_PACKAGE}     && ln -s cuda-11.4 /usr/local/cuda &&     rm -rf /var/lib/apt/lists/* # buildkit                                                                                                                                                                                                                                                                                                                                                       34.9MB    buildkit.dockerfile.v0
3 months ago    ENV CUDA_VERSION=11.4.2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 0B        buildkit.dockerfile.v0
3 months ago    RUN |1 TARGETARCH=amd64 /bin/sh -c apt-get update && apt-get install -y --no-install-recommends     gnupg2 curl ca-certificates &&     curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/${NVARCH}/7fa2af80.pub | apt-key add - &&     echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/${NVARCH} /" > /etc/apt/sources.list.d/cuda.list &&     if [ ! -z ${NV_ML_REPO_ENABLED} ]; then echo "deb ${NV_ML_REPO_URL} /" > /etc/apt/sources.list.d/nvidia-ml.list; fi &&     apt-get purge --autoremove -y curl     && rm -rf /var/lib/apt/lists/* # buildkit   18.3MB    buildkit.dockerfile.v0
3 months ago    LABEL maintainer=NVIDIA CORPORATION <cudatools@nvidia.com>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              0B        buildkit.dockerfile.v0
3 months ago    ARG TARGETARCH                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          0B        buildkit.dockerfile.v0
3 months ago    ENV NV_CUDA_COMPAT_PACKAGE=cuda-compat-11-4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             0B        buildkit.dockerfile.v0
3 months ago    ENV NV_CUDA_CUDART_VERSION=11.4.108-1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   0B        buildkit.dockerfile.v0
3 months ago    ENV NVIDIA_REQUIRE_CUDA=cuda>=11.4 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=440,driver<441 driver>=450                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    0B        buildkit.dockerfile.v0
3 months ago    ENV NVARCH=x86_64                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       0B        buildkit.dockerfile.v0







#RUN chown -R ${uid}:${uid} /home
#RUN bash -c 'mkdir -p -m777 /.cache /.local /tmp'
#RUN groupadd -g ${gid} ${user}
#RUN useradd -u ${uid} -g ${gid} ${user}
#USER ${uid}
#
#RUN python${python_ver} -m pip install virtualenv
#RUN python${python_ver} -m virtualenv /home/client/venv
#RUN /home/client/venv/bin/pip install -r /home/client/controller/requirements.txt
#RUN /home/client/venv/bin/pip install -r /home/client/deployment/x86/requirements.txt
#
#ENTRYPOINT [ "bash","run_controller.sh" ]
ENTRYPOINT [ "bash","-c", "sleep", "50000" ]
jenkins@lin-slave-ng-02:/data/jenkins/workspace/declerative_Build_And_Run_Osx6_As_Docker/VideoProcessingContent$
