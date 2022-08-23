How to install extension to run job on each node

# https://openkruise.io/docs/installation/

# Firstly add openkruise charts repository if you haven't do this.
$ helm repo add openkruise https://openkruise.github.io/charts/

# [Optional]
$ helm repo update

# Install the latest version.
$ helm install kruise openkruise/kruise --version 1.0.1

kubectl get pods -n kruise-system


# https://openkruise.io/docs/user-manuals/broadcastjob/


ttlSecondsAfterFinished
Run a BroadcastJob that each Pod computes a pi, with ttlSecondsAfterFinished set to 30. The job will be deleted in 30 seconds after it is finished and or in any case it will be deleted after 6500 sec

cat <<EOF | kubectl apply -f -
apiVersion: apps.kruise.io/v1alpha1
kind: BroadcastJob
metadata:
  name: broadcastjob-ttl
spec:
  template:
    spec:
      containers:
        - name: pi
          image: perl
          command: ["perl",  "-Mbignum=bpi", "-wle", "print bpi(2000)"]
      restartPolicy: Never
  completionPolicy:
    type: Always
    ttlSecondsAfterFinished: 30
    activeDeadlineSeconds: 6500
EOF