

/**
 * Resources.
 */

resource "aws_ecs_service" "main" {
  name                               = "${module.task.name}"
  cluster                            = "${var.cluster}"
  task_definition                    = "${module.task.arn}"
  desired_count                      = "${var.desired_count}"
  iam_role                           = "${var.iam_role}"
  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  deployment_maximum_percent         = "${var.deployment_maximum_percent}"

  load_balancer {
    elb_name       = "${module.elb.id}"
    container_name = "${module.task.name}"
    container_port = "${var.container_port}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

module "task" {
  source = "../task"

  name          = "${coalesce(var.name, replace(var.image, "/", "-"))}"
  image         = "${var.image}"
  image_version = "${var.version}"
  command       = "${var.command}"
  env_vars      = "${var.env_vars}"
  memory        = "${var.memory}"
  cpu           = "${var.cpu}"

  ports = <<EOF
  [
    {
      "containerPort": ${var.container_port},
      "hostPort": ${var.port}
    }
  ]
EOF
}

module "elb" {
  source = "../elb"

  name            = "${module.task.name}"
  port            = "${var.port}"
  environment     = "${var.environment}"
  subnet_ids      = "${var.subnet_ids}"
  security_groups = "${var.security_groups}"
  dns_name        = "${coalesce(var.dns_name, module.task.name)}"
  healthcheck     = "${var.healthcheck}"
  protocol        = "${var.protocol}"
  zone_id         = "${var.zone_id}"
  log_bucket      = "${var.log_bucket}"
}
