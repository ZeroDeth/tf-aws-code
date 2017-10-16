// public SSH allows ssh connections on port 22 from the world.
output "public_ssh" {
  value = "${aws_security_group.public_ssh.id}"
}

// private SSH allows ssh connections from the public ssh security group.
output "private_ssh" {
  value = "${aws_security_group.private_ssh.id}"
}

// private ELB allows private traffic.
output "private_elb" {
  value = "${aws_security_group.private_elb.id}"
}

// public ELB allows traffic from the world.
output "public_elb" {
  value = "${aws_security_group.public_elb.id}"
}
