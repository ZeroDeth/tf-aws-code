/**
 * Outputs.
 */

// The name of the ELB
output "name" {
  value = "${module.elb.name}"
}

// The DNS name of the ELB
output "dns" {
  value = "${module.elb.dns}"
}

// The id of the ELB
output "elb" {
  value = "${module.elb.id}"
}

// The zone id of the ELB
output "zone_id" {
  value = "${module.elb.zone_id}"
}

// FQDN built using the zone domain and name (public)
output "public_fqdn" {
  value = "${module.elb.public_fqdn}"
}

// FQDN built using the zone domain and name (private)
output "private_fqdn" {
  value = "${module.elb.private_fqdn}"
}
