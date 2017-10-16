
/**
 * Resources.
 */

resource "aws_security_group" "main" {
  name        = "${var.name}-rds-cluster"
  description = "Allows traffic to rds from other security groups"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port       = "${var.port}"
    to_port         = "${var.port}"
    protocol        = "TCP"
    security_groups = ["${var.security_groups}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "RDS cluster (${var.name})"
    Environment = "${var.environment}"
  }
}

resource "aws_db_subnet_group" "main" {
  name        = "${var.name}"
  description = "RDS cluster subnet group"
  subnet_ids  = ["${var.subnet_ids}"]
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count                = "${var.instance_count}"
  db_subnet_group_name = "${aws_db_subnet_group.main.id}"
  cluster_identifier   = "${aws_rds_cluster.main.id}"
  publicly_accessible  = "${var.publicly_accessible}"
  instance_class       = "${var.instance_type}"

  # need a deterministic identifier or terraform will force a new resource every apply
  identifier = "${aws_rds_cluster.main.id}-${count.index}"
}

resource "aws_rds_cluster" "main" {
  cluster_identifier        = "${var.name}"
  availability_zones        = ["${var.availability_zones}"]
  database_name             = "${var.database_name}"
  master_username           = "${var.master_username}"
  master_password           = "${var.master_password}"
  backup_retention_period   = "${var.backup_retention_period}"
  preferred_backup_window   = "${var.preferred_backup_window}"
  vpc_security_group_ids    = ["${aws_security_group.main.id}"]
  db_subnet_group_name      = "${aws_db_subnet_group.main.id}"
  port                      = "${var.port}"
  skip_final_snapshot       = "${var.skip_final_snapshot}"
  final_snapshot_identifier = "${var.name}-finalsnapshot"
}

resource "aws_route53_record" "main" {
  zone_id = "${var.zone_id}"
  name    = "${coalesce(var.dns_name, var.name)}"
  type    = "CNAME"
  ttl     = 300
  records = ["${aws_rds_cluster.main.endpoint}"]
}
