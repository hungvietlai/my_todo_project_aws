resource "aws_subnet" "my_public_subnet1" {
  vpc_id                  = aws_vpc.todo_app_vpc.id
  cidr_block              = var.subnet1_cidr[0]
  availability_zone       = var.subnet_AZ[0]
  map_public_ip_on_launch = true
  tags = {
    Name                                        = "my_public_subnet1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = 1
  }
}

resource "aws_subnet" "my_public_subnet2" {
  vpc_id                  = aws_vpc.todo_app_vpc.id
  cidr_block              = var.subnet2_cidr[0]
  availability_zone       = var.subnet_AZ[1]
  map_public_ip_on_launch = true
  tags = {
    Name                                        = "my_public_subnet2"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = 1
  }
}

resource "aws_subnet" "my_private_subnet1" {
  vpc_id            = aws_vpc.todo_app_vpc.id
  cidr_block        = var.subnet1_cidr[1]
  availability_zone = var.subnet_AZ[0]
  tags = {
    Name                                        = "my_private_subnet1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "my_private_subnet2" {
  vpc_id            = aws_vpc.todo_app_vpc.id
  cidr_block        = var.subnet2_cidr[1]
  availability_zone = var.subnet_AZ[1]

  tags = {
    Name                                        = "my_private_subnet2"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}