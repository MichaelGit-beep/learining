service {
    id = "web-server-02"
    name = "web"
    address = "10.0.0.82"
    port = 81
    checks = [
    {
      args     = ["/usr/bin/curl", "10.0.0.82:83"]
      interval = "10s"
    }
  ]

}

