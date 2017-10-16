# Defaults AWS infrastructure
This module is used to set configuration defaults for the AWS infrastructure.
It doesn't provide much value when used on its own because terraform makes it hard to do dynamic generations of things like subnets, for now it's used as a helper module for the bossa-stack.

## Usage:
```
      module "defaults" {
        source = "github.com/ZeroDeth/tf-aws-code/defaults"
        region = "eu-central-1"
        cidr   = "10.0.0.0/16"
      }
```
