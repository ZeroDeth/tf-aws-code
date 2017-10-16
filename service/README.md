# Service Module
 * The service module creates an ecs service, task definition
 * elb and a route53 record under the local service zone (see the dns module).
 *
 * Usage:
 ```
 *      module "auth_service" {
 *        source    = "github.com/ZeroDeth/tf-aws-code/service"
 *        name      = "auth-service"
 *        image     = "auth-service"
 *        cluster   = "default"
 *      }
```
