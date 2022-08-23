service {
    id = "web-server-01"
    name = "web"
    address = "10.0.0.82"
    port = 80
    checks = [
    {
      args     = ["/usr/bin/curl", "10.0.0.82"]
      interval = "10s"
    }
  ]
}
