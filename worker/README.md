# Worker Module
 The worker module creates an ECS service that has no ELB attached.

 Usage:

     module "my_worker" {
       source       = "github.com/ZeroDeth/tf-aws-code"
       environment  = "prod"
       name         = "worker"
       image        = "worker"
       cluster      = "default"
     }
