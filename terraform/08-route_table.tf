resource "aws_route_table" "public" {
  vpc_id = aws_vpc.todo_app_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "public"
  }
}

resource "aws_route_table" "private1" {
  vpc_id = aws_vpc.todo_app_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw1.id
  }
  tags = {
    Name = "private1"
  }

}

resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.todo_app_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw2.id
  }
  tags = {
    Name = "private2"
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.my_public_subnet1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.my_public_subnet2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.my_private_subnet1.id
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.my_private_subnet2.id
  route_table_id = aws_route_table.private2.id
}