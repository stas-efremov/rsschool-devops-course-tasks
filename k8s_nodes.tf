resource "aws_instance" "k8s_node" {
  count                       = 2
  ami                         = var.general_host_ami
  instance_type               = "t3.micro"
  key_name                    = var.ssh_key_name
  subnet_id                   = element(aws_subnet.private_subnets[*].id, count.index)
  vpc_security_group_ids      = [aws_security_group.private_sg.id]
  associate_public_ip_address = false

  tags = {
    Name = "K8sNode-${count.index + 1}"
  }
}
