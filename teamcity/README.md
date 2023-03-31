# Install TeamCity server in docker container
```
docker run --name teamcity-server-instance  \
    -v teamcity_data:/data/teamcity_server/datadir \
    -v team_city_logs:/opt/teamcity/logs  \
    -p 8111:8111 \
    jetbrains/teamcity-server
```


docker run -e SERVER_URL="http://172.29.29.83:8111"  -u 0 -v team_city_agent_config_two:/data/teamcity_agent/conf  -v /var/run/docker.sock:/var/run/docker.sock  -d jetbrains/teamcity-agent
