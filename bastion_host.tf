resource "aws_instance" "bastion" {
  ami                         = var.bastion_host_ami
  instance_type               = "t3.micro"
  key_name                    = var.ssh_key_name
  subnet_id                   = element(aws_subnet.public_subnets[*].id, 0)
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "BastionHost"
  }
}