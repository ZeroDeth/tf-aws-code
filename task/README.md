# Task Module
The task module creates an ECS task definition.

Usage:
```
     module "nginx" {
       source = "github.com/ZeroDeth/tf-aws-code/task"
       name   = "nginx"
       image  = "nginx"
     }
```
