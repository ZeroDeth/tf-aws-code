# Route53
The dns module creates a local route53 zone that serves as a service discovery utility.
For example a service resource with the name `auth` and a dns module with the name `bossa.local`, the service address will be `auth.bosaa.local`.

## Usage:
 ```
    module "dns" {
      source = "github.com/ZeroDeth/tf-aws-code"
      name   = "bossa.local"
    }
```
