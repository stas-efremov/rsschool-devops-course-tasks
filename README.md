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


## Setup Jenkins using Helm on Minikube
CD to jenkins_helm subdirectory
1. **Install Minikube: https://minikube.sigs.k8s.io/docs/start**
   Start minikube:
   minikube start
   Make services available outside cluster:
   minikube tunnel

2. **Install Helm: https://helm.sh/docs/intro/install/**
   Check Helm on Minikube:
   helm install my-nginx oci://registry-1.docker.io/bitnamicharts/nginx
   helm list
   helm uninstall my-nginx

3. **Once Helm is installed and set up properly, add the Jenkins repo as follows:**
   helm repo add jenkinsci https://charts.jenkins.io
   helm repo update

   The helm charts in the Jenkins repo can be listed with the command:
   helm search repo jenkinsci
   
4. **Create namespace for jenkins:**
   kubectl apply -f jenkins-ns.yaml

5. **CCreate a volume which is called jenkins-pv:**
   kubectl apply -f jenkins-volume.yaml

   Minikube configured for hostPath sets the permissions on /data to the root account only. Once the volume is created you will need to manually change the permissions to allow the jenkins account to write its data.
   minikube ssh
   sudo chown -R 1000:1000 /data/jenkins-volume

6. **Create a service account called jenkins:**
   kubectl apply -f jenkins-sa.yaml

7. **Modify jenkins-values.yaml file to adjust jenkins helm values as per needs**

8. **Install Jenkins Helm chart with adjusted values:**
   helm install jenkins -n jenkins -f jenkins-values.yaml jenkinsci/jenkins

9. **Get Jenkins admin password:**
   kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password

10. **Access Jenkins web interface to configure and check pre-configured job:**
   http://<NodeIP>:30080


## Simple Flask Application Deployment with Helm chart on Minikube
CD to helm subdirectory
- "flask_app" folder contains the sample Flask application
- "flask_app_helm_chart" folder contains a custom helm chart to run flask application(or other applications)
1. **Edit helm chart values**
   Edit values in the flask-app-values.yaml file as per needs.
   The values which may need to be usually adjusted: 
      appName - visible name of the application;
      appImage - uri of the image in the container registry;
      appVersion - application version(normally the tag of the image in the registry)

2. **Install Helm chart using provided values file**
   helm install -f flask-app-values.yaml hello-world-flask flask_app_helm_chart

3. **(Optional)Uninstall Helm chart**
   helm uninstall hello-world-flask

