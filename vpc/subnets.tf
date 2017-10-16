/**
 * Subnets.
 */

resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${element(var.private_subnets, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  count             = "${length(var.private_subnets)}"

  tags {
    Name        = "${var.name}-${format("private-%03d", count.index+1)}"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${element(var.public_subnets, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  count                   = "${length(var.public_subnets)}"
  map_public_ip_on_launch = true

  tags {
    Name        = "${var.name}-${format("public-%03d", count.index+1)}"
    Environment = "${var.environment}"
  }
}
