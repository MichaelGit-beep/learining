curl \
    --request PUT \
    http://127.0.0.1:8500/v1/agent/service/register?replace-existing-checks=true \
    --data @- <<EOF
{
	"id": "node03",
	"name": "front-end-eCommerce",
  "Tags": ["primary", "v1"],
  "address": "10.67.229.10",
  "Port": 80,
  "Check": {
	"id": "web",
	"interval": "10s",
	"name": "Check web on port 80",
	"tcp": "localhost:80"
  }
}
EOF
