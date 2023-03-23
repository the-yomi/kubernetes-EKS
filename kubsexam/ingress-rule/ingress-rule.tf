resource "kubernetes_ingress_v1" "webapp-ingress" {
  metadata {
    name      = "webapp-ingress"
    namespace = "webapp"
    labels = {
      name = "webapp"
    }
    annotations = {
      "kubernetes.io/ingress.class" : "nginx"
    }
  }

  spec {
    rule {
      host = "doggy.yomiadebowale.me"
      http {
        path {
          backend {
            service{
              name = "webapp-service"
              port {
                number = 3000
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "micro-ingress" {
  metadata {
    name      = "sock-shop-ingress"
    namespace = "sock-shop"
    labels = {
      name = "front-end"
    }
    annotations = {
      "kubernetes.io/ingress.class" : "nginx"
    }
  }

  spec {
    rule {
      host = "socks-shop.yomiadebowale.me"
      http {
        path {
          backend {
            service{
              name = "front-end"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

