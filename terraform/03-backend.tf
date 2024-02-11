terraform {
  backend "s3" {
    bucket         = "my-unique-terraform-state-todo-app"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-locks"
  }
}