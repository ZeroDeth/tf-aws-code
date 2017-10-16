
/**
 * Resources.
 */

module "defaults" {
  source = "./defaults"
  region = "${var.region}"
  cidr   = "${var.cidr}"
}

module "vpc" {
  source             = "./vpc"
  name               = "${var.name}"
  cidr               = "${var.cidr}"
  private_subnets   = "${var.private_subnets}"
  public_subnets   = "${var.public_subnets}"
  availability_zones = "${var.availability_zones}"
  environment        = "${var.environment}"
}

module "security_groups" {
  source      = "./security-groups"
  name        = "${var.name}"
  vpc_id      = "${module.vpc.id}"
  environment = "${var.environment}"
  cidr        = "${var.cidr}"
}

module "bastion" {
  source          = "./bastion"
  region          = "${var.region}"
  instance_type   = "${var.bastion_instance_type}"
  security_groups = "${module.security_groups.public_ssh},${module.security_groups.private_ssh}"
  vpc_id          = "${module.vpc.id}"
  subnet_id       = "${element(module.vpc.public_subnets, 0)}"
  key_name        = "${var.key_name}"
  environment     = "${var.environment}"
}

module "dhcp" {
  source  = "./dhcp"
  name    = "${module.dns.name}"
  vpc_id  = "${module.vpc.id}"
  servers = "${coalesce(var.domain_name_servers, module.defaults.domain_name_servers)}"
}

module "dns" {
  source = "./dns"
  name   = "${var.domain_name}"
  vpc_id = "${module.vpc.id}"
}

module "iam_role" {
  source      = "./iam-role"
  name        = "${var.name}"
  environment = "${var.environment}"
}

module "ecs_cluster" {
  source                 = "./ecs-cluster"
  name                   = "${coalesce(var.ecs_cluster_name, var.name)}"
  environment            = "${var.environment}"
  vpc_id                 = "${module.vpc.id}"
  image_id               = "${coalesce(var.ecs_ami, module.defaults.ecs_ami)}"
  subnet_ids             = "${module.vpc.private_subnets}"
  key_name               = "${var.key_name}"
  instance_type          = "${var.ecs_instance_type}"
  instance_ebs_optimized = "${var.ecs_instance_ebs_optimized}"
  iam_instance_profile   = "${module.iam_role.profile}"
  min_size               = "${var.ecs_min_size}"
  max_size               = "${var.ecs_max_size}"
  desired_capacity       = "${var.ecs_desired_capacity}"
  region                 = "${var.region}"
  availability_zones     = "${module.vpc.availability_zones}"
  root_volume_size       = "${var.ecs_root_volume_size}"
  docker_volume_size     = "${var.ecs_docker_volume_size}"
  docker_auth_type       = "${var.ecs_docker_auth_type}"
  docker_auth_data       = "${var.ecs_docker_auth_data}"
  security_groups        = "${coalesce(var.ecs_security_groups, format("%s,%s,%s", module.security_groups.private_ssh, module.security_groups.private_elb, module.security_groups.public_elb))}"
  extra_cloud_config_type     = "${var.extra_cloud_config_type}"
  extra_cloud_config_content  = "${var.extra_cloud_config_content}"
}

module "s3_logs" {
  source                  = "./s3-logs"
  name                    = "${var.name}"
  environment             = "${var.environment}"
  account_id              = "${module.defaults.s3_logs_account_id}"
  logs_expiration_enabled = "${var.logs_expiration_enabled}"
  logs_expiration_days    = "${var.logs_expiration_days}"
}
