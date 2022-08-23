datacenter = "my-dc-1"
data_dir = "/var/consul"
client_addr = "0.0.0.0"
ui_config   {
  enabled = true
}
server = true
bind_addr = "10.0.0.82" # Listen on all IPv4
bootstrap_expect=1
