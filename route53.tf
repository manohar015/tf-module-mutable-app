resource "aws_route53_record" "record" {
  zone_id = data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTEDZONE_ID
  name    = "${var.COMPONENT}-${var.ENV}.${data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTEDZONE_NAME}"
  type    = "CNAME"
  ttl     = 10
  records = var.LB_TYPE  [data.terraform_remote_state.alb.outputs.PRIVATE_ALB_ADDRESS]
}


# LB_TYPE = internal : internal.zone
# LB_TYPE = external : external.zone