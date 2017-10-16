// The cluster identifier.
output "id" {
  value = "${aws_rds_cluster.main.id}"
}

output "endpoint" {
  value = "${aws_rds_cluster.main.endpoint}"
}

output "fqdn" {
  value = "${aws_route53_record.main.fqdn}"
}

output "port" {
  value = "${aws_rds_cluster.main.port}"
}
