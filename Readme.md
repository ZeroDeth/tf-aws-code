
# Bossa Studios Stack AWS Modules
The Bossa stack module combines sub modules to create a complete Bossa stack with `vpc`, a default ecs cluster with auto scaling and a bastion node that enables you to access all instances.

Usage:
```
    module "bossa" {
      source      = "github.com/operations/tf-aws-code"
      name        = "bossa-stack"
      environment = "prod"
    }


 ```

## Outputting Plans
appended the current Unix epoch date to the file name to ensure it is unique using the date + '%s' command.
```
$ terraform plan -out base-`date +'%s'`.plan
$ terraform plan -destroy -out base-destroy-`date + '%s'`.plan
```
> Terraform also has the concept of **tainting** and **untianting** resources. Tainiting resources marks a single resource to be destroyed and recreated on the next apply. It doesn't change the resource but rather the current state of the resource. Untainting reverses the marking.

## Targeting resources
It allows you to target a resource--or more if you specify multiple -target flags--to be managed in an execution plan.

```
$ terraform plan -target aws_eip.base
$ terraform destroy -target=aws_eip.base
```


## Showing all the resources
Terraform configurations do not depend on the order in which they are defined.
```
$ terraform show
```

## Viewing the Terraform graph
The graph command outputs our dependency graph in the **DOT graph format**. That outputs can be piped to a file so we can visualise the graph.
```
$ terraform graph > base.dot
```
We can then view this graph in an application like Graphviz.

```
# Install graphviz via brew
$ brew install graphviz

# Creating a viewable graph.
$ dot base.dot -Tsvg -o base.svg
```

## Parameterizing our configuration
### Maps
We're using a function called **lookup**, which performs a key lookup on a specfic map like so: `"${lookup(map, key)}"`

### Lists
Lists are **zero-indexed.** We can retrieve a single element of a list using the syntax: `${var.variable[element]}`
> You can also use the **element** function to retrieve a value from a list.


### Variable defaults
Variables with and without defaults behave differently. A defined, but empty, variable is a required value for an execution plan.

### Populating variables
#### Loading variables from command line flags
- Command line variables.
```
$ terrafrom plan -var 'access_key=abc123' -var 'secret_key=abc123'
```
- Setting a map with var.
```
$ terraform plan -var 'ami={ eu-central-1 = "ami-1e339e71", eu-west-2 = "ami-996372fd"}'
```
- Populating a list via command line flag.
```
$ terraform plan -var 'security_group_ids =[ "sg-9d20c6f4", "sg-7d10c6f2", "sg-4f713c35"]'
```
You can pass these variables on both the plan and apply commands. Obviously, like the input prompt, this does not persist the values of variables. Next time you run Terraform, you'll again need to specify these variables values.

#### Loading variables from a file
populating variable values via files, does allow persistance. When Terraform runs it will look for a file called **terraform.tfvars**. We can populate this file with variable values that will loaded when Terraform runs.

- Creating a variable assignment file.
```
$ touch terraform.tfvars
```
- Running Terraform with a custom variable file.
```
$ terraform plan -var-file base.tfvars
```
> You can use more than one -var-file flag to specify more than one file. If you specify more than one file, the files are evaluated from first to last, in the order specified on the command line. If a variable value is specified multiple lines, the last value defined is used.

#### Loading variables from enviroment variables
Terraform will also parse any environment variables that are prefixed with `TF_VAR`. For example, if Terraform finds an environment variable as the string named:`TF_VAR_access_code]=abc123`

We can populate a map via an environment variable:`TF_VAR_ami='{eu-central-1 = "ami-1e339e71", eu-west-2 = "ami-996372fd"}'`

and a list:`TF_VAR_roles='["sg-9d20c6f4", "sg-7d10c6f2", "sg-4f713c35"]'`

> Variable files and environment variables are a good way of protecting passwords and secrets. A better way is [integration with vault for secrets management](https://www.terraform.io/docs/providers/vault/index.html)

# Stack
Build a two-tier web appication stack.
We'll create VPC and the supporting infrastructure
The ELB will be load balancing between our two EC2 instances.

- Creating the stack files.
```
$ touch web.tf variables.tf terraform.tfvars
```

# AWS Shared Credentials
On OS X we can use pip or brew to install the AWS CLI:
- Installing AWS CLI on OSX.
```
$ brew install awscli
$ sudo pip install awscli
```
- Running aws configure.
```
$ aws configure
```
- Listing: The aws/credentials file.
```
[default]
aws_access_key_id = abc123
aws_secret_access_key = abc123
```
- Listing: Te aws/config file.
```
[default]
region = eu-central-1
```
> Due to a bug with Terraform, you still need to specify region = eu-central-1 (or your region) in your Terrform configurations. This is because Terraform does not seem to read the config file in some circusmtances.

- [Environment variables meet macOS Keychain or D-Bus secret service](https://github.com/sorah/envchain)

## Modules
Modules ara a way of constructing reusable bundles of resources. They allow you to organize collections of Terraform code that you can share across configurations.
> HashiCorp makes available a collection of verified and community modules in the **Terraform Module Registry**.

### Defining a module
Modules only have one required attribute: the module's source. The source tells Terraform where to find the module's source code. You can [store modules](https://www.terraform.io/docs/modules/sources.html) locally in your filesystem or remotley in repositories such as GitHub.

- Multiple vpc modules.
```
module "vpca" {
  source = "./vpc"
  ...
}

module "vpcb" {
  source = "./vpc"
  ...
}
```
- The vpc module with a remote source.
```
module "vpc" {
  source = "gitlab.com/ZeroDeth/tf-aws-vpc"
  ...
}
