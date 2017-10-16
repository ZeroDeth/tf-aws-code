variable "instance_type" {
  default     = "t2.micro"
  description = "Instance type, see a list at: http://www.ec2instances.info/"
}

variable "region" {
  description = "AWS Region, e.g eu-central-1"
}

variable "security_groups" {
  description = "a comma separated lists of security group IDs"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "key_name" {
  description = "The SSH key pair, key name"
}

variable "subnet_id" {
  description = "A public subnet id"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}
