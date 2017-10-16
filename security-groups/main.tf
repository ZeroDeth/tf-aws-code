
/**
 * Resources.
 */

resource "aws_security_group" "private_elb" {
  name        = "${format("%s-%s-private-elb", var.name, var.environment)}"
  vpc_id      = "${var.vpc_id}"
  description = "Allows private ELB traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name        = "${format("%s private elb", var.name)}"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group" "public_elb" {
  name        = "${format("%s-%s-public-elb", var.name, var.environment)}"
  vpc_id      = "${var.vpc_id}"
  description = "Allows public ELB traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name        = "${format("%s public elb", var.name)}"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group" "public_ssh" {
  name        = "${format("%s-%s-public-ssh", var.name, var.environment)}"
  description = "Allows ssh from the world"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name        = "${format("%s public ssh", var.name)}"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group" "private_ssh" {
  name        = "${format("%s-%s-private-ssh", var.name, var.environment)}"
  description = "Allows ssh from bastion"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.public_ssh.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr}"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name        = "${format("%s private ssh", var.name)}"
    Environment = "${var.environment}"
  }
}
