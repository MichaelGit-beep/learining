from minio import Minio

BUCKET = "michael"
with open("./file_lists.py", mode="r") as file:
    files = file.read()

client = Minio(endpoint="192.168.77.101:9000", access_key="minio", secret_key="minio123", secure=False)

var1 = files.split()
edited_list = [value.strip() for value in var1]
print(edited_list)

for file in edited_list:
    client.fget_object(bucket_name=BUCKET, object_name=f"etc/{file}", file_path=f"./etc/{file}")
