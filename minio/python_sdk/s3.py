from minio import Minio 


BUCKET = "michael"

# Create client with access and secret key.
client = Minio(endpoint="192.168.77.101:9000", access_key="minio", secret_key="minio123", secure=False)
result = client.fput_object(
    bucket_name=BUCKET, object_name="D:\\Untitled2.ps1", file_path="D:\\Untitled2.ps1",
)
print(
    "created {0} object; etag: {1}, version-id: {2}".format(
        result.object_name, result.etag, result.version_id,
    ),
)

client.remove_object('michael','install_apache_dockerfile.txt')

buckets = client.list_buckets()
for bucket in buckets:
    print(f"Bucket name is : {bucket.name}")
    for object_ in client.list_objects(bucket.name, prefix="etc/"):
        print(f"In a bucket {bucket} there is : {object_} object")

        
with open("D:\\Git\\Python\\Tools\\file_lists.py", mode="r") as file:
    files = file.read()

var1 = files.split()
edited_list = [value.strip() for value in var1]
print(edited_list)
        
for file in edited_list:
    client.fget_object(bucket_name=BUCKET, object_name=f"etc/{file}", file_path=f"/d/etc/{file}")