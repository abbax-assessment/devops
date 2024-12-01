{
    "annotations": {
        "list": [
        {
            "builtIn": 1,
            "datasource": {
            "type": "grafana",
            "uid": "-- Grafana --"
            },
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations & Alerts",
            "type": "dashboard"
        }
        ]
    },
    "editable": true,
    "fiscalYearStartMonth": 0,
    "graphTooltip": 0,
    "id": 1,
    "links": [],
    "panels": [
        {
        "collapsed": false,
        "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 0
        },
        "id": 5,
        "panels": [],
        "title": "App Metrics",
        "type": "row"
        },
        {
        "datasource": {
            "type": "cloudwatch",
            "uid": "ae5f4zx8ilukga"
        },
        "fieldConfig": {
            "defaults": {
            "color": {
                "mode": "palette-classic"
            },
            "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 0,
                "gradientMode": "none",
                "hideFrom": {
                "legend": false,
                "tooltip": false,
                "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                "group": "A",
                "mode": "none"
                },
                "thresholdsStyle": {
                "mode": "off"
                }
            },
            "mappings": [],
            "thresholds": {
                "mode": "absolute",
                "steps": [
                {
                    "color": "green",
                    "value": null
                },
                {
                    "color": "red",
                    "value": 80
                }
                ]
            }
            },
            "overrides": []
        },
        "gridPos": {
            "h": 8,
            "w": 7,
            "x": 0,
            "y": 1
        },
        "id": 1,
        "options": {
            "legend": {
            "calcs": [],
            "displayMode": "list",
            "placement": "bottom",
            "showLegend": true
            },
            "tooltip": {
            "mode": "single",
            "sort": "none"
            }
        },
        "targets": [
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "LoadBalancer": "app/tsk-${environment}-api-alb/cb5b2b63d5201880"
            },
            "expression": "",
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": true,
            "metricEditorMode": 0,
            "metricName": "TargetResponseTime",
            "metricQueryType": 0,
            "namespace": "AWS/ApplicationELB",
            "period": "300",
            "queryMode": "Metrics",
            "refId": "A",
            "region": "eu-west-1",
            "sqlExpression": "",
            "statistic": "Average"
            },
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "LoadBalancer": "app/tsk-${environment}-api-alb/cb5b2b63d5201880"
            },
            "expression": "",
            "hide": false,
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": true,
            "metricEditorMode": 0,
            "metricName": "RequestCount",
            "metricQueryType": 0,
            "namespace": "AWS/ApplicationELB",
            "period": "300",
            "queryMode": "Metrics",
            "refId": "B",
            "region": "eu-west-1",
            "sqlExpression": "",
            "statistic": "Sum"
            },
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "LoadBalancer": "app/tsk-${environment}-api-alb/cb5b2b63d5201880"
            },
            "expression": "",
            "hide": false,
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": true,
            "metricEditorMode": 0,
            "metricName": "UnHealthyHostCount",
            "metricQueryType": 0,
            "namespace": "AWS/ApplicationELB",
            "period": "300",
            "queryMode": "Metrics",
            "refId": "C",
            "region": "eu-west-1",
            "sqlExpression": "",
            "statistic": "Sum"
            }
        ],
        "title": "Load Balancer Metrics",
        "type": "timeseries"
        },
        {
        "datasource": {
            "type": "cloudwatch",
            "uid": "ae5f4zx8ilukga"
        },
        "fieldConfig": {
            "defaults": {
            "color": {
                "mode": "palette-classic"
            },
            "custom": {
                "hideFrom": {
                "legend": false,
                "tooltip": false,
                "viz": false
                }
            },
            "mappings": []
            },
            "overrides": []
        },
        "gridPos": {
            "h": 8,
            "w": 7,
            "x": 7,
            "y": 1
        },
        "id": 2,
        "options": {
            "legend": {
            "displayMode": "list",
            "placement": "bottom",
            "showLegend": true
            },
            "pieType": "pie",
            "reduceOptions": {
            "calcs": [
                "lastNotNull"
            ],
            "fields": "",
            "values": false
            },
            "tooltip": {
            "mode": "single",
            "sort": "none"
            }
        },
        "targets": [
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "LoadBalancer": "app/tsk-${environment}-api-alb/cb5b2b63d5201880"
            },
            "expression": "",
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": true,
            "metricEditorMode": 0,
            "metricName": "HTTPCode_Target_2XX_Count",
            "metricQueryType": 0,
            "namespace": "AWS/ApplicationELB",
            "period": "",
            "queryMode": "Metrics",
            "refId": "A",
            "region": "eu-west-1",
            "sqlExpression": "",
            "statistic": "Sum"
            },
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "LoadBalancer": "app/tsk-${environment}-api-alb/cb5b2b63d5201880"
            },
            "expression": "",
            "hide": false,
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": true,
            "metricEditorMode": 0,
            "metricName": "HTTPCode_ELB_4XX_Count",
            "metricQueryType": 0,
            "namespace": "AWS/ApplicationELB",
            "period": "",
            "queryMode": "Metrics",
            "refId": "B",
            "region": "eu-west-1",
            "sqlExpression": "",
            "statistic": "Sum"
            },
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "LoadBalancer": "app/tsk-${environment}-api-alb/cb5b2b63d5201880"
            },
            "expression": "",
            "hide": false,
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": true,
            "metricEditorMode": 0,
            "metricName": "HTTPCode_ELB_5XX_Count",
            "metricQueryType": 0,
            "namespace": "AWS/ApplicationELB",
            "period": "",
            "queryMode": "Metrics",
            "refId": "C",
            "region": "eu-west-1",
            "sqlExpression": "",
            "statistic": "Sum"
            }
        ],
        "title": "Code Rates 2xx/4xx/5xx",
        "type": "piechart"
        },
        {
        "datasource": {
            "type": "cloudwatch",
            "uid": "ae5f4zx8ilukga"
        },
        "description": "",
        "fieldConfig": {
            "defaults": {
            "color": {
                "mode": "palette-classic"
            },
            "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 0,
                "gradientMode": "none",
                "hideFrom": {
                "legend": false,
                "tooltip": false,
                "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                "group": "A",
                "mode": "none"
                },
                "thresholdsStyle": {
                "mode": "off"
                }
            },
            "mappings": [],
            "thresholds": {
                "mode": "absolute",
                "steps": [
                {
                    "color": "green",
                    "value": null
                },
                {
                    "color": "red",
                    "value": 80
                }
                ]
            }
            },
            "overrides": []
        },
        "gridPos": {
            "h": 8,
            "w": 10,
            "x": 14,
            "y": 1
        },
        "id": 3,
        "options": {
            "legend": {
            "calcs": [],
            "displayMode": "list",
            "placement": "bottom",
            "showLegend": true
            },
            "tooltip": {
            "mode": "single",
            "sort": "none"
            }
        },
        "targets": [
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "QueueName": "tsk-${environment}-tasks"
            },
            "expression": "",
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": true,
            "metricEditorMode": 0,
            "metricName": "NumberOfMessagesSent",
            "metricQueryType": 0,
            "namespace": "AWS/SQS",
            "period": "300",
            "queryMode": "Metrics",
            "refId": "A",
            "region": "eu-west-1",
            "sqlExpression": "",
            "statistic": "Sum"
            },
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "QueueName": "tsk-${environment}-tasks"
            },
            "expression": "",
            "hide": false,
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": true,
            "metricEditorMode": 0,
            "metricName": "NumberOfMessagesReceived",
            "metricQueryType": 0,
            "namespace": "AWS/SQS",
            "period": "300",
            "queryMode": "Metrics",
            "refId": "B",
            "region": "eu-west-1",
            "sqlExpression": "",
            "statistic": "Sum"
            },
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "QueueName": "tsk-${environment}-tasks-dead-letter-queue"
            },
            "expression": "",
            "hide": false,
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": true,
            "metricEditorMode": 0,
            "metricName": "NumberOfMessagesSent",
            "metricQueryType": 0,
            "namespace": "AWS/SQS",
            "period": "300",
            "queryMode": "Metrics",
            "refId": "C",
            "region": "eu-west-1",
            "sqlExpression": "",
            "statistic": "Sum"
            },
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "QueueName": "tsk-${environment}-tasks-dead-letter-queue"
            },
            "expression": "",
            "hide": false,
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": true,
            "metricEditorMode": 0,
            "metricName": "NumberOfMessagesReceived",
            "metricQueryType": 0,
            "namespace": "AWS/SQS",
            "period": "300",
            "queryMode": "Metrics",
            "refId": "D",
            "region": "eu-west-1",
            "sqlExpression": "",
            "statistic": "Sum"
            }
        ],
        "title": "SQS Tasks-Queue",
        "type": "timeseries"
        },
        {
        "datasource": {
            "type": "grafana-x-ray-datasource",
            "uid": "ee5f6qbuqrn5sc"
        },
        "fieldConfig": {
            "defaults": {
            "mappings": [],
            "thresholds": {
                "mode": "absolute",
                "steps": [
                {
                    "color": "green",
                    "value": null
                }
                ]
            },
            "unit": "short"
            },
            "overrides": []
        },
        "gridPos": {
            "h": 8,
            "w": 7,
            "x": 0,
            "y": 9
        },
        "id": 4,
        "options": {
            "colorMode": "value",
            "graphMode": "area",
            "justifyMode": "auto",
            "orientation": "auto",
            "reduceOptions": {
            "calcs": [
                "lastNotNull"
            ],
            "fields": "",
            "values": false
            },
            "showPercentChange": false,
            "textMode": "auto",
            "wideLayout": true
        },
        "pluginVersion": "10.4.1",
        "targets": [
            {
            "columns": [],
            "datasource": {
                "type": "grafana-x-ray-datasource",
                "uid": "ee5f6qbuqrn5sc"
            },
            "group": {
                "GroupARN": "arn:aws:xray:eu-west-1:569985934894:group/Default",
                "GroupName": "Default",
                "InsightsConfiguration": {
                "InsightsEnabled": false,
                "NotificationsEnabled": false
                }
            },
            "query": "",
            "queryType": "getTimeSeriesServiceStatistics",
            "refId": "A",
            "region": "eu-west-1"
            }
        ],
        "title": "Traces",
        "type": "stat"
        },
        {
        "datasource": {
            "type": "cloudwatch",
            "uid": "ae5f4zx8ilukga"
        },
        "fieldConfig": {
            "defaults": {
            "color": {
                "mode": "palette-classic"
            },
            "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 0,
                "gradientMode": "none",
                "hideFrom": {
                "legend": false,
                "tooltip": false,
                "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                "group": "A",
                "mode": "none"
                },
                "thresholdsStyle": {
                "mode": "off"
                }
            },
            "mappings": [],
            "thresholds": {
                "mode": "absolute",
                "steps": [
                {
                    "color": "green",
                    "value": null
                },
                {
                    "color": "red",
                    "value": 80
                }
                ]
            }
            },
            "overrides": []
        },
        "gridPos": {
            "h": 4,
            "w": 8,
            "x": 7,
            "y": 9
        },
        "id": 18,
        "options": {
            "legend": {
            "calcs": [],
            "displayMode": "list",
            "placement": "right",
            "showLegend": true
            },
            "tooltip": {
            "mode": "single",
            "sort": "none"
            }
        },
        "pluginVersion": "10.4.1",
        "targets": [
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "ServiceName": "tsk-${environment}-api-svc"
            },
            "expression": "",
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": false,
            "metricEditorMode": 0,
            "metricName": "DesiredTaskCount",
            "metricQueryType": 0,
            "namespace": "ECS/ContainerInsights",
            "period": "60",
            "queryMode": "Metrics",
            "refId": "A",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Maximum"
            },
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "ServiceName": "tsk-${environment}-api-svc"
            },
            "expression": "",
            "hide": false,
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": false,
            "metricEditorMode": 0,
            "metricName": "RunningTaskCount",
            "metricQueryType": 0,
            "namespace": "ECS/ContainerInsights",
            "period": "60",
            "queryMode": "Metrics",
            "refId": "B",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Maximum"
            }
        ],
        "title": "ECS - API Server Tasks",
        "type": "timeseries"
        },
        {
        "datasource": {
            "type": "cloudwatch",
            "uid": "ae5f4zx8ilukga"
        },
        "fieldConfig": {
            "defaults": {
            "mappings": [],
            "thresholds": {
                "mode": "absolute",
                "steps": [
                {
                    "color": "green",
                    "value": null
                },
                {
                    "color": "red",
                    "value": 80
                }
                ]
            },
            "unit": "short"
            },
            "overrides": []
        },
        "gridPos": {
            "h": 8,
            "w": 4,
            "x": 15,
            "y": 9
        },
        "id": 20,
        "options": {
            "colorMode": "value",
            "graphMode": "area",
            "justifyMode": "auto",
            "orientation": "auto",
            "reduceOptions": {
            "calcs": [
                "lastNotNull"
            ],
            "fields": "",
            "values": false
            },
            "showPercentChange": false,
            "textMode": "auto",
            "wideLayout": true
        },
        "pluginVersion": "10.4.1",
        "targets": [
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "AvailabilityZone": "eu-west-1a",
                "LoadBalancer": "app/tsk-${environment}-api-alb/cb5b2b63d5201880"
            },
            "expression": "",
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": true,
            "metricEditorMode": 0,
            "metricName": "ActiveConnectionCount",
            "metricQueryType": 0,
            "namespace": "AWS/ApplicationELB",
            "period": "300",
            "queryMode": "Metrics",
            "refId": "A",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Sum"
            },
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "AvailabilityZone": "eu-west-1b",
                "LoadBalancer": "app/tsk-${environment}-api-alb/cb5b2b63d5201880"
            },
            "expression": "",
            "hide": false,
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": true,
            "metricEditorMode": 0,
            "metricName": "ActiveConnectionCount",
            "metricQueryType": 0,
            "namespace": "AWS/ApplicationELB",
            "period": "300",
            "queryMode": "Metrics",
            "refId": "B",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Sum"
            }
        ],
        "title": "Active Connections",
        "type": "stat"
        },
        {
        "datasource": {
            "type": "cloudwatch",
            "uid": "ae5f4zx8ilukga"
        },
        "fieldConfig": {
            "defaults": {
            "mappings": [],
            "thresholds": {
                "mode": "absolute",
                "steps": [
                {
                    "color": "green",
                    "value": null
                },
                {
                    "color": "red",
                    "value": 80
                }
                ]
            },
            "unit": "short"
            },
            "overrides": []
        },
        "gridPos": {
            "h": 8,
            "w": 5,
            "x": 19,
            "y": 9
        },
        "id": 21,
        "options": {
            "colorMode": "value",
            "graphMode": "area",
            "justifyMode": "auto",
            "orientation": "auto",
            "reduceOptions": {
            "calcs": [
                "lastNotNull"
            ],
            "fields": "",
            "values": false
            },
            "showPercentChange": false,
            "textMode": "auto",
            "wideLayout": true
        },
        "pluginVersion": "10.4.1",
        "targets": [
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {},
            "expression": "",
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": false,
            "metricEditorMode": 0,
            "metricName": "EstimatedCharges",
            "metricQueryType": 0,
            "namespace": "AWS/Billing",
            "period": "604800",
            "queryMode": "Metrics",
            "refId": "A",
            "region": "us-east-1",
            "sqlExpression": "",
            "statistic": "Average"
            }
        ],
        "title": "Estimasted Month Cost ($)",
        "transformations": [
            {
            "id": "filterFieldsByName",
            "options": {
                "include": {
                "names": [
                    "EstimatedCharges"
                ]
                }
            }
            }
        ],
        "type": "stat"
        },
        {
        "datasource": {
            "type": "cloudwatch",
            "uid": "ae5f4zx8ilukga"
        },
        "fieldConfig": {
            "defaults": {
            "color": {
                "mode": "palette-classic"
            },
            "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 0,
                "gradientMode": "none",
                "hideFrom": {
                "legend": false,
                "tooltip": false,
                "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                "group": "A",
                "mode": "none"
                },
                "thresholdsStyle": {
                "mode": "off"
                }
            },
            "mappings": [],
            "thresholds": {
                "mode": "absolute",
                "steps": [
                {
                    "color": "green",
                    "value": null
                },
                {
                    "color": "red",
                    "value": 80
                }
                ]
            },
            "unit": "short"
            },
            "overrides": []
        },
        "gridPos": {
            "h": 4,
            "w": 8,
            "x": 7,
            "y": 13
        },
        "id": 19,
        "options": {
            "legend": {
            "calcs": [],
            "displayMode": "list",
            "placement": "right",
            "showLegend": true
            },
            "tooltip": {
            "mode": "single",
            "sort": "none"
            }
        },
        "pluginVersion": "10.4.1",
        "targets": [
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "ServiceName": "tsk-${environment}-task-runner-svc"
            },
            "expression": "",
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": false,
            "metricEditorMode": 0,
            "metricName": "DesiredTaskCount",
            "metricQueryType": 0,
            "namespace": "ECS/ContainerInsights",
            "period": "60",
            "queryMode": "Metrics",
            "refId": "A",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Maximum"
            },
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "ServiceName": "tsk-${environment}-task-runner-svc"
            },
            "expression": "",
            "hide": false,
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": false,
            "metricEditorMode": 0,
            "metricName": "RunningTaskCount",
            "metricQueryType": 0,
            "namespace": "ECS/ContainerInsights",
            "period": "60",
            "queryMode": "Metrics",
            "refId": "B",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Maximum"
            }
        ],
        "title": "ECS - Task Runner Tasks",
        "type": "timeseries"
        },
        {
        "collapsed": false,
        "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 17
        },
        "id": 12,
        "panels": [],
        "title": "Task Runner Metrics",
        "type": "row"
        },
        {
        "datasource": {
            "type": "cloudwatch",
            "uid": "ae5f4zx8ilukga"
        },
        "gridPos": {
            "h": 8,
            "w": 7,
            "x": 0,
            "y": 18
        },
        "id": 13,
        "options": {
            "dedupStrategy": "none",
            "enableLogDetails": true,
            "prettifyLogMessage": true,
            "showCommonLabels": false,
            "showLabels": false,
            "showTime": true,
            "sortOrder": "Descending",
            "wrapLogMessage": true
        },
        "targets": [
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {},
            "expression": "fields message, @message\n| filter @message like /\\{./",
            "id": "",
            "label": "",
            "logGroups": [
                {
                "accountId": "569985934894",
                "arn": "arn:aws:logs:eu-west-1:569985934894:log-group:tsk-${environment}-task-runner-logs:*",
                "name": "tsk-${environment}-task-runner-logs"
                }
            ],
            "matchExact": true,
            "metricEditorMode": 0,
            "metricName": "",
            "metricQueryType": 0,
            "namespace": "",
            "period": "",
            "queryMode": "Logs",
            "refId": "A",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Average",
            "statsGroups": []
            }
        ],
        "title": "Logs",
        "type": "logs"
        },
        {
        "datasource": {
            "type": "cloudwatch",
            "uid": "ae5f4zx8ilukga"
        },
        "gridPos": {
            "h": 8,
            "w": 7,
            "x": 7,
            "y": 18
        },
        "id": 14,
        "options": {
            "dedupStrategy": "none",
            "enableLogDetails": true,
            "prettifyLogMessage": true,
            "showCommonLabels": false,
            "showLabels": false,
            "showTime": true,
            "sortOrder": "Descending",
            "wrapLogMessage": false
        },
        "targets": [
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {},
            "expression": "fields message, @message |\n filter @message like /^\\{/ |\n filter level = 'error'",
            "id": "",
            "label": "",
            "logGroups": [
                {
                "accountId": "569985934894",
                "arn": "arn:aws:logs:eu-west-1:569985934894:log-group:tsk-${environment}-task-runner-logs:*",
                "name": "tsk-${environment}-task-runner-logs"
                }
            ],
            "matchExact": true,
            "metricEditorMode": 0,
            "metricName": "",
            "metricQueryType": 0,
            "namespace": "",
            "period": "",
            "queryMode": "Logs",
            "refId": "A",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Average",
            "statsGroups": []
            }
        ],
        "title": "Error Logs",
        "type": "logs"
        },
        {
        "datasource": {
            "type": "cloudwatch",
            "uid": "ae5f4zx8ilukga"
        },
        "fieldConfig": {
            "defaults": {
            "color": {
                "mode": "palette-classic"
            },
            "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "bars",
                "fillOpacity": 100,
                "gradientMode": "none",
                "hideFrom": {
                "legend": false,
                "tooltip": false,
                "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "stepBefore",
                "lineStyle": {
                "fill": "solid"
                },
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                "group": "A",
                "mode": "normal"
                },
                "thresholdsStyle": {
                "mode": "off"
                }
            },
            "mappings": [],
            "thresholds": {
                "mode": "absolute",
                "steps": [
                {
                    "color": "green",
                    "value": null
                },
                {
                    "color": "red",
                    "value": 80
                }
                ]
            }
            },
            "overrides": []
        },
        "gridPos": {
            "h": 8,
            "w": 8,
            "x": 14,
            "y": 18
        },
        "id": 15,
        "options": {
            "legend": {
            "calcs": [],
            "displayMode": "table",
            "placement": "bottom",
            "showLegend": true
            },
            "tooltip": {
            "mode": "single",
            "sort": "none"
            }
        },
        "targets": [
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {},
            "expression": "fields message, @message\n| filter level = 'error'\n| stats count() as error_count by error, bin(5m)",
            "id": "",
            "label": "",
            "logGroups": [
                {
                "accountId": "569985934894",
                "arn": "arn:aws:logs:eu-west-1:569985934894:log-group:tsk-${environment}-task-runner-logs:*",
                "name": "tsk-${environment}-task-runner-logs"
                }
            ],
            "matchExact": true,
            "metricEditorMode": 0,
            "metricName": "",
            "metricQueryType": 0,
            "namespace": "",
            "period": "",
            "queryMode": "Logs",
            "refId": "A",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Average",
            "statsGroups": [
                "error",
                "bin(5m)"
            ]
            }
        ],
        "title": "Errors Over Time",
        "type": "timeseries"
        },
        {
        "datasource": {
            "type": "cloudwatch",
            "uid": "ae5f4zx8ilukga"
        },
        "fieldConfig": {
            "defaults": {
            "color": {
                "mode": "palette-classic"
            },
            "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 0,
                "gradientMode": "none",
                "hideFrom": {
                "legend": false,
                "tooltip": false,
                "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                "group": "A",
                "mode": "none"
                },
                "thresholdsStyle": {
                "mode": "off"
                }
            },
            "mappings": [],
            "thresholds": {
                "mode": "absolute",
                "steps": [
                {
                    "color": "green"
                },
                {
                    "color": "red",
                    "value": 80
                }
                ]
            }
            },
            "overrides": []
        },
        "gridPos": {
            "h": 7,
            "w": 6,
            "x": 0,
            "y": 26
        },
        "id": 16,
        "options": {
            "legend": {
            "calcs": [],
            "displayMode": "list",
            "placement": "bottom",
            "showLegend": true
            },
            "tooltip": {
            "mode": "single",
            "sort": "none"
            }
        },
        "targets": [
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "ServiceName": "tsk-${environment}-task-runner-svc"
            },
            "expression": "",
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": false,
            "metricEditorMode": 0,
            "metricName": "CpuUtilized",
            "metricQueryType": 0,
            "namespace": "ECS/ContainerInsights",
            "period": "",
            "queryMode": "Metrics",
            "refId": "A",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Average"
            },
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "ServiceName": "tsk-${environment}-task-runner-svc"
            },
            "expression": "",
            "hide": false,
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": false,
            "metricEditorMode": 0,
            "metricName": "CpuReserved",
            "metricQueryType": 0,
            "namespace": "ECS/ContainerInsights",
            "period": "",
            "queryMode": "Metrics",
            "refId": "C",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Maximum"
            }
        ],
        "title": "CPU Usage",
        "type": "timeseries"
        },
        {
        "datasource": {
            "type": "cloudwatch",
            "uid": "ae5f4zx8ilukga"
        },
        "fieldConfig": {
            "defaults": {
            "color": {
                "mode": "palette-classic"
            },
            "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 0,
                "gradientMode": "none",
                "hideFrom": {
                "legend": false,
                "tooltip": false,
                "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                "group": "A",
                "mode": "none"
                },
                "thresholdsStyle": {
                "mode": "off"
                }
            },
            "mappings": [],
            "thresholds": {
                "mode": "absolute",
                "steps": [
                {
                    "color": "green"
                },
                {
                    "color": "red",
                    "value": 80
                }
                ]
            }
            },
            "overrides": []
        },
        "gridPos": {
            "h": 7,
            "w": 6,
            "x": 6,
            "y": 26
        },
        "id": 17,
        "options": {
            "legend": {
            "calcs": [],
            "displayMode": "list",
            "placement": "bottom",
            "showLegend": true
            },
            "tooltip": {
            "mode": "single",
            "sort": "none"
            }
        },
        "targets": [
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "ServiceName": "tsk-${environment}-task-runner-svc"
            },
            "expression": "",
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": false,
            "metricEditorMode": 0,
            "metricName": "MemoryUtilized",
            "metricQueryType": 0,
            "namespace": "ECS/ContainerInsights",
            "period": "",
            "queryMode": "Metrics",
            "refId": "A",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Average"
            },
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "ServiceName": "tsk-${environment}-task-runner-svc"
            },
            "expression": "",
            "hide": false,
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": false,
            "metricEditorMode": 0,
            "metricName": "MemoryReserved",
            "metricQueryType": 0,
            "namespace": "ECS/ContainerInsights",
            "period": "",
            "queryMode": "Metrics",
            "refId": "C",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Maximum"
            }
        ],
        "title": "RAM Usage",
        "type": "timeseries"
        },
        {
        "collapsed": false,
        "gridPos": {
            "h": 1,
            "w": 24,
            "x": 0,
            "y": 33
        },
        "id": 6,
        "panels": [],
        "title": "API Server Metrics",
        "type": "row"
        },
        {
        "datasource": {
            "type": "cloudwatch",
            "uid": "ae5f4zx8ilukga"
        },
        "gridPos": {
            "h": 8,
            "w": 7,
            "x": 0,
            "y": 34
        },
        "id": 9,
        "options": {
            "dedupStrategy": "none",
            "enableLogDetails": true,
            "prettifyLogMessage": true,
            "showCommonLabels": false,
            "showLabels": false,
            "showTime": true,
            "sortOrder": "Descending",
            "wrapLogMessage": false
        },
        "targets": [
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {},
            "expression": "fields @timestamp, message \n| filter @message like /\\{./",
            "id": "",
            "label": "",
            "logGroups": [
                {
                "accountId": "569985934894",
                "arn": "arn:aws:logs:eu-west-1:569985934894:log-group:tsk-${environment}-api-logs:*",
                "name": "tsk-${environment}-api-logs"
                }
            ],
            "matchExact": true,
            "metricEditorMode": 0,
            "metricName": "",
            "metricQueryType": 0,
            "namespace": "",
            "period": "",
            "queryMode": "Logs",
            "refId": "A",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Average",
            "statsGroups": []
            }
        ],
        "title": "Logs",
        "type": "logs"
        },
        {
        "datasource": {
            "type": "cloudwatch",
            "uid": "ae5f4zx8ilukga"
        },
        "gridPos": {
            "h": 8,
            "w": 7,
            "x": 7,
            "y": 34
        },
        "id": 10,
        "options": {
            "dedupStrategy": "none",
            "enableLogDetails": true,
            "prettifyLogMessage": true,
            "showCommonLabels": false,
            "showLabels": false,
            "showTime": true,
            "sortOrder": "Descending",
            "wrapLogMessage": false
        },
        "targets": [
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {},
            "expression": "fields @timestamp, message |\n filter @message like /^\\{/ |\n filter level = 'error'",
            "id": "",
            "label": "",
            "logGroups": [
                {
                "accountId": "569985934894",
                "arn": "arn:aws:logs:eu-west-1:569985934894:log-group:tsk-${environment}-api-logs:*",
                "name": "tsk-${environment}-api-logs"
                }
            ],
            "matchExact": true,
            "metricEditorMode": 0,
            "metricName": "",
            "metricQueryType": 0,
            "namespace": "",
            "period": "",
            "queryMode": "Logs",
            "refId": "A",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Average",
            "statsGroups": []
            }
        ],
        "title": "Error Logs",
        "type": "logs"
        },
        {
        "datasource": {
            "type": "cloudwatch",
            "uid": "ae5f4zx8ilukga"
        },
        "fieldConfig": {
            "defaults": {
            "color": {
                "mode": "palette-classic"
            },
            "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "bars",
                "fillOpacity": 100,
                "gradientMode": "none",
                "hideFrom": {
                "legend": false,
                "tooltip": false,
                "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "stepBefore",
                "lineStyle": {
                "fill": "solid"
                },
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                "group": "A",
                "mode": "normal"
                },
                "thresholdsStyle": {
                "mode": "off"
                }
            },
            "mappings": [],
            "thresholds": {
                "mode": "absolute",
                "steps": [
                {
                    "color": "green"
                },
                {
                    "color": "red",
                    "value": 80
                }
                ]
            }
            },
            "overrides": []
        },
        "gridPos": {
            "h": 8,
            "w": 8,
            "x": 14,
            "y": 34
        },
        "id": 11,
        "options": {
            "legend": {
            "calcs": [],
            "displayMode": "table",
            "placement": "bottom",
            "showLegend": true
            },
            "tooltip": {
            "mode": "single",
            "sort": "none"
            }
        },
        "targets": [
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {},
            "expression": "fields @timestamp, @message, error\n| filter level = 'error'\n| stats count() as error_count by error, bin(5m)",
            "id": "",
            "label": "",
            "logGroups": [
                {
                "accountId": "569985934894",
                "arn": "arn:aws:logs:eu-west-1:569985934894:log-group:tsk-${environment}-api-logs:*",
                "name": "tsk-${environment}-api-logs"
                }
            ],
            "matchExact": true,
            "metricEditorMode": 0,
            "metricName": "",
            "metricQueryType": 0,
            "namespace": "",
            "period": "",
            "queryMode": "Logs",
            "refId": "A",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Average",
            "statsGroups": [
                "error",
                "bin(5m)"
            ]
            }
        ],
        "title": "Errors Over Time",
        "type": "timeseries"
        },
        {
        "datasource": {
            "type": "cloudwatch",
            "uid": "ae5f4zx8ilukga"
        },
        "fieldConfig": {
            "defaults": {
            "color": {
                "mode": "palette-classic"
            },
            "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 0,
                "gradientMode": "none",
                "hideFrom": {
                "legend": false,
                "tooltip": false,
                "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                "group": "A",
                "mode": "none"
                },
                "thresholdsStyle": {
                "mode": "off"
                }
            },
            "mappings": [],
            "thresholds": {
                "mode": "absolute",
                "steps": [
                {
                    "color": "green"
                },
                {
                    "color": "red",
                    "value": 80
                }
                ]
            }
            },
            "overrides": []
        },
        "gridPos": {
            "h": 7,
            "w": 6,
            "x": 0,
            "y": 42
        },
        "id": 7,
        "options": {
            "legend": {
            "calcs": [],
            "displayMode": "list",
            "placement": "bottom",
            "showLegend": true
            },
            "tooltip": {
            "mode": "single",
            "sort": "none"
            }
        },
        "targets": [
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "ServiceName": "tsk-${environment}-api-svc"
            },
            "expression": "",
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": false,
            "metricEditorMode": 0,
            "metricName": "CpuUtilized",
            "metricQueryType": 0,
            "namespace": "ECS/ContainerInsights",
            "period": "",
            "queryMode": "Metrics",
            "refId": "A",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Average"
            },
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "ServiceName": "tsk-${environment}-api-svc"
            },
            "expression": "",
            "hide": false,
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": false,
            "metricEditorMode": 0,
            "metricName": "CpuReserved",
            "metricQueryType": 0,
            "namespace": "ECS/ContainerInsights",
            "period": "",
            "queryMode": "Metrics",
            "refId": "C",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Maximum"
            }
        ],
        "title": "CPU Usage",
        "type": "timeseries"
        },
        {
        "datasource": {
            "type": "cloudwatch",
            "uid": "ae5f4zx8ilukga"
        },
        "fieldConfig": {
            "defaults": {
            "color": {
                "mode": "palette-classic"
            },
            "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 0,
                "gradientMode": "none",
                "hideFrom": {
                "legend": false,
                "tooltip": false,
                "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                "group": "A",
                "mode": "none"
                },
                "thresholdsStyle": {
                "mode": "off"
                }
            },
            "mappings": [],
            "thresholds": {
                "mode": "absolute",
                "steps": [
                {
                    "color": "green"
                },
                {
                    "color": "red",
                    "value": 80
                }
                ]
            }
            },
            "overrides": []
        },
        "gridPos": {
            "h": 7,
            "w": 6,
            "x": 6,
            "y": 42
        },
        "id": 8,
        "options": {
            "legend": {
            "calcs": [],
            "displayMode": "list",
            "placement": "bottom",
            "showLegend": true
            },
            "tooltip": {
            "mode": "single",
            "sort": "none"
            }
        },
        "targets": [
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "ServiceName": "tsk-${environment}-api-svc"
            },
            "expression": "",
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": false,
            "metricEditorMode": 0,
            "metricName": "MemoryUtilized",
            "metricQueryType": 0,
            "namespace": "ECS/ContainerInsights",
            "period": "",
            "queryMode": "Metrics",
            "refId": "A",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Average"
            },
            {
            "datasource": {
                "type": "cloudwatch",
                "uid": "ae5f4zx8ilukga"
            },
            "dimensions": {
                "ServiceName": "tsk-${environment}-api-svc"
            },
            "expression": "",
            "hide": false,
            "id": "",
            "label": "",
            "logGroups": [],
            "matchExact": false,
            "metricEditorMode": 0,
            "metricName": "MemoryReserved",
            "metricQueryType": 0,
            "namespace": "ECS/ContainerInsights",
            "period": "",
            "queryMode": "Metrics",
            "refId": "C",
            "region": "default",
            "sqlExpression": "",
            "statistic": "Maximum"
            }
        ],
        "title": "RAM Usage",
        "type": "timeseries"
        }
    ],
    "refresh": "30s",
    "schemaVersion": 39,
    "tags": [],
    "templating": {
        "list": [
        {
            "hide": 2,
            "label": "env",
            "name": "env",
            "query": "${environment}",
            "skipUrlSync": false,
            "type": "constant"
        }
        ]
    },
    "time": {
        "from": "now-6h",
        "to": "now"
    },
    "timepicker": {},
    "timezone": "browser",
    "title": "tsk-${environment}-app-performance",
    "version": 12,
    "weekStart": ""

}