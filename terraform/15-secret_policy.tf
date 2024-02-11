resource "aws_iam_policy" "my_secret_policy" {
  name        = "MySecretsManagerAccessPolicy"
  description = "Policy to access specific secrets in AWS Secrets Manager"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
        ],
        "Effect"   : "Allow",
        "Resource" : "arn:aws:secretsmanager:us-east-1:906734544038:secret:todo_app_mysql-toS3Fo"
      },
    ]
  })
}