variable "name" {
  description = "The name will be used to prefix and tag the resources, e.g mydb"
}

variable "environment" {
  description = "The environment tag, e.g prod"
}

variable "vpc_id" {
  description = "The VPC ID to use"
}

variable "zone_id" {
  description = "The Route53 Zone ID where the DNS record will be created"
}

variable "security_groups" {
  description = "A list of security group IDs"
  type        = "list"
}

variable "subnet_ids" {
  description = "A list of subnet IDs"
  type        = "list"
}

variable "availability_zones" {
  description = "A list of availability zones"
  type        = "list"
}

variable "database_name" {
  description = "The database name"
}

variable "master_username" {
  description = "The master user username"
}

variable "master_password" {
  description = "The master user password"
}

variable "instance_type" {
  description = "The type of instances that the RDS cluster will be running on"
  default     = "db.r3.large"
}

variable "instance_count" {
  description = "How many instances will be provisioned in the RDS cluster"
  default     = 1
}

variable "preferred_backup_window" {
  description = "The time window on which backups will be made (HH:mm-HH:mm)"
  default     = "07:00-09:00"
}

variable "backup_retention_period" {
  description = "The backup retention period"
  default     = 5
}

variable "publicly_accessible" {
  description = "When set to true the RDS cluster can be reached from outside the VPC"
  default     = false
}

variable "dns_name" {
  description = "Route53 record name for the RDS database, defaults to the database name if not set"
  default     = ""
}

variable "port" {
  description = "The port at which the database listens for incoming connections"
  default     = 3306
}

variable "skip_final_snapshot" {
  description = "When set to false deletion will be delayed to take a snapshot from which the database can be recovered"
  default     = true
}
