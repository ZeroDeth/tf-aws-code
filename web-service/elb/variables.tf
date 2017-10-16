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

variable "healthcheck" {
  description = "Healthcheck path"
}

variable "log_bucket" {
  description = "S3 bucket name to write ELB logs into"
}

variable "public_dns_name" {
  description = "The subdomain under which the ELB is exposed externally, defaults to the task name"
}

variable "private_dns_name" {
  description = "The subdomain under which the ELB is exposed internally, defaults to the task name"
}

variable "public_zone_id" {
  description = "The zone ID to create the record in"
}

variable "private_zone_id" {
  description = "The zone ID to create the record in"
}

variable "ssl_certificate_id" {
}
