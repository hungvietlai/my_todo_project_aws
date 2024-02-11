resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "my-node-group"
  node_role_arn   = aws_iam_role.eks_worker_node.arn
  subnet_ids      = [aws_subnet.my_private_subnet1.id, aws_subnet.my_private_subnet2.id]

  instance_types = [var.instance_types]

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }
}