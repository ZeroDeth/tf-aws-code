// The cluster name, e.g cdn
output "name" {
  value = "${var.name}"
}

// The cluster security group ID.
output "security_group_id" {
  value = "${aws_security_group.cluster.id}"
}
