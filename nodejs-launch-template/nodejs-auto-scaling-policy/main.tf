resource "aws_autoscaling_policy" "devops-nodejs-add-servers-autoscaling-policy" {
  name                   = "devops-${var.application}-nodejs-add-servers-autoscaling-policy-${var.environment}"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = var.devops-nodejs-auto-scaling-group-name
}
resource "aws_autoscaling_policy" "devops-nodejs-remove-servers-autoscaling-policy" {
  name                   = "devops-${var.application}-nodejs-remove-servers-autoscaling-policy-${var.environment}"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = var.devops-nodejs-auto-scaling-group-name
}