resource "null_resource" {
    count       = var.SPOT_INSTANCE_COUNT + var.OD_INSTANCE_COUNT
provisioner "remote-exec" {  
  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = local.ALL_INSTANCE_PRIVATE_IPS
  }

    inline = [
      "ansible-pull -U https://github.com/b50-clouddevops/ansible.git -e COMPONENT=${var.COMPONENT} -e ENV=dev -e APP_VERSION=${var.APP_VERSION} roboshop-pull.yml"
        ]
    }
}