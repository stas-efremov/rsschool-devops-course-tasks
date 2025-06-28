variable "aws_region" {
  description = "AWS region for resources to deploy"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "Network block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Network blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "Network blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "bastion_host_ami" {
  description = "AMI ID for Bastion Host (Amazon Linux)"
  default     = "ami-09e6f87a47903347c"
}

variable "general_host_ami" {
  description = "AMI ID for Bastion Host (Amazon Linux)"
  default     = "ami-09e6f87a47903347c"
}

variable "ssh_key_name" {
  description = "SSH key pair name to access instances"
  type        = string
}
