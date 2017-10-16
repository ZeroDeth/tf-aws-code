variable "name" {
  description = "the name of your stack, e.g. \"bossa-stack\""
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod-central\""
}

variable "key_name" {
  description = "the name of the ssh key to use, e.g. \"bossa-key\""
}

variable "domain_name" {
  description = "the private DNS name to use with services"
  default     = "bossa.local"
}

variable "domain_name_servers" {
  description = "the private DNS servers, defaults to the private route53 server of the VPC"
  default     = ""
}

variable "region" {
  description = "the AWS region in which resources are created, you must set the availability_zones variable as well if you define this value to something other than the default"
  default     = "eu-central-1"
}

variable "cidr" {
  description = "the CIDR block to provision for the VPC, if set to something other than the default, both private_subnets and public_subnets have to be defined as well"
  default     = "10.30.0.0/16"
}

variable "private_subnets" {
  description = "a list of CIDRs for private subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = ["10.30.0.0/19" ,"10.30.64.0/19", "10.30.128.0/19"]
}

variable "public_subnets" {
  description = "a list of CIDRs for public subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = ["10.30.32.0/20", "10.30.96.0/20", "10.30.160.0/20"]
}

variable "availability_zones" {
  description = "a comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "bastion_instance_type" {
  description = "Instance type for the bastion"
  default = "t2.micro"
}

variable "ecs_cluster_name" {
  description = "the name of the cluster, if not specified the variable name will be used"
  default = ""
}

variable "ecs_instance_type" {
  description = "the instance type to use for your default ecs cluster"
  default     = "m4.large"
}

variable "ecs_instance_ebs_optimized" {
  description = "use EBS - not all instance types support EBS"
  default     = true
}

variable "ecs_min_size" {
  description = "the minimum number of instances to use in the default ecs cluster"

  // create 3 instances in our cluster by default
  // 2 instances to run our service with high-availability
  // 1 extra instance so we can deploy without port collisions
  default = 3
}

variable "ecs_max_size" {
  description = "the maximum number of instances to use in the default ecs cluster"
  default     = 100
}

variable "ecs_desired_capacity" {
  description = "the desired number of instances to use in the default ecs cluster"
  default     = 3
}

variable "ecs_root_volume_size" {
  description = "the size of the ecs instance root volume"
  default     = 25
}

variable "ecs_docker_volume_size" {
  description = "the size of the ecs instance docker volume"
  default     = 25
}

variable "ecs_docker_auth_type" {
  description = "The docker auth type, see https://godoc.org/github.com/aws/amazon-ecs-agent/agent/engine/dockerauth for the possible values"
  default     = ""
}

variable "ecs_docker_auth_data" {
  description = "A JSON object providing the docker auth data, see https://godoc.org/github.com/aws/amazon-ecs-agent/agent/engine/dockerauth for the supported formats"
  default     = ""
}

variable "ecs_security_groups" {
  description = "A comma separated list of security groups from which ingest traffic will be allowed on the ECS cluster, it defaults to allowing ingress traffic on port 22 and coming grom the ELBs"
  default     = ""
}

variable "ecs_ami" {
  description = "The AMI that will be used to launch EC2 instances in the ECS cluster"
  default     = ""
}

variable "extra_cloud_config_type" {
  description = "Extra cloud config type"
  default     = "text/cloud-config"
}

variable "extra_cloud_config_content" {
  description = "Extra cloud config content"
  default     = ""
}

variable "logs_expiration_enabled" {
  default = false
}

variable "logs_expiration_days" {
  default = 30
}
