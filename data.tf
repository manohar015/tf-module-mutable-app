# To read the data from the VPC state file
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "b50-tf-state-bucket"
    key    = "vpc/${var.ENV}/terrafom.tfstate"
    region = "us-east-1"
  }
}

# To read the data from the ALB state file
data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    bucket = "b50-tf-state-bucket"
    key    = "alb/${var.ENV}/terrafom.tfstate"
    region = "us-east-1"
  }
}