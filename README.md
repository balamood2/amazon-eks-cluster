# Amazon EKS Cluster
This repository contains source code to provision an EKS cluster in AWS using Terraform. 

## Prerequisites
* AWS account
* AWS profile configured with CLI on local machine
* [Terraform](https://www.terraform.io/)
* [kubectl](https://kubernetes.io/docs/tasks/tools/)

## Project Structure

```
├── README.md
├── eks
|  ├── cluster.tf
|  ├── cluster_role.tf
|  ├── cluster_sg.tf
|  ├── node_group.tf
|  ├── node_group_role.tf
|  ├── node_sg.tf
|  └── vars.tf
├── main.tf
|-- ec2.tf
|-- security-group.tf
├── provider.tf
├── variables.tf
└── vpc
   ├── control_plane_sg.tf
   ├── data_plane_sg.tf
   ├── nat_gw.tf
   ├── output.tf
   ├── public_sg.tf
   ├── vars.tf
   └── vpc.tf
```

## Remote Backend State Configuration
To configure remote backend state for your infrastructure, create an S3 bucket and DynamoDB table before running *terraform init*. In the case that you want to use local state persistence, update the *provider.tf* accordingly and don't bother with creating an S3 bucket and DynamoDB table.

### Create S3 Bucket for State Backend
```aws s3api create-bucket --bucket <bucket-name> --region <region> --create-bucket-configuration LocationConstraint=<region>```

### Create DynamoDB table for State Locking
```aws dynamodb create-table --table-name <table-name> --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1```

## Provision Infrastructure
Review the *main.tf* to update the node size configurations (i.e. desired, maximum, and minimum). When you're ready, run the following commands:
1. `terraform init` - Initialize the project, setup the state persistence (whether local or remote) and download the API plugins.
2. `terraform plan` - Print the plan of the desired state without changing the state.
3. `terraform apply` - Print the desired state of infrastructure changes with the option to execute the plan and provision. 

## Connect To Cluster
Using the same AWS account profile that provisioned the infrastructure, you can connect to your cluster by updating your local kube config with the following command:
`aws eks --region <aws-region> update-kubeconfig --name <cluster-name>`


