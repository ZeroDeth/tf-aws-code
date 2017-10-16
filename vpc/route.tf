
/**
 * Route tables
 */

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "${var.name}-public-001"
    Environment = "${var.environment}"
  }
}

resource "aws_route" "public" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
}

resource "aws_route_table" "private" {
  count  = "${length(var.private_subnets)}"
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "${var.name}-${format("private-%03d", count.index+1)}"
    Environment = "${var.environment}"
  }
}

resource "aws_route" "private" {
  count                  = "${length(compact(var.private_subnets))}"
  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.main.*.id, count.index)}"
}

/**
 * Route associations
 */

resource "aws_route_table_association" "private" {
  count          = "${length(var.private_subnets)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnets)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}
