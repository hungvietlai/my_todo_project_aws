resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.todo_app_vpc.id

  tags = {
    Name = "main"
  }
}