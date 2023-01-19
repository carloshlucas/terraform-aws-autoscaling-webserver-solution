resource "aws_lb_target_group" "webapp" {
  name                 = "${var.environment}-${var.target_name}"
  target_type          = var.target_type
  port                 = var.target_port
  protocol             = var.target_protocol
  vpc_id               = var.vpc_id
  deregistration_delay = var.target_deregistration_delay
  health_check {
    enabled = var.target_healthy_check
    matcher = var.target_matcher
    path    = var.target_path
  }

}