
/**
 * Required Variables.
 */

variable "environment" {
  description = "Environment tag, e.g prod"
}

variable "image" {
  description = "The docker image name, e.g nginx"
}

variable "name" {
  description = "The worker name, if empty the service name is defaulted to the image name"
  default     = ""
}

variable "version" {
  description = "The docker image version"
  default     = "latest"
}

variable "cluster" {
  description = "The cluster name or ARN"
}

/**
 * Options.
 */

variable "command" {
  description = "The raw json of the task command"
  default     = "[]"
}

variable "env_vars" {
  description = "The raw json of the task env vars"
  default     = "[]"
}

variable "desired_count" {
  description = "The desired count"
  default     = 1
}

variable "memory" {
  description = "The number of MiB of memory to reserve for the container"
  default     = 512
}

variable "cpu" {
  description = "The number of cpu units to reserve for the container"
  default     = 512
}

variable "deployment_minimum_healthy_percent" {
  description = "lower limit (% of desired_count) of # of running tasks during a deployment"
  default     = 100
}

variable "deployment_maximum_percent" {
  description = "upper limit (% of desired_count) of # of running tasks during a deployment"
  default     = 200
}
