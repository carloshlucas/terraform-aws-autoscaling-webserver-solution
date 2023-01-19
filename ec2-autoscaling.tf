resource "aws_autoscaling_group" "asg" {
  name                    = "${var.environment}-${var.asg_name}"
  desired_capacity        = var.asg_desired_capacity
  min_size                = var.asg_min_size
  max_size                = var.asg_max_size
  termination_policies    = [var.asg_termination_policies]
  default_instance_warmup = var.asg_default_instance_warmup
  wait_for_elb_capacity   = var.asg_wait_for_elb_capacity
  health_check_type       = var.asg_health_check_type
  vpc_zone_identifier     = [var.subnetid_aza, var.subnetid_azb, var.subnetid_azc]
  target_group_arns       = [aws_lb_target_group.webapp.id]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.webapp.id
        version            = aws_launch_template.webapp.latest_version
      }
    }
  }

  instance_refresh {
    strategy = var.asg_instance_refresh_strategy
    preferences {
      min_healthy_percentage = var.asg_min_healthy_percentage
    }
  }

}
resource "aws_autoscaling_policy" "asg_policy" {
  name                   = "${var.environment}-${var.asg_name}-policy"
  autoscaling_group_name = aws_autoscaling_group.asg.id
  policy_type            = var.asg_policy_type
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.asg_policy_predifined_metric_type
    }

    target_value = var.asg_policy_taget_value
  }
}
