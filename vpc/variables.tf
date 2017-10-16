/**
 * Variables
 */

variable "cidr" {
  description = "The CIDR block for the VPC."
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = "list"
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = "list"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = "list"
}

variable "name" {
  description = "Name tag, e.g bossa-stack"
  default     = "bossa-stack"
}
