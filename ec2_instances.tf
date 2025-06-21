resource "aws_instance" "public_instances" {
  count                       = 2
  ami                         = var.general_host_ami
  instance_type               = "t2.micro"
  key_name                    = var.ssh_key_name
  subnet_id                   = element(aws_subnet.public_subnets[*].id, count.index)
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "PublicInstance-${count.index + 1}"
  }
}

resource "aws_instance" "private_instances" {
  count                       = 2
  ami                         = var.general_host_ami
  instance_type               = "t2.micro"
  key_name                    = var.ssh_key_name
  subnet_id                   = element(aws_subnet.private_subnets[*].id, count.index)
  vpc_security_group_ids      = [aws_security_group.private_sg.id]
  associate_public_ip_address = false

  tags = {
    Name = "PrivateInstance-${count.index + 1}"
  }
}
