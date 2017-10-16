// The region in which the infra lives.
output "region" {
  value = "${var.region}"
}

// The bastion host IP.
output "bastion_ip" {
  value = "${module.bastion.public_ip}"
}

// The private route53 zone ID.
output "zone_id" {
  value = "${module.dns.zone_id}"
}

// Security group for private ELBs.
output "private_elb" {
  value = "${module.security_groups.private_elb}"
}

// Security group for public ELBs.
output "public_elb" {
  value = "${module.security_groups.public_elb}"
}

// Comma separated list of private subnet IDs.
output "private_subnets" {
  value = "${module.vpc.private_subnets}"
}

// Comma separated list of public subnet IDs.
output "public_subnets" {
  value = "${module.vpc.public_subnets}"
}

// ECS Service IAM role.
output "iam_role" {
  value = "${module.iam_role.arn}"
}

// Default ECS role ID. Useful if you want to add a new policy to that role.
output "iam_role_default_ecs_role_id" {
  value = "${module.iam_role.default_ecs_role_id}"
}

// S3 bucket ID for ELB logs.
output "log_bucket_id" {
  value = "${module.s3_logs.id}"
}

// The private domain name, e.g "stack.local".
output "domain_name" {
  value = "${module.dns.name}"
}

// The environment of the stack, e.g "prod".
output "environment" {
  value = "${var.environment}"
}

// The default ECS cluster name.
output "cluster" {
  value = "${module.ecs_cluster.name}"
}

// The VPC availability zones.
output "availability_zones" {
  value = "${module.vpc.availability_zones}"
}

// The VPC security group ID.
output "vpc_security_group" {
  value = "${module.vpc.security_group}"
}

// The VPC ID.
output "vpc_id" {
  value = "${module.vpc.id}"
}

// The default ECS cluster security group ID.
output "ecs_cluster_security_group_id" {
  value = "${module.ecs_cluster.security_group_id}"
}

// Comma separated list of private route table IDs.
output "private_route_tables" {
  value = "${module.vpc.private_rtb_id}"
}

// The public route table ID.
output "public_route_tables" {
  value = "${module.vpc.public_rtb_id}"
}
