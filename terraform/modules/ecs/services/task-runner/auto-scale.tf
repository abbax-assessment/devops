# Auto Scaling
resource "aws_appautoscaling_target" "service" {
  min_capacity       = var.task_definition.autoscale.min_capacity
  max_capacity       = var.task_definition.autoscale.max_capacity
  resource_id        = "service/${var.ecs_cluster_name}/${aws_ecs_service.this.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "scale_cpu" {
  name               = "${local.service_prefix}-cpu-scale"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.service.resource_id
  scalable_dimension = aws_appautoscaling_target.service.scalable_dimension
  service_namespace  = aws_appautoscaling_target.service.service_namespace

  step_scaling_policy_configuration {
    adjustment_type = "PercentChangeInCapacity"
    metric_aggregation_type = "Average"
    min_adjustment_magnitude = 2
    step_adjustment {
      metric_interval_lower_bound = 60
      scaling_adjustment          = 25
    }

    step_adjustment {
      metric_interval_upper_bound = 60
      scaling_adjustment          = -25
    }
  }
}

resource "aws_appautoscaling_policy" "scale_memory" {
  name               = "${local.service_prefix}-memory-scale"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.service.resource_id
  scalable_dimension = aws_appautoscaling_target.service.scalable_dimension
  service_namespace  = aws_appautoscaling_target.service.service_namespace

  step_scaling_policy_configuration {
    adjustment_type = "PercentChangeInCapacity"
    metric_aggregation_type = "Average"
    min_adjustment_magnitude = 2
    step_adjustment {
      metric_interval_lower_bound = 60
      scaling_adjustment          = 25
    }

    step_adjustment {
      metric_interval_upper_bound = 60
      scaling_adjustment          = -25
    }
  }
}


resource "aws_cloudwatch_metric_alarm" "cpu_high_alarm" {
  alarm_name          = "${local.service_prefix}-cpu-high-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 60
  alarm_description   = "Trigger scale-out when CPU exceeds 60%."
  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = aws_ecs_service.this.name
  }
  alarm_actions = [aws_appautoscaling_policy.scale_cpu.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_low_alarm" {
  alarm_name          = "${local.service_prefix}-cpu-low-alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 60
  alarm_description   = "Trigger scale-in when CPU exceeds 40%."
  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = aws_ecs_service.this.name
  }
  alarm_actions = [aws_appautoscaling_policy.scale_cpu.arn]
}

resource "aws_cloudwatch_metric_alarm" "memory_high_alarm" {
  alarm_name          = "${local.service_prefix}-memory-high-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 60
  alarm_description   = "Trigger scale-out when RAN exceeds 60%."
  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = aws_ecs_service.this.name
  }
  alarm_actions = [aws_appautoscaling_policy.scale_memory.arn]
}

resource "aws_cloudwatch_metric_alarm" "memory_low_alarm" {
  alarm_name          = "${local.service_prefix}-memory-low-alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 60
  alarm_description   = "Trigger scale-in when memory exceeds 40%."
  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = aws_ecs_service.this.name
  }
  alarm_actions = [aws_appautoscaling_policy.scale_memory.arn]
}