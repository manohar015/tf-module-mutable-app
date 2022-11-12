resource "null_resource" "application_deploy" {
    triggers = {
        # versionn = var.APP_VERSION
          timestamp = timestamp()
    }
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


# Note: Provisioners by default are create time provisioners, which means only during the creation they will run. When you run it again for the second time, they won't run. But here in our case, it's an application deployer, which has to run irrespective of the success/failure/partial state of the previous run.

# The timestamp() function in the interpolation syntax will return an ISO 8601 formatted string, which looks like this 2019-02-06T23:22:28Z .