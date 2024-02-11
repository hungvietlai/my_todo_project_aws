resource "aws_security_group" "eks_sg" {
  name        = "eks_security_group"
  description = "Security group for EKS cluster"
  vpc_id      = aws_vpc.todo_app_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}