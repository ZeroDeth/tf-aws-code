
/**
 * Resources.
 */

resource "aws_ecs_service" "main" {
  name                               = "${module.task.name}"
  cluster                            = "${var.cluster}"
  task_definition                    = "${module.task.arn}"
  desired_count                      = "${var.desired_count}"
  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  deployment_maximum_percent         = "${var.deployment_maximum_percent}"

  lifecycle {
    create_before_destroy = true
  }
}

module "task" {
  source = "../task"

  name          = "${coalesce(var.name, var.image)}"
  image         = "${var.image}"
  image_version = "${var.version}"
  command       = "${var.command}"
  env_vars      = "${var.env_vars}"
  memory        = "${var.memory}"
  cpu           = "${var.cpu}"
}
