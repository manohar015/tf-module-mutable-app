resource "aws_route53_record" "record" {
  zone_id = data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTEDZONE_ID
  name    = "${var.COMPONENT}-dev.roboshop.internal"
  type    = "CNAME"
  ttl     = 10
  records = [data.terraform_remote_state.alb.outputs.PRIVATE_ALB_ADDRESS]

}


internal-roboshop-private-316722189.us-east-1.elb.amazonaws.com   --->   cart-dev.roboshop.internal 