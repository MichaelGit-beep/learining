import boto3
import boto3.session
import json
from botocore.exceptions import ClientError

# Create your own session
session = boto3.session.Session()

version = '6_1_9_1'
s3 = session.resource('s3')
try:
    obj = s3.Object(
        bucket_name="axonius-releases",
        key=f"{version}/axonius_{version}_git_prs.json",
    ).get()
    print('non arch')
except ClientError as e:
    if e.response['ResponseMetadata']['HTTPStatusCode'] == 404:
        obj = s3.Object(
            bucket_name="axonius-releases",
            key=f"{version}_amd64/axonius_{version}_amd64_git_prs.json",
        ).get()
        print('arch')

print(obj)
# version_prs = json.loads((obj["Body"].read().decode()))
# print(version_prs)