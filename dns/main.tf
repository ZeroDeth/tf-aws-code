
/**
 * Resources.
 */
 
resource "aws_route53_zone" "main" {
  name    = "${var.name}"
  vpc_id  = "${var.vpc_id}"
  comment = ""
}
