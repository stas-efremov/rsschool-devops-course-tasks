resource "aws_eip" "nat_eip" {
  tags = {
    Name = "NATEIP"
  }
}

resource "aws_nat_gateway" "main_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public_subnets[*].id, 0)

  tags = {
    Name = "MainNAT"
  }
}
