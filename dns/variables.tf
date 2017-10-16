variable "name" {
  description = "Zone name, e.g bossa.local"
}

variable "vpc_id" {
  description = "The VPC ID (omit to create a public zone)"
  default     = ""
}
