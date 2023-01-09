/* variable "profile" {
  description = "AWS profile"
  type        = string
} */

variable "region" {
  description = "AWS region to deploy to"
  default = "us-east-1"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type = string
  default = "assesment"
}

variable "key_name" {
  description = "PEM formated private key"
  type = string
  default = "bahaa"
  
}

variable "ec2-instance_type" {
  description = "instance type for the jenkins server"
  type = string
  default = "t2.micro"
  
}