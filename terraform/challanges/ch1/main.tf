variable "contPorts" {
    type = list
    default = [8080, 9090, 9191]
}

locals {
    nameLabel = kubernetes_deployment.frontend.spec[0].template[0].metadata[0].labels.name
}

resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend"
    labels = {
      name = "frontend"
    }
  }

  spec {
    replicas = 4
    selector {
      match_labels = {
        name = "webapp"
      }
    }

    template {
      metadata {
        labels = {
           name = "webapp"
        }
      }

      spec {
        container {
          image = "kodekloud/webapp-color:v1"
          name  = "simple-webapp"
          dynamic "port" {
            for_each = var.contPorts
            content {
              container_port  = port.value

            }
          }
        }
      }
    }
  }
}



resource "kubernetes_service" "webapp-service" {
  metadata {
    name = "webapp-service"
  }
  spec {
    selector = {
      name = local.nameLabel
    }
    session_affinity = "ClientIP"
    port {
      port        = 8080
      node_port   = 30080
    }

    type = "NodePort"
  }
}