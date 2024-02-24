# My-todo-app with Terraform on AWS

This repository contains the source code and necessary configurations for my-todo-app, a simple to-do application developed in Python, to be hosted on AWS using an EKS cluster.

---

## Table of Contents

- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Deployment](#deployment)
- [Cleanup](#cleanup)
- [License](#license)
- [Image](#image)


---

## Architecture

```plaintext
MY_TODO_PROJECT_AWS
│
├── Dockerfile
├── jenkinsfile
├── requirements.txt
│
├── terraform
│   ├── 00-versions.tf
│   ├── 01-provider.tf
│   ├── 02-backend_setup.tf
│   ├── 03-backend.tf
│   ├── 04-vpc.tf
│   ├── 05-subnets.tf
│   ├── 06-igw.tf
│   ├── 07-natgw.tf
│   ├── 08-route_table.tf
│   ├── 09-eks_iam_role.tf
│   ├── 10-worker_nodes_iam_role.tf
│   ├── 11-eks_cluster.tf
│   ├── 12-node_group.tf
│   ├── 13-eks_sg.tf
│   ├── 14-rds.tf
│   ├── 15-secret_policy.tf
│   ├── 16-variable.tf
│   └── 17-output.tf
│
├── todo_app
│   ├── app.py
│   ├── fetch_secrets.py
│   ├── test_app.py
│   └── templates
│       └── index.html
│
└── todo_app_charts
    ├── Chart.yaml
    ├── values.yaml
    └── templates
        ├── deployment.yaml
        └── service.yaml

```
---
## Prerequisites

- Ensure you have the following tools installed:

- AWS CLI
- eksctl
- kubectl
- helm
- terraform
- See the link below for guide on "Getting started with Amazon EKS" 

(https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html)

- Once installed, verify your installations with:

```bash
aws --version
eksctl version
kubectl version
```
- You also need to configure 'aws' with your credentials:

```bash
aws configure
```
- This will prompt you to enter your AWS Access Key ID, Secret Access Key, region, and output format. You can find the relevant informations from your IAM service.

---
## Deployment

### 1. Creating EKS cluster

#### 1.1 Clone repository

```bash
git clone https://github.com/hungvietlai/my_todo_project_aws.git
cd terraform/
```

#### 1.2 Configure your variables
- Change the default values in the variables.tf file accordingly.

```bash
variable "region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS region where the resources will be created."
}

variable "vpc_cidr_block" {
  type        = string
  default     = "192.168.0.0/16"
  description = "The cidr block of the VPC where the EKS cluster and related resources will be deployed."
}

variable "subnet1_cidr" {
  type        = list(string)
  default     = ["192.168.0.0/24", "192.168.1.0/24"]
  description = "A list of CIDR blocks for the subnets1 in the EKS cluster."
}

```

#### 1.3 Manually Configure the Credentials in Secrets Manager on AWS

- Log in to your AWS console.
- Navigate to Secrets Manager.
- Store a new secret with credentials for your application.

```bash
{"username":"your_user_name",
 "password": "your_password" }

```
#### 1.4 Update AWS IAM Policy for My Secret Policy

- Replace <REGION>, <ACCOUNT_ID>, and <SECRET_NAME> with your specific details.

```bash

resource "aws_iam_policy" "my_secret_policy" {
  name        = "MySecretsManagerAccessPolicy"
  description = "Policy to access specific secrets in AWS Secrets Manager"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
        ],
        "Effect"   : "Allow",
        "Resource" : "arn:aws:secretsmanager:<REGION>:<ACCOUNT_ID>:secret:<SECRET_NAME>"
      },
    ]
  })
}

```
#### 1.5 Deploy EkS cluster

```bash
terraform init
terraform apply
```

### 2. Configure kubectl

- Update your kubectl config to manage the EKS cluster.

```bash
aws eks --region <region_code> update-kubeconfig --name <cluster_name>
```

#### 2.1 Verify your nodes:

```bash
kubectl get nodes
```
- There should be 3 nodes listed.

### 3.Deploy the ToDo App:

```bash
helm install todo-app todo_app_charts/
```
#### 3.1 Check deployments, services:

```bash
kubectl get deploy,svc
```
- You should observe 2 deployments and 2 services.

### 4. Access the app:

- Access the to-do app via LoadBalancer public IP

- **Note**: If you can't access the app, review the security settings of the LB in the EC2 dashboard. Ensure inbound rules allow traffic on ports 80.

## Cleanup:

- When done testing, to avoid unnecessary costs, delete the cluster:

```bash
helm uninstall todo-app
terraform destroy
```
## License 

This project is licensed under the MIT License. For the full text of the license, see the LICENSE file.

### Image 
![infra-image](https://github.com/hungvietlai/my_todo_project_aws/blob/master/images/project_pluralith-local-project%252Frun_0915263%252Frun_0915263_1708381064633.png)
![drawing-app-image](https://github.com/hungvietlai/my-drawing-app/blob/main/images/my_drawing_app.png)