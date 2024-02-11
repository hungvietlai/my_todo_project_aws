resource "aws_vpc" "todo_app_vpc" {
  cidr_block = var.vpc_cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true

  instance_tenancy = "default"

  tags = {
    Name = "todo_app_vpc"
  }
}