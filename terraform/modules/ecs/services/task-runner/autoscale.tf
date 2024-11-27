# Auto Scaling
resource "aws_appautoscaling_target" "service" {
  min_capacity       = var.task_definition.autoscale.min_capacity
  max_capacity       = var.task_definition.autoscale.max_capacity
  resource_id        = "service/${var.ecs_cluster_name}/${aws_ecs_service.this.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "cpu_scale_out" {
  name               = "${local.service_prefix}-scale-out-cpu"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.service.resource_id
  scalable_dimension = aws_appautoscaling_target.service.scalable_dimension
  service_namespace  = aws_appautoscaling_target.service.service_namespace

  step_scaling_policy_configuration {
    adjustment_type          = "PercentChangeInCapacity"
    metric_aggregation_type  = "Average"
    min_adjustment_magnitude = 2

    step_adjustment {
      metric_interval_upper_bound = 40
      scaling_adjustment          = 25
    }

    step_adjustment {
      metric_interval_lower_bound = 40
      metric_interval_upper_bound = 80
      scaling_adjustment          = 25
    }

    step_adjustment {
      metric_interval_lower_bound = 80
      scaling_adjustment          = 50
    }

  }
}

resource "aws_appautoscaling_policy" "cpu_scale_in" {
  name               = "${local.service_prefix}-scale-in-cpu"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.service.resource_id
  scalable_dimension = aws_appautoscaling_target.service.scalable_dimension
  service_namespace  = aws_appautoscaling_target.service.service_namespace

  step_scaling_policy_configuration {
    adjustment_type          = "PercentChangeInCapacity"
    metric_aggregation_type  = "Average"
    min_adjustment_magnitude = 2

    step_adjustment {
      metric_interval_upper_bound = 40
      scaling_adjustment          = -25
    }

    step_adjustment {
      metric_interval_lower_bound = 40
      metric_interval_upper_bound = 80
      scaling_adjustment          = -25
    }

    step_adjustment {
      metric_interval_lower_bound = 80
      scaling_adjustment          = -50
    }
  }
}

resource "aws_appautoscaling_policy" "memory_scale_out" {
  name               = "${local.service_prefix}-scale-out-memory"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.service.resource_id
  scalable_dimension = aws_appautoscaling_target.service.scalable_dimension
  service_namespace  = aws_appautoscaling_target.service.service_namespace

  step_scaling_policy_configuration {
    adjustment_type          = "PercentChangeInCapacity"
    metric_aggregation_type  = "Average"
    min_adjustment_magnitude = 2

    step_adjustment {
      metric_interval_upper_bound = 40
      scaling_adjustment          = 25
    }

    step_adjustment {
      metric_interval_lower_bound = 40
      metric_interval_upper_bound = 80
      scaling_adjustment          = 25
    }

    step_adjustment {
      metric_interval_lower_bound = 80
      scaling_adjustment          = 50
    }

  }
}

resource "aws_appautoscaling_policy" "memory_scale_in" {
  name               = "${local.service_prefix}-scale-in-memory"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.service.resource_id
  scalable_dimension = aws_appautoscaling_target.service.scalable_dimension
  service_namespace  = aws_appautoscaling_target.service.service_namespace

  step_scaling_policy_configuration {
    adjustment_type          = "PercentChangeInCapacity"
    metric_aggregation_type  = "Average"
    min_adjustment_magnitude = 2

    step_adjustment {
      metric_interval_upper_bound = 40
      scaling_adjustment          = -25
    }

    step_adjustment {
      metric_interval_lower_bound = 40
      metric_interval_upper_bound = 80
      scaling_adjustment          = -25
    }

    step_adjustment {
      metric_interval_lower_bound = 80
      scaling_adjustment          = -50
    }

  }
}


resource "aws_cloudwatch_metric_alarm" "cpu_scale_out" {
  alarm_name          = "${local.service_prefix}-cpu-scale-out-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 60
  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = aws_ecs_service.this.name

  }

  alarm_actions = [aws_appautoscaling_policy.cpu_scale_out.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_scale_in" {
  alarm_name          = "${local.service_prefix}-cpu-scale-in-alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 40
  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = aws_ecs_service.this.name
  }
  alarm_actions = [aws_appautoscaling_policy.cpu_scale_in.arn]
}

resource "aws_cloudwatch_metric_alarm" "memory_scale_out" {
  alarm_name          = "${local.service_prefix}-memory-scale-out-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 60
  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = aws_ecs_service.this.name
  }
  alarm_actions = [aws_appautoscaling_policy.memory_scale_out.arn]
}

resource "aws_cloudwatch_metric_alarm" "memory_scale_in" {
  alarm_name          = "${local.service_prefix}-memory-scale-in-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 40
  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = aws_ecs_service.this.name
  }
  alarm_actions = [aws_appautoscaling_policy.memory_scale_in.arn]
}