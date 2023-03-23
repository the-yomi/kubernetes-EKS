resource "aws_route_table" "table" {
  vpc_id = aws_vpc.kubs.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project}-Default-rt"
  }
}


# Route table and subnet associations
resource "aws_route_table_association" "internet_access" {
  count = var.availability_zones_count

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.table.id
}

resource "aws_route" "table" {
  route_table_id         = aws_vpc.kubs.default_route_table_id
  nat_gateway_id         = aws_nat_gateway.nat.id
  destination_cidr_block = "0.0.0.0/0"
}
