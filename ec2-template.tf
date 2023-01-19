resource "aws_launch_template" "webapp" {
  name = "${var.environment}-${var.launch_template_name}"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.volume_size
      volume_type = var.volume_type
      encrypted   = var.encrypted
    }
  }

  image_id               = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.webapp-instance-sg.id]

  iam_instance_profile {
    name = "${var.environment}-webapp-profile"
  }

  monitoring {
    enabled = true
  }


  metadata_options {
    http_tokens = "required"
  }


  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "${var.environment}-webapp"
      description = "${var.environment} webapp application"
      owner       = var.owner
    }
  }
  user_data = filebase64(var.user_data)
}
