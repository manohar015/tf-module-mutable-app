# Creates Target Group 
resource "aws_lb_target_group" "app" {
  name     = "${var.COMPONENT}-${var.ENV}"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.VPC_ID

  health_check {
    enabled              = true 
    healthy_threshold    = 2 
    interval             = 5 
    path                 = "/health"
    timeout              = 3 
    unhealthy_threshold  = 2
  }
}

# Enroll Instances to the above target group 
resource "aws_lb_target_group_attachment" "attach-instance" {
  count            = var.SPOT_INSTANCE_COUNT + var.OD_INSTANCE_COUNT
  target_group_arn = aws_lb_target_group.app.arn
  target_id        = element(local.ALL_INSTANCE_IDS, count.index)
  port             = 8080
}


# Generating the random integer for rule ID used by listender rule
resource "random_integer" "rule_number" {
  min = 100
  max = 500
}

# Creates the lister-rule as per the component that we run against.
resource "aws_lb_listener_rule" "app_rule" {
  listener_arn = data.terraform_remote_state.alb.outputs.PRIVATE_LISTERNER_ARN
  priority     = random_integer.rule_number.result

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }

  condition {
    host_header {
      values = ["${var.COMPONENT}-${var.ENV}.${data.terraform_remote_state.vpc.outputs.PUBLIC_HOSTEDZONE_NAME}"]
    }
  }
}