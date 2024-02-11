resource "aws_iam_role" "eks_worker_node" {
  name = "eks_worker_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_worker_node.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_worker_node.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_regigtry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_worker_node.name
}

resource "aws_iam_role_policy_attachment" "my_secret_policy_attachment" {
  policy_arn = aws_iam_policy.my_secret_policy.arn
  role = aws_iam_role.eks_worker_node.name
}

resource "aws_iam_instance_profile" "eks_worker_instance_profile" {
  name = "eks_worker_instance_profile"
  role = aws_iam_role.eks_worker_node.name
}

