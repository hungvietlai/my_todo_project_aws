data "aws_secretsmanager_secret_version" "rds_secret" {
  secret_id = "todo_app_mysql"
}


resource "aws_db_instance" "todo_rds_instance" {
  allocated_storage = 20
  storage_type      = "gp2"
  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t2.micro"

  db_name = "my_todo_database"

  username = jsondecode(data.aws_secretsmanager_secret_version.rds_secret.secret_string)["username"]
  password = jsondecode(data.aws_secretsmanager_secret_version.rds_secret.secret_string)["password"]

  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.todo_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  skip_final_snapshot = true
}

resource "aws_db_subnet_group" "todo_db_subnet_group" {
  name       = "my-todo-app-db-subnet-group"
  subnet_ids = [aws_subnet.my_private_subnet1.id, aws_subnet.my_private_subnet2.id]

  tags = {
    Name = "My Todo App DB Subnet Group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds_security_group"
  description = "Security group for RDS instance"
  vpc_id      = aws_vpc.todo_app_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.eks_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

