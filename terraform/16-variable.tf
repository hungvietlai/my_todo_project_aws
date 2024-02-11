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

variable "subnet2_cidr" {
  type        = list(string)
  default     = ["192.168.2.0/24", "192.168.3.0/24"]
  description = "A list of CIDR blocks for the subnets2 in the EKS cluster."
}
variable "subnet_AZ" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  description = "A list of availability zones for the subnets in the EKS cluster."
}

variable "cluster_name" {
  type        = string
  default     = "my-todo-app-cluster"
  description = "The name for the EKS cluster"
}

variable "instance_types" {
  type        = string
  default     = "t2.micro"
  description = "The instance type to use for the EKS worker nodes."
}

variable "desired_size" {
  type        = number
  default     = 3
  description = "The desired number of worker nodes in the EKS cluster."
}

variable "max_size" {
  type        = number
  default     = 4
  description = "The maximum number of worker nodes in the EKS cluster."
}

variable "min_size" {
  type        = number
  default     = 3
  description = "The minimum number of worker nodes in the EKS cluster."

}