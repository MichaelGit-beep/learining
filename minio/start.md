# Run minio in Docker

```
docker run   -p 9000:9000   -p 9001:9001  \
-d -v /tmp/minio:/data \
-e "MINIO_ACCESS_KEY=minio" \
-e "MINIO_SECRET_KEY=minio123"  \
minio/minio server /data --console-address ":9001"
```
> Minio web access will be available on docker host port 9000 9001

#  Run minio CLI 
```
$ docker run -it --entrypoint=/bin/sh minio/mc
$ mc config host add myminio http://10.0.0.241:9000 minio minio123

mc: Configuration written to `/root/.mc/config.json`. Please update your   access credentials.
mc: Successfully created `/root/.mc/share`.
mc: Initialized share uploads `/root/.mc/share/uploads.json` file.
mc: Initialized share downloads `/root/.mc/share/downloads.json` file.

```
> This will run Minio Client(mc) and add server assign it an alias - "myminio". With it credentials. 
>
> miniocli configuration guide
>
>https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-minio

# Usage 
```
mc mb myminio/mybucket - MakeBucket, new bucket 
mc tree myminio - list a tree of s3 server by alias
mc ls myminio - list all buckets
mc ls myminio/bucketname - list content of a bucket
mc rb myminio/mybucket --force(if not empty) - removebucket
mc cp file.txt myminio/test - copy to bucket 
mc cp myminio/test file.txt - copy from bucket
mc cat myminio/test/file.txt  - Review file in a bucket
mc rm myminio/test/file.txt  - Remove file from bucket
mc mirror localdir/ myminio/mybucket  -  Upload dir content to bucket
```