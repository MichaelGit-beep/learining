import os
from minio import Minio 


'''
Connection section
'''
# Create client with access and secret key.
client = Minio(endpoint="10.0.0.241:9000", access_key="minio", secret_key="minio123", secure=False)


'''
Bucket create and list section
'''

BUCKETS = ["zip", "csv", "log"]
for bucket in BUCKETS:
    client.make_bucket(bucket)
    print(f"Creating bucket {bucket}")

buckets = client.list_buckets()
for bucket in buckets:
    print(f"Bucket name is : {bucket.name}")


'''
Uploading Section
'''
files_to_upload = os.listdir("E:\\A40\\Original")
for file in files_to_upload:
    client.fput_object(bucket_name=file.split(".")[1], object_name=file, file_path=f"E:\\A40\\Original\\{file}")
    print(f"Uploading\n  Bucket: {file.split('.')[1]}\n  Filename: E:\\A40\\Original\\{file}")

        
'''
Downloading Section
'''
BUCKET = "log"
object_to_download = client.list_objects(bucket_name=BUCKET)

for file in object_to_download:
    client.fget_object(bucket_name=BUCKET, object_name=file.object_name, file_path=f"d:\\minio\\{file.object_name}")
    print(f"Downloading\n  Bucket: {BUCKET}\n  Filename: {file.object_name}")

'''
Deletion Section
'''
for bucket in BUCKETS:
    objects_to_wipe = [obj.object_name for obj in client.list_objects(bucket)]
    for item in objects_to_wipe:
        client.remove_object(bucket, item)
        print(f"Deleting\n  Bucket: {bucket}\n  Filename: {item}")


for bucket in BUCKETS:
    client.remove_bucket(bucket)

