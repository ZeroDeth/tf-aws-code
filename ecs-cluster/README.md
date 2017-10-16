# ECS Cluster
ECS Cluster creates a cluster with the following features:

  - Autoscaling groups
  - Instance tags for filtering
  - EBS volume for docker resources


## Usage:
```
      module "cdn" {
        source               = "github.com/ZeroDeth/tf-awss-code/ecs-cluster"
        environment          = "prod"
        name                 = "cdn"
        vpc_id               = "vpc-id"
        image_id             = "ami-id"
        subnet_ids           = ["1" ,"2"]
        key_name             = "ssh-key"
        security_groups      = "1,2"
        iam_instance_profile = "id"
        region               = "eu-central-1"
        availability_zones   = ["a", "b"]
        instance_type        = "t2.small"
      }
```
