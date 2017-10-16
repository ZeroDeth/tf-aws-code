
/**
 * IAM User.
 */

resource "aws_iam_user" "main" {
  name = "${var.name}"

  lifecycle {
    create_before_destroy = true
  }
}

/**
 * Access Key.
 */

resource "aws_iam_access_key" "main" {
  user = "${aws_iam_user.main.name}"

  lifecycle {
    create_before_destroy = true
  }
}

/**
 * Policy.
 */

resource "aws_iam_user_policy" "main" {
  name   = "${var.name}"
  user   = "${aws_iam_user.main.name}"
  policy = "${var.policy}"

  lifecycle {
    create_before_destroy = true
  }
}
