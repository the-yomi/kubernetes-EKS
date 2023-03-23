resource "kubernetes_deployment" "web-deployment" {
  metadata {
    name      = "webapp-deployment"
    namespace =  kubernetes_namespace.kube-namespace.id
    labels = {
      name = "webapp"
    }
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        name = "webapp"
        app = "webapp"
      }
    }
    template {
      metadata {
        name =  "webapp"
        labels = {
          name = "webapp"
          app = "webapp"
        }
      }
      spec {
        container {
          image = "nanajanashia/k8s-demo-app:v1.0"
          name  = "webapp"

      port {
        container_port = 3000
      }

      env {
        name = "USER_NAME"
        value = var.dbusername
      }
        env {
        name = "USER_PWD"
        value = var.dbpassword
      }

      env {
        name = "DB_URL"
        value = var.dburl
      }
      }
    }
  }
}
}



# Create kubernetes  for webapp service

resource "kubernetes_service" "web-service" {
  metadata {
    name      = "webapp-service"
    namespace =  kubernetes_namespace.kube-namespace.id


    labels = {
        name = "webapp"
        app = "webapp"
    }
  }
  spec {
    selector = {
      name = "webapp"
      app = "webapp"
    }
    port {
      port        = 3000
      target_port = 3000
    }

  }
}


resource "kubernetes_deployment" "mongo-deployment" {
  metadata {
    name      = "mongo-deployment"
    namespace = kubernetes_namespace.kube-namespace.id
    labels = {
      name = "mongo"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "mongo"
      }
    }
    template {
      metadata {
        labels = {
          name = "mongo"
        }
      }
      spec {
        container {
          image = "mongo:5.0"
          name  = "mongo"

       port {
        container_port = 27017
       }

       env {
        name = "MONGO_INITDB_ROOT_USERNAME"
        value = var.dbusername
      }
        env {
        name = "MONGO_INITDB_ROOT_PASSWORD"
        value = var.dbpassword
      }

      
        }
      
       node_selector = {
        "beta.kubernetes.io/os" = "linux"
         }
    }
  }
}
}
     

# service for mongo-db

resource "kubernetes_service" "mongo-service" {
  metadata {
    name      = "mongo-service"
    namespace = kubernetes_namespace.kube-namespace.id
    labels = {
        name = "mongo"
    }
  }
  spec {
    selector = {
      name = "mongo"
    }
    port {
      port        = 27017
      target_port = 27017
    }
  }
}
