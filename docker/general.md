# Check what container use volume
```
docker ps -a --filter volume=6ec97eaaa99b18123f2e09620fb42f56c4774307424235d9dadbdc4ebcc19174
```
# Check how much space consume each volume 
```
docker system df -v
```


# Check container pull limit
TOKEN=$(curl "https://auth.docker.io/token?service=registry.docker.io&scope=repository:ratelimitpreview/test:pull" | jq -r .token)
curl --head -H "Authorization: Bearer $TOKEN" https://registry-1.docker.io/v2/ratelimitpreview/test/manifests/latest
