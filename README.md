# rsschool-devops-course-tasks
# Terraform VPC Infrastructure Setup

This Terraform project configures the basic networking infrastructure required for a Kubernetes (K8s) cluster:
- Public and private subnets across multiple AZs
- Internet Gateway and NAT Gateway
- Routing between resources
- Bastion host for accessing instances
- Security groups for isolation and access control

## Security Groups

- **BastionSG**: Allows SSH from any IP
- **PrivateSG**: Allows SSH from Bastion only, full internal communication

## Usage Instructions

### Prerequisites

- AWS CLI installed and configured
- Terraform installed
- SSH key pair created and added to AWS EC2

### Steps

1. Clone this repo
2. Initialize Terraform:
   terraform init
3. Review plan:
   terraform plan
4. Apply configuration
   terraform apply

To destroy everything:
   terraform destroy
