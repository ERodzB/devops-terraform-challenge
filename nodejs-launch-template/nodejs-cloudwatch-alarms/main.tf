resource "aws_cloudwatch_metric_alarm" "devops-nodejs-add-servers-cloudwatch-alarm" {
  alarm_name          = "devops-${var.application}-nodejs-add-servers-cloudwatch-alarm-${var.environment}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "CPUUtilization"
  statistic           = "Average"
  evaluation_periods  = 3
  period              = "60"
  namespace           = "AWS/EC2"
  threshold           = "60"
  dimensions = {
    AutoScalingGroupName = var.devops-nodejs-auto-scaling-group-name
  }
  alarm_actions = [var.devops-nodejs-add-servers-autoscaling-policy-arn]
}
resource "aws_cloudwatch_metric_alarm" "devops-nodejs-remove-servers-cloudwatch-alarm" {
  alarm_name          = "devops-${var.application}-nodejs-remove-servers-cloudwatch-alarm-${var.environment}"
  comparison_operator = "LessThanOrEqualToThreshold"
  metric_name         = "CPUUtilization"
  statistic           = "Average"
  evaluation_periods  = 3
  period              = "60"
  namespace           = "AWS/EC2"
  threshold           = "10"
  dimensions = {
    AutoScalingGroupName = var.devops-nodejs-auto-scaling-group-name
  }
  alarm_actions = [var.devops-nodejs-remove-servers-autoscaling-policy-arn]
}