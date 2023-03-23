resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.kubs.id

  tags = {
    Name = "${var.project}-igw"
  }
  depends_on = [aws_vpc.kubs]
}
