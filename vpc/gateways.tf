/**
 * Gateways
 */

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "${var.name}"
    Environment = "${var.environment}"
  }
}

resource "aws_nat_gateway" "main" {
  count         = "${length(var.private_subnets)}"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
  depends_on    = ["aws_internet_gateway.main"]
}

resource "aws_eip" "nat" {
  count = "${length(var.private_subnets)}"
  vpc   = true
}
