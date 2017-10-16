variable "name" {
  description = "ELB name, e.g cdn"
}

variable "subnet_ids" {
  description = "Comma separated list of subnet IDs"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}

variable "port" {
  description = "Instance port"
}

variable "security_groups" {
  description = "Comma separated list of security group IDs"
}

variable "dns_name" {
  description = "Route53 record name"
}

variable "healthcheck" {
  description = "Healthcheck path"
}

variable "protocol" {
  description = "Protocol to use, HTTP or TCP"
}

variable "zone_id" {
  description = "Route53 zone ID to use for dns_name"
}

variable "log_bucket" {
  description = "S3 bucket name to write ELB logs into"
}
