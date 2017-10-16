/**
 * Outputs.
 */

// The aws access key id.
output "access_key" {
  value = "${aws_iam_access_key.main.id}"
}

// The aws secret access key.
output "secret_key" {
  value = "${aws_iam_access_key.main.secret}"
}

// The user ARN
output "arn" {
  value = "${aws_iam_user.main.arn}"
}
