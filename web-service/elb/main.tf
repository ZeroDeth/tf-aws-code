

/**
 * Resources.
 */

resource "aws_elb" "main" {
  name = "${var.name}"

  private                  = false
  cross_zone_load_balancing = true
  subnets                   = ["${split(",", var.subnet_ids)}"]
  security_groups           = ["${split(",",var.security_groups)}"]

  idle_timeout                = 30
  connection_draining         = true
  connection_draining_timeout = 15

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "${var.port}"
    instance_protocol = "http"
  }

  listener {
    lb_port            = 443
    lb_protocol        = "https"
    instance_port      = "${var.port}"
    instance_protocol  = "http"
    ssl_certificate_id = "${var.ssl_certificate_id}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTP:${var.port}${var.healthcheck}"
    interval            = 30
  }

  access_logs {
    bucket = "${var.log_bucket}"
  }

  tags {
    Name        = "${var.name}-balancer"
    Service     = "${var.name}"
    Environment = "${var.environment}"
  }
}

resource "aws_route53_record" "public" {
  zone_id = "${var.public_zone_id}"
  name    = "${var.public_dns_name}"
  type    = "A"

  alias {
    zone_id                = "${aws_elb.main.zone_id}"
    name                   = "${aws_elb.main.dns_name}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "private" {
  zone_id = "${var.private_zone_id}"
  name    = "${var.private_dns_name}"
  type    = "A"

  alias {
    zone_id                = "${aws_elb.main.zone_id}"
    name                   = "${aws_elb.main.dns_name}"
    evaluate_target_health = false
  }
}
