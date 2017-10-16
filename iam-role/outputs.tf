output "default_ecs_role_id" {
  value = "${aws_iam_role.default_ecs_role.id}"
}

output "arn" {
  value = "${aws_iam_role.default_ecs_role.arn}"
}

output "profile" {
  value = "${aws_iam_instance_profile.default_ecs.id}"
}
