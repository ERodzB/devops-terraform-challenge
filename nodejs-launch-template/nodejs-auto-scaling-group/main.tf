resource "aws_autoscaling_group" "devops-nodejs-auto-scaling-group"{
    name = "devops-${var.application}-auto-scaling-group-${var.environment}"
    max_size = 5
    min_size = 1
    desired_capacity = 4
    health_check_grace_period = 120
    launch_configuration = var.devops-nodejs-launch-template-name
    vpc_zone_identifier = [var.devops-public-subnet-a-id,var.devops-public-subnet-b-id]
    target_group_arns = [var.devops-nodejs-instances-target-group-arn]
}