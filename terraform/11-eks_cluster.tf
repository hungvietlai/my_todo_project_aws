resource "aws_eks_cluster" "my_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    endpoint_public_access = true

    subnet_ids = [
      aws_subnet.my_public_subnet1.id,
      aws_subnet.my_private_subnet1.id,
      aws_subnet.my_public_subnet2.id,
      aws_subnet.my_private_subnet2.id
    ]
    security_group_ids = [aws_security_group.eks_sg.id]
  }
}