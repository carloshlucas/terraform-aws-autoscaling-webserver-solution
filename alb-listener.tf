resource "aws_lb_listener" "front_end" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.alb_listener_port
  protocol          = var.alb_listener_protocol

  default_action {
    type             = var.alb_default_action_type
    target_group_arn = aws_lb_target_group.webapp.arn
  }
}