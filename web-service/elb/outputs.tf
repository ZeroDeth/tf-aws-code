/**
 * Outputs.
 */

// The ELB name.
output "name" {
  value = "${aws_elb.main.name}"
}

// The ELB ID.
output "id" {
  value = "${aws_elb.main.id}"
}

// The ELB dns_name.
output "dns" {
  value = "${aws_elb.main.dns_name}"
}

// FQDN built using the zone domain and name (public)
output "public_fqdn" {
  value = "${aws_route53_record.public.fqdn}"
}

// FQDN built using the zone domain and name (private)
output "private_fqdn" {
  value = "${aws_route53_record.private.fqdn}"
}

// The zone id of the ELB
output "zone_id" {
  value = "${aws_elb.main.zone_id}"
}
