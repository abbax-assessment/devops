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
        "type": "${cloudwatch_data_source_type}",
        "uid": "${cloudwatch_data_source_id}"
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "LoadBalancer": "${alb_arn_suffix}"
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
          "region": "${default_region}",
          "sqlExpression": "",
          "statistic": "Average"
        },
        {
          "datasource": {
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "LoadBalancer": "${alb_arn_suffix}"
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
          "region": "${default_region}",
          "sqlExpression": "",
          "statistic": "Sum"
        },
        {
          "datasource": {
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "LoadBalancer": "${alb_arn_suffix}"
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
          "region": "${default_region}",
          "sqlExpression": "",
          "statistic": "Sum"
        }
      ],
      "title": "Load Balancer Metrics",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "${cloudwatch_data_source_type}",
        "uid": "${cloudwatch_data_source_id}"
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "LoadBalancer": "${alb_arn_suffix}"
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
          "region": "${default_region}",
          "sqlExpression": "",
          "statistic": "Sum"
        },
        {
          "datasource": {
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "LoadBalancer": "${alb_arn_suffix}"
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
          "region": "${default_region}",
          "sqlExpression": "",
          "statistic": "Sum"
        },
        {
          "datasource": {
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "LoadBalancer": "${alb_arn_suffix}"
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
          "region": "${default_region}",
          "sqlExpression": "",
          "statistic": "Sum"
        }
      ],
      "title": "Code Rates 2xx/4xx/5xx",
      "type": "piechart"
    },
    {
      "datasource": {
        "type": "${cloudwatch_data_source_type}",
        "uid": "${cloudwatch_data_source_id}"
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
        "w": 5,
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "QueueName": "${sqs_tasks_name}"
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
          "region": "${default_region}",
          "sqlExpression": "",
          "statistic": "Sum"
        },
        {
          "datasource": {
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "QueueName": "${sqs_tasks_name}"
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
          "region": "${default_region}",
          "sqlExpression": "",
          "statistic": "Sum"
        },
        {
          "datasource": {
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "QueueName": "${sqs_tasks_dlq_name}"
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
          "region": "${default_region}",
          "sqlExpression": "",
          "statistic": "Sum"
        },
        {
          "datasource": {
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "QueueName": "${sqs_tasks_dlq_name}"
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
          "region": "${default_region}",
          "sqlExpression": "",
          "statistic": "Sum"
        }
      ],
      "title": "SQS Tasks-Queue",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "${cloudwatch_data_source_type}",
        "uid": "${cloudwatch_data_source_id}"
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
        "w": 5,
        "x": 19,
        "y": 1
      },
      "id": 23,
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "TableName": "${dynamodb_tasks_table_name}"
          },
          "expression": "",
          "id": "",
          "label": "",
          "logGroups": [],
          "matchExact": true,
          "metricEditorMode": 0,
          "metricName": "ConsumedReadCapacityUnits",
          "metricQueryType": 0,
          "namespace": "AWS/DynamoDB",
          "period": "",
          "queryMode": "Metrics",
          "refId": "A",
          "region": "default",
          "sqlExpression": "",
          "statistic": "Average"
        },
        {
          "datasource": {
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "TableName": "${dynamodb_tasks_table_name}"
          },
          "expression": "",
          "hide": false,
          "id": "",
          "label": "",
          "logGroups": [],
          "matchExact": true,
          "metricEditorMode": 0,
          "metricName": "ConsumedWriteCapacityUnits",
          "metricQueryType": 0,
          "namespace": "AWS/DynamoDB",
          "period": "",
          "queryMode": "Metrics",
          "refId": "B",
          "region": "default",
          "sqlExpression": "",
          "statistic": "Average"
        },
        {
          "datasource": {
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "TableName": "${dynamodb_tasks_table_name}"
          },
          "expression": "",
          "hide": false,
          "id": "",
          "label": "",
          "logGroups": [],
          "matchExact": true,
          "metricEditorMode": 0,
          "metricName": "ReadThrottleEvents",
          "metricQueryType": 0,
          "namespace": "AWS/DynamoDB",
          "period": "",
          "queryMode": "Metrics",
          "refId": "C",
          "region": "default",
          "sqlExpression": "",
          "statistic": "Average"
        },
        {
          "datasource": {
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "TableName": "${dynamodb_tasks_table_name}"
          },
          "expression": "",
          "hide": false,
          "id": "",
          "label": "",
          "logGroups": [],
          "matchExact": true,
          "metricEditorMode": 0,
          "metricName": "WriteThrottleEvents",
          "metricQueryType": 0,
          "namespace": "AWS/DynamoDB",
          "period": "",
          "queryMode": "Metrics",
          "refId": "D",
          "region": "default",
          "sqlExpression": "",
          "statistic": "Average"
        }
      ],
      "title": "DB tasks table",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "${xray_data_source_type}",
        "uid": "${xray_data_source_id}"
      },
      "gridPos": {
        "h": 9,
        "w": 9,
        "x": 0,
        "y": 9
      },
      "id": 4,
      "options": {
        "edges": {},
        "nodes": {}
      },
      "pluginVersion": "10.4.1",
      "targets": [
        {
          "datasource": {
            "type": "${xray_data_source_type}",
            "uid": "${xray_data_source_id}"
          },
          "group": {
            "GroupName": "Default",
            "GroupARN": "arn:aws:xray:${default_region}:${account_id}:group/Default",
            "InsightsConfiguration": {
              "InsightsEnabled": false,
              "NotificationsEnabled": false
            }
          },
          "query": "",
          "queryType": "getServiceMap",
          "refId": "A",
          "region": "${default_region}"
        }
      ],
      "title": "Trace Statistics",
      "type": "nodeGraph"
    },
    {
      "datasource": {
        "type": "${cloudwatch_data_source_type}",
        "uid": "${cloudwatch_data_source_id}"
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
            "fillOpacity": 25,
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
        "h": 9,
        "w": 6,
        "x": 9,
        "y": 9
      },
      "id": 18,
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
      "pluginVersion": "10.4.1",
      "targets": [
        {
          "datasource": {
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "ServiceName": "${api_svc_name}"
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
        },
        {
          "datasource": {
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "ServiceName": "${task_runner_svc_name}"
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
          "refId": "D",
          "region": "default",
          "sqlExpression": "",
          "statistic": "Maximum"
        }
      ],
      "title": "ECS Running Tasks",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "${cloudwatch_data_source_type}",
        "uid": "${cloudwatch_data_source_id}"
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
        "h": 9,
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "AvailabilityZone": "${default_region}a",
            "LoadBalancer": "${alb_arn_suffix}"
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "AvailabilityZone": "${default_region}b",
            "LoadBalancer": "${alb_arn_suffix}"
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
        "type": "${cloudwatch_data_source_type}",
        "uid": "${cloudwatch_data_source_id}"
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
        "h": 3,
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
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
        "type": "${cloudwatch_alarms_data_source_type}",
        "uid": "${cloudwatch_alarms_data_source_type}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "fixed"
          },
          "custom": {
            "align": "auto",
            "cellOptions": {
              "type": "auto"
            },
            "inspect": false
          },
          "mappings": [
            {
              "options": {
                "ALARM": {
                  "color": "red",
                  "index": 1
                },
                "OK": {
                  "color": "green",
                  "index": 0
                }
              },
              "type": "value"
            }
          ],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              }
            ]
          }
        },
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "StateValue"
            },
            "properties": [
              {
                "id": "custom.cellOptions",
                "value": {
                  "mode": "basic",
                  "type": "color-background"
                }
              },
              {
                "id": "custom.width",
                "value": 90
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "AlarmName"
            },
            "properties": [
              {
                "id": "custom.cellOptions",
                "value": {
                  "type": "auto"
                }
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 6,
        "w": 5,
        "x": 19,
        "y": 12
      },
      "id": 22,
      "options": {
        "cellHeight": "sm",
        "footer": {
          "countRows": false,
          "fields": "",
          "reducer": [
            "sum"
          ],
          "show": false
        },
        "showHeader": true,
        "sortBy": []
      },
      "pluginVersion": "10.4.1",
      "targets": [
        {
          "alarmNamePrefix": "",
          "datasource": {
            "type": "${cloudwatch_alarms_data_source_type}",
            "uid": "${cloudwatch_alarms_data_source_type}"
          },
          "includeAlarm": true,
          "includeInsufficientData": false,
          "includeOk": true,
          "includeTypeComposite": false,
          "includeTypeMetric": true,
          "refId": "A",
          "region": "${default_region}"
        }
      ],
      "title": "Alarms State",
      "transformations": [
        {
          "id": "filterFieldsByName",
          "options": {
            "include": {
              "names": [
                "AlarmName",
                "StateValue"
              ]
            }
          }
        }
      ],
      "type": "table"
    },
    {
      "collapsed": false,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 18
      },
      "id": 12,
      "panels": [],
      "title": "Task Runner Metrics",
      "type": "row"
    },
    {
      "datasource": {
        "type": "${cloudwatch_data_source_type}",
        "uid": "${cloudwatch_data_source_id}"
      },
      "gridPos": {
        "h": 8,
        "w": 7,
        "x": 0,
        "y": 19
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {},
          "expression": "fields message, @message\n| filter @message like /\\{./",
          "id": "",
          "label": "",
          "logGroups": [
            {
              "accountId": "${account_id}",
              "arn": "${task_runner_logs_arn}:*",
              "name": "${task_runner_logs_name}"
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
        "type": "${cloudwatch_data_source_type}",
        "uid": "${cloudwatch_data_source_id}"
      },
      "gridPos": {
        "h": 8,
        "w": 7,
        "x": 7,
        "y": 19
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {},
          "expression": "fields message, @message |\n filter @message like /^\\{/ |\n filter level = 'error'",
          "id": "",
          "label": "",
          "logGroups": [
            {
              "accountId": "${account_id}",
              "arn": "${task_runner_logs_arn}:*",
              "name": "${task_runner_logs_name}"
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
        "type": "${cloudwatch_data_source_type}",
        "uid": "${cloudwatch_data_source_id}"
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
        "y": 19
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {},
          "expression": "fields message, @message\n| filter level = 'error'\n| stats count() as error_count by error, bin(5m)",
          "id": "",
          "label": "",
          "logGroups": [
            {
              "accountId": "${account_id}",
              "arn": "${task_runner_logs_arn}:*",
              "name": "${task_runner_logs_name}"
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
        "type": "${cloudwatch_data_source_type}",
        "uid": "${cloudwatch_data_source_id}"
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
        "h": 7,
        "w": 6,
        "x": 0,
        "y": 27
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "ServiceName": "${task_runner_svc_name}"
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "ServiceName": "${task_runner_svc_name}"
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
        "type": "${cloudwatch_data_source_type}",
        "uid": "${cloudwatch_data_source_id}"
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
        "h": 7,
        "w": 6,
        "x": 6,
        "y": 27
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "ServiceName": "${task_runner_svc_name}"
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "ServiceName": "${task_runner_svc_name}"
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
        "y": 34
      },
      "id": 6,
      "panels": [],
      "title": "API Server Metrics",
      "type": "row"
    },
    {
      "datasource": {
        "type": "${cloudwatch_data_source_type}",
        "uid": "${cloudwatch_data_source_id}"
      },
      "gridPos": {
        "h": 8,
        "w": 7,
        "x": 0,
        "y": 35
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {},
          "expression": "fields @timestamp, message \n| filter @message like /\\{./",
          "id": "",
          "label": "",
          "logGroups": [
            {
              "accountId": "${account_id}",
              "arn": "${api_logs_arn}:*",
              "name": "${api_logs_name}"
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
        "type": "${cloudwatch_data_source_type}",
        "uid": "${cloudwatch_data_source_id}"
      },
      "gridPos": {
        "h": 8,
        "w": 7,
        "x": 7,
        "y": 35
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {},
          "expression": "fields @timestamp, message |\n filter @message like /^\\{/ |\n filter level = 'error'",
          "id": "",
          "label": "",
          "logGroups": [
            {
              "accountId": "${account_id}",
              "arn": "${api_logs_arn}:*",
              "name": "${api_logs_name}"
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
        "type": "${cloudwatch_data_source_type}",
        "uid": "${cloudwatch_data_source_id}"
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
        "y": 35
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {},
          "expression": "fields @timestamp, @message, error\n| filter level = 'error'\n| stats count() as error_count by error, bin(5m)",
          "id": "",
          "label": "",
          "logGroups": [
            {
              "accountId": "${account_id}",
              "arn": "${api_logs_arn}:*",
              "name": "${api_logs_name}"
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
        "type": "${cloudwatch_data_source_type}",
        "uid": "${cloudwatch_data_source_id}"
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
        "h": 7,
        "w": 6,
        "x": 0,
        "y": 43
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "ServiceName": "${api_svc_name}"
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "ServiceName": "${api_svc_name}"
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
        "type": "${cloudwatch_data_source_type}",
        "uid": "${cloudwatch_data_source_id}"
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
        "h": 7,
        "w": 6,
        "x": 6,
        "y": 43
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "ServiceName": "${api_svc_name}"
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
            "type": "${cloudwatch_data_source_type}",
            "uid": "${cloudwatch_data_source_id}"
          },
          "dimensions": {
            "ServiceName": "${api_svc_name}"
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
  "refresh": "5m",
  "schemaVersion": 39,
  "tags": [],
  "templating": {
    "list": []
  },
  "time": {
    "from": "now-6h",
    "to": "now"
  },
  "timepicker": {},
  "timezone": "browser",
  "title": "${title}",
  "version": 10,
  "weekStart": ""
}
