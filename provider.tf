provider "aws" {
  region = var.region
  #profile = var.profile
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "useast1-aws-eks-cluster-terraform-state"
    key = "useast1-aws-eks-cluster/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "useast1-aws-eks-cluster-tf-state"
    encrypt = true
  }
}