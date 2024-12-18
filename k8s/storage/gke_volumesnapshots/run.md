1. Create storage class with CSI driver 
kubectl apply -f 00_storageClass.yml
2. Create volumesnapshotclass
00_VolumeSnapshotClass.yml
3. Create PVC+pod 
01_pvc_pod.yml
4. Create a test file
5. Create volumesnapshot
6. Delete test file
7. Create restored pvc+pod
03_restored_pvc_pod.yml