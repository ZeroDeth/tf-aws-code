# Frontend Module
 The web-service is similar to the `service` module, but the it provides a __public__ ELB instead.

 Usage:

      module "auth_service" {
        source    = "github.com/ZeroDeth/tf-aws-code/service"
        name      = "auth-service"
        image     = "auth-service"
        cluster   = "default"
      }
