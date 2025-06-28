output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "public_subnets" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnets" {
  value = aws_subnet.private_subnets[*].id
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "k8s_nodes_ips" {
  value = [for instance in aws_instance.k8s_node : instance.private_ip]
}