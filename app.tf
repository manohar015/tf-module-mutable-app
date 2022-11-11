resource "null_resource" {
    count       = var.SPOT_INSTANCE_COUNT + var.OD_INSTANCE_COUNT
provisioner "remote-exec" {  
  connection {
    type     = "ssh"
    user     = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["SSH_USERNAME"]
    password = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["SSH_PASSWORD"]
    host     = element(local.ALL_INSTANCE_PRIVATE_IPS, count.index)
  }

    inline = [

      "ansible-pull -U https://github.com/b50-clouddevops/ansible.git -e COMPONENT=${var.COMPONENT} -e ENV=dev -e APP_VERSION=${var.APP_VERSION} roboshop-pull.yml"
        ]
    }
}