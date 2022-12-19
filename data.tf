# To read the data from the VPC state file
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "manohar-b50-tf-state-bucket"
    key    = "vpc/${var.ENV}/terrafom.tfstate"
    region = "us-east-1"
  }
}

# To read the data from the ALB state file
data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    bucket = "manohar-b50-tf-state-bucket"
    key    = "alb/${var.ENV}/terrafom.tfstate"
    region = "us-east-1"
  }
}

# To read the data from the ALB state file
data "terraform_remote_state" "db" {
  backend = "s3"
  config = {
    bucket = "manohar-b50-tf-state-bucket"
    key    = "databases/${var.ENV}/terrafom.tfstate"
    region = "us-east-1"
  }
}

# DataSource to search the ami with given criteria.
data "aws_ami" "my_ami" {
  most_recent      = true
  name_regex       = "Boto_Image"
  owners           = ["self"]
}

# Data blocks to retrieve secrets from aws security manager
data "aws_secretsmanager_secret" "secrets" {
  name = "roboshop/secrets"
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}