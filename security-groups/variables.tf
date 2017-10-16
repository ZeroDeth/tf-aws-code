variable "name" {
  description = "The name of the security groups serves as a prefix, e.g bossa-stack"
}

variable "vpc_id" {
  description = "The VPC ID"
}

variable "environment" {
  description = "The environment, used for tagging, e.g prod"
}

variable "cidr" {
  description = "The cidr block to use for private security groups"
}
