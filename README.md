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

## Kubernetes (K8s) 2-nodes cluster setup

1. **Deploy the infrastructure for Kubernetes cluster(Optional)**

   - Clone this repo
   - Deploy the required resources: terraform apply. This will deploy a Bastion host and 2 EC2 instances

2. **Setup Kubernetes cluster**

   - Connect to the Bastion host via SSH
   - Connect from the Bastion host to one of the hosts via SSH
   - Install the single-node Kubernetes cluster using K3s, lightweight Kubernetes distribution: curl -sfL https://get.k3s.io | sh -
   - Connect to the second host via SSH
   - Use K3s to run agent node on the second host: curl -sfL https://get.k3s.io | K3S_URL=https://<master_node>:6443 K3S_TOKEN=<mynodetoken> sh -
		, where <master_node> is the IP or the DNS name of the master node(first host) and <mynodetoken> is the token stored in the /var/lib/rancher/k3s/server/node-token on the master node

3. **Verify cluster state**
   - Run "kubectl get nodes" to check the status of the cluster
   
4. **Optional. Run sample workload in the cluster**
   - Run "kubectl apply -f https://k8s.io/examples/pods/simple-pod.yaml" to deploy a sample nginx pod in the cluster
   - Verify nginx pod is running: kubectl get pods