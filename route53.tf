resource "aws_route53_record" "record" {
  zone_id = "Z04602961I29SHWLCRCU3"
  name    = "${var.COMPONENT}-dev.roboshop.internal"
  type    = "A"
  ttl     = 10
  records = [aws_spot_instance_request.spot_worker.private_ip]

}