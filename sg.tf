# Creates security group
resource "aws_security_group" "allow_app" {
  name        = "roboshop-${var.COMPONENT}-${var.ENV}"
  description ="roboshop-${var.COMPONENT}-${var.ENV}"

  ingress {
    description      = "Application Port"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_${var.COMPONENT}"
  }
}

