# Creates spot instances
resource "aws_spot_instance_request" "spot" {
  count                     = var.SPOT_INSTANCE_COUNT  
  ami                       = data.aws_ami.my_ami.id
  instance_type             = var.INSTANCE_TYPE
  wait_for_fulfillment      = true 
  vpc_security_group_ids    = [aws_security_group.allow_ssh.id]
  subnet_id                 = element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS, count.index)

  tags = {
    Name = "${var.COMPONENT}-${var.ENV}"
  }
}


# Creates On-Demand Servers
resource "aws_instance" "od" {
  count                     = var.OD_INSTANCE_COUNT 
  ami                       = data.aws_ami.my_ami.id
  instance_type             = var.INSTANCE_TYPE
  vpc_security_group_ids    = [aws_security_group.allow_app.id]

  tags     = {
    Name = "${var.COMPONENT}-${var.ENV}"
  }
}


# provisioner "remote-exec" {
  
#   # Connection Provisioner
#   connection {
#     type     = "ssh"
#     user     = "centos"
#     password = "DevOps321"
#     host     = self.public_ip
#   }

#     inline = [
#       "ansible-pull -U https://github.com/b50-clouddevops/ansible.git -e COMPONENT=${var.COMPONENT} -e ENV=dev -e APP_VERSION=${var.APP_VERSION} roboshop-pull.yml"
#     ]
#   }

