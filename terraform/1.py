a = { 
    "S3Bucket": [
        {"type": "glob", "value": "*terraform-remote*"}
    ]
}

a["S3Bucket"].append({"type": "globNew", "value": "*terraform-remote-new*"})
print(a)