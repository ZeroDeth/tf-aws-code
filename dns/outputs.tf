// The domain name.
output "name" {
  value = "${var.name}"
}

// The zone ID.
output "zone_id" {
  value = "${aws_route53_zone.main.zone_id}"
}

// A comma separated list of the zone name servers.
output "name_servers" {
  value = "${join(",",aws_route53_zone.main.name_servers)}"
}
