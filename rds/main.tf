
/**
 * Resources.
 */

resource "aws_security_group" "main" {
  name        = "${var.name}-rds"
  description = "Allows traffic to RDS from other security groups"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port       = "${var.port}"
    to_port         = "${var.port}"
    protocol        = "TCP"
    security_groups = ["${var.ingress_allow_security_groups}"]
  }

  ingress {
    from_port   = "${var.port}"
    to_port     = "${var.port}"
    protocol    = "TCP"
    cidr_blocks = ["${var.ingress_allow_cidr_blocks}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "RDS (${var.name})"
  }
}

resource "aws_db_subnet_group" "main" {
  name        = "${var.name}"
  description = "RDS subnet group"
  subnet_ids  = ["${var.subnet_ids}"]
}

resource "aws_db_instance" "main" {
  identifier = "${var.name}"

  # Database
  engine         = "${var.engine}"
  engine_version = "${var.engine_version}"
  username       = "${coalesce(var.username, var.name)}"
  password       = "${var.password}"
  multi_az       = "${var.multi_az}"
  name           = "${coalesce(var.database, var.name)}"

  # Backups / maintenance
  backup_retention_period   = "${var.backup_retention_period}"
  backup_window             = "${var.backup_window}"
  maintenance_window        = "${var.maintenance_window}"
  monitoring_interval       = "${var.monitoring_interval}"
  monitoring_role_arn       = "${var.monitoring_role_arn}"
  apply_immediately         = "${var.apply_immediately}"
  final_snapshot_identifier = "${var.name}-finalsnapshot"

  # Hardware
  instance_class    = "${var.instance_class}"
  storage_type      = "${var.storage_type}"
  allocated_storage = "${var.allocated_storage}"

  # Network / security
  db_subnet_group_name   = "${aws_db_subnet_group.main.id}"
  vpc_security_group_ids = ["${aws_security_group.main.id}"]
  publicly_accessible    = "${var.publicly_accessible}"
}
