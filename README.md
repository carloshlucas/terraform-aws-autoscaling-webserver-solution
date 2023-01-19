# AWS Web Server Solution - Autoscaling Group - AWS Template - Security Group - ALB Listener - Target Group

This repositiory contains a set of Terraform scripts that deploy a Webserver Solution in High Availability using Auto Scaling Group.

---
## Prerequisities

This repository only covers the Autoscaling Group creation and the integration with Bitbucket Pipeline for AWS Multi-Account. There are some resources that need to be created beforehand.

This repository only covers the Autoscaling Group creation and the integration with Bitbucket Pipeline for AWS Multi-Account. There are some resources that need to be created beforehand.

1. **AWS (Steps)**
    - IAM Users
        - You need to create one IAM user (Programmatic Access is more than enough).

    - Subnets (3 az's)
        - Create 6 subnets and assign one for each Availability Zone.
        - Assign 3 for the public subnet
        - Assign the other 3 for the private subnet

    - Nat Gateway
        - You need a NAT Gateway to provide internet to the instances inside the Private Subnets (Without it the packages cannot be installed and your instances will keep rebooting). Don't forget to add the Nat Gateway to the right route table.

    - Application Load Balancer
        - Create or reuse you application LB (It is required to create the listener inside it)
        - Security Group must allow communication from your IP or anywhere.

# Instructions

  - Create a file called script.sh with these lines below inside:
    ```bash
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y httpd.x86_64
    sudo systemctl start httpd.service
    sudo systemctl enable httpd.service
    sudo echo “Hello World from Terraform module $(hostname -f)” > /var/www/html/index.html
    ```
  - Create a file called main.tf (copy and paste) the code below to this file.
    - The fields below can be changed accordingly to your needs.

  ```hcl

  module "asg" {
  source = "git::https://github.com/carloshlucas/terraform-aws-autoscaling-webserver-solution.git"

  ### General

  region = "us-east-1"
  environment = "tst"


  ### Autoscaling Group

  asg_name                      = "asg-webapp"
  asg_monitoring                = true
  asg_desired_capacity          = 2
  asg_min_size                  = 2
  asg_max_size                  = 3
  asg_wait_for_elb_capacity     = 2
  asg_termination_policies      = "OldestInstance"
  asg_health_check_type         = "ELB"
  asg_default_instance_warmup   = 120
  asg_instance_refresh_strategy = "Rolling"
  asg_min_healthy_percentage    = 50
  asg_policy_type                   = "TargetTrackingScaling"
  asg_policy_predifined_metric_type = "ASGAverageCPUUtilization"
  asg_policy_taget_value            = 10


  ### Template

  launch_template_name = "template-01"
  ami                  = "ami-09d3b3274b6c5d4aa"
  instance_type        = "t2.micro"
  user_data            = "script.sh" # <= change this line to your path


  ### Target Group

  target_name                 = "target-webapp"
  target_type                 = "instance"
  target_port                 = 80
  target_protocol             = "HTTP"
  target_deregistration_delay = 60
  target_healthy_check        = "true"
  target_matcher              = 200
  target_path                 = "/"


  ### Storage

  volume_size = 8
  volume_type = "gp2"
  encrypted   = true

  ### Networking

  vpc_id                  = "vpc-0ce27725a217bbd6a"                 # <= change this line to your VPC
  subnetid_aza            = "subnet-067fef067bf73f012"              # <= change this line to your Private Subnet ID
  subnetid_azb            = "subnet-0853c6c8eb6225748"              # <= change this line to your Private Subnet ID
  subnetid_azc            = "subnet-0ba643ea5b2a1c931"              # <= change this line to your Private Subnet ID
  load_balancer_arn       = "arn:aws:elasticloadbalancing:us-east-1:788527279176:loadbalancer/app/ddd/1708b51959e4d940"     # <= change this line to your Load Balancer ID
  alb_listener_port       = 80            # <= Port 80 should only be used for learning proposes, if you are taking this environment to production change to 443
  alb_listener_protocol   = "HTTP"        # <= HTTP should only be used for learning proposes, if you are taking this environment to production change to HTTPS
  alb_default_action_type = "forward"

  ### Tags

  owner = "Your Company"
}
```
# Validation
  - Run terraform plan to validate and see what will be created
    ```
    terraform plan
    ```
- Run terraform apply to deploy the infrastructure.
  ```
  terraform apply
  ```
- Test your deployment by copying the ALB DNS Name and paste it to your browser. You should see a message like this:
  ```
  Hello World from Terraform module <EC2 Host Name>
  ```
# Conclusion

This is one way of deploying a two tier webserver solution being managed by a Application Load Balancer via Infra as Code using Terraform.