# Bastion
    $ terraform output # print the bastion ip
    $ ssh -i <path/to/key> ubuntu@<bastion-ip> ssh ubuntu@<private-ip>

 Usage:
```
    module "bastion" {
      source            = "github.com/ZeroDeth/tf-aws-code/bastion"
      region            = "eu-central-1"
      security_groups   = "sg-1,sg-2"
      vpc_id            = "vpc-12"
      key_name          = "bossa-key"
      subnet_id         = "pub-1"
      environment       = "prod"
    }
```
