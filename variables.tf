### GENERAL

variable "region" {
  type        = string
  description = "Which zone you want to deploy"
  default     = ""
}

variable "environment" {
  type        = string
  description = "Environment"
  default     = ""
}

### AUTOSCALING GROUP

variable "asg_name" {
  type        = string
  description = "Name of Instance prefix"
  default     = ""
}

variable "asg_health_check_type" {
  type        = string
  description = "Health check instance type EC2 or ELB"
  default     = ""
}

variable "asg_monitoring" {
  type        = string
  description = "Enable the basic monitoring"
  default     = ""
}

variable "asg_desired_capacity" {
  type        = number
  description = "The amount of EC2 Instances desired"
  default     = null
}

variable "asg_min_size" {
  type        = number
  description = "The minimum Instances desired"
  default     = null
}

variable "asg_max_size" {
  type        = number
  description = "The minimum Instances desired"
  default     = null
}

variable "asg_termination_policies" {
  type        = string
  description = "A list of policies to decide how the instances in the Auto Scaling Group should be terminated. The allowed values are `OldestInstance`, `NewestInstance`, `OldestLaunchConfiguration`, `ClosestToNextInstanceHour`, `OldestLaunchTemplate`, `AllocationStrategy`, `Default`"
  default     = ""
}

variable "asg_default_instance_warmup" {
  type        = number
  description = "The amount of time, in seconds, until a newly launched instance can contribute to the Amazon CloudWatch metrics."
  default     = null
}
variable "asg_wait_for_elb_capacity" {
  type        = number
  description = "Terraform to wait for exactly this number of healthy instances from this Auto Scaling Group"
  default     = null

}

variable "asg_instance_refresh_strategy" {
  type        = string
  description = "Terraform to wait for exactly this number of healthy instances from this Auto Scaling Group"
  default     = ""

}

variable "asg_min_healthy_percentage" {
  type        = number
  description = "Terraform to wait for exactly this number of healthy instances from this Auto Scaling Group"
  default     = null

}

variable "asg_policy_type" {
  type        = string
  description = "i.e. TargetTrackingScaling"
  default     = ""

}


variable "asg_policy_predifined_metric_type" {
  type        = string
  description = "i.e. ASGAverageCPUUtilization"
  default     = ""

}

variable "asg_policy_taget_value" {
  type        = number
  description = "he target value represents the optimal average utilization or throughput for the Auto Scaling group"
  default     = null

}

### TEMPLATE

variable "launch_template_name" {
  type        = string
  description = "Create a template used for EC2 instances"
  default     = ""
}

variable "ami" {
  type        = string
  description = "Can be imported using the ID of the AMI"
  default     = ""
}

variable "instance_type" {
  type        = string
  description = "Instance type e.g. t2.micro"
  default     = ""
}

variable "user_data" {
  type        = string
  description = "ARN of the Application Load Balancer"
  default     = ""
}

### STORAGE

variable "volume_size" {
  type        = string
  description = "Size of the volume in gibibytes (GiB)"
  default     = ""
}

variable "volume_type" {
  type        = string
  description = "Type of volume. Valid values include standard, gp2, gp3, io1, io2, sc1, or st1"
  default     = ""
}

variable "encrypted" {
  type        = string
  description = "Whether to enable volume encryption"
  default     = ""
}

### NETWORK

variable "vpc_id" {
  type        = string
  description = "VPC ID"
  default     = ""
}

variable "subnetid_aza" {
  type        = string
  description = "Subnet A"
  default     = ""
}

variable "subnetid_azb" {
  type        = string
  description = "Subnet B"
  default     = ""
}

variable "subnetid_azc" {
  type        = string
  description = "Subnet C"
  default     = ""
}

variable "load_balancer_arn" {
  type        = string
  description = "ARN of the Application Load Balancer"
  default     = ""
}

variable "alb_listener_port" {
  type        = number
  description = "ALB listener port"
  default     = null
}

variable "alb_listener_protocol" {
  type        = string
  description = "ALB listener protocol HTTP or HTTPS"
  default     = ""
}

variable "alb_default_action_type" {
  type        = string
  description = "ALB listener action type i.e forward"
  default     = ""
}

### TARGET GROUP

variable "target_name" {
  type        = string
  description = "Target Group type Instance, Load Balancer"
  default     = ""
}
variable "target_type" {
  type        = string
  description = "Target Group type Instance, Load Balancer"
  default     = "instance"
}

variable "target_port" {
  type        = number
  description = "Target Group Port"
  default     = null
}

variable "target_protocol" {
  type        = string
  description = "Target Group Protocol HTTP or HTTPS"
  default     = ""
}

variable "target_deregistration_delay" {
  type        = number
  description = "Time to wait the instance"
  default     = null
}

variable "target_healthy_check" {
  type        = bool
  description = "Target Group Healthy Check"
  default     = "true"
}

variable "target_matcher" {
  type        = number
  description = "Target Group Matcher"
  default     = null
}

variable "target_path" {
  type        = string
  description = "Target Group Path for example / or /etc/"
  default     = ""
}

### TAGS

variable "owner" {
  type        = string
  description = "Tags"
  default     = ""
}
