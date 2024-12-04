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
  "id": 4,
  "links": [],
  "panels": [
    {
      "datasource": {
        "type": "${athena_data_source_type}",
        "uid": "${athena_data_source_id}"
      },
      "fieldConfig": {
        "defaults": {
          "mappings": [],
          "thresholds": {
            "mode": "percentage",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 60
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 7,
        "w": 5,
        "x": 0,
        "y": 0
      },
      "id": 5,
      "options": {
        "minVizHeight": 75,
        "minVizWidth": 75,
        "orientation": "auto",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "showThresholdLabels": false,
        "showThresholdMarkers": true,
        "sizing": "auto"
      },
      "pluginVersion": "10.4.1",
      "targets": [
        {
          "connectionArgs": {
            "catalog": "__default",
            "database": "__default",
            "region": "__default",
            "resultReuseEnabled": false,
            "resultReuseMaxAgeInMinutes": 60
          },
          "datasource": {
            "type": "${athena_data_source_type}",
            "uid": "${athena_data_source_id}"
          },
          "format": 1,
          "rawSQL": "with successful_deployment as (\r\n    select deployment.id from deployment_status\r\n    where deployment_status.deployment_status.state='success'\r\n),\r\nall_deployments as (\r\n    select deployment.id from deployment_status\r\n    where deployment_status.deployment_status.state='in_progress'\r\n    group by deployment.id\r\n)\r\nselect \r\n    (\r\n        (select count(*) * 1.0 from successful_deployment) /\r\n        (select count(*) * 1.0 from all_deployments)\r\n    ) * 100 as success_rate",
          "refId": "A"
        }
      ],
      "title": "Deployment Success Rate ",
      "type": "gauge"
    },
    {
      "datasource": {
        "type": "${athena_data_source_type}",
        "uid": "${athena_data_source_id}"
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
            "fillOpacity": 82,
            "gradientMode": "hue",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "insertNulls": false,
            "lineInterpolation": "stepAfter",
            "lineStyle": {
              "fill": "solid"
            },
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "always",
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
        "w": 15,
        "x": 5,
        "y": 0
      },
      "id": 1,
      "options": {
        "legend": {
          "calcs": [
            "mean"
          ],
          "displayMode": "table",
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
          "connectionArgs": {
            "catalog": "__default",
            "database": "__default",
            "region": "__default",
            "resultReuseEnabled": true,
            "resultReuseMaxAgeInMinutes": 60
          },
          "datasource": {
            "type": "${athena_data_source_type}",
            "uid": "${athena_data_source_id}"
          },
          "format": 1,
          "rawSQL": "with completed_workflow_runs as (\r\n    select workflow_run.id, project from github_data.workflow_run\r\n    where action='completed'\r\n),\r\njobs_runs as (\r\n    select \r\n        j.branch || '/' || j.project || '/' || j.workflow_job.workflow_name as run_full_name,\r\n        c.id as run_id,\r\n        date_diff(\r\n            'second',\r\n            date_parse(j.workflow_job.started_at, '%Y-%m-%dT%H:%i:%sZ'),\r\n            date_parse(j.workflow_job.completed_at, '%Y-%m-%dT%H:%i:%sZ')\r\n        ) as duration,\r\n        date_format(date_trunc('hour', date_parse(workflow_job.started_at, '%Y-%m-%dT%H:%i:%sZ')), '%Y-%m-%dT%H:00:00Z') AS rounded_start_time\r\n    from github_data.workflow_job as j\r\n    left join completed_workflow_runs as c\r\n    on j.workflow_job.run_id = c.id  \r\n    where j.project = c.project and action='completed'\r\n)\r\nselect \r\n    run_full_name, \r\n    rounded_start_time,\r\n    avg(duration) as avg_duration \r\nfrom jobs_runs\r\ngroup by run_full_name, rounded_start_time",
          "refId": "A"
        }
      ],
      "title": "Average Workflow Duration",
      "transformations": [
        {
          "id": "convertFieldType",
          "options": {
            "conversions": [
              {
                "destinationType": "time",
                "targetField": "rounded_start_time"
              }
            ],
            "fields": {}
          }
        },
        {
          "id": "prepareTimeSeries",
          "options": {
            "format": "multi"
          }
        },
        {
          "id": "labelsToFields",
          "options": {
            "mode": "columns",
            "valueLabel": "run_full_name"
          }
        }
      ],
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "${athena_data_source_type}",
        "uid": "${athena_data_source_id}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "continuous-GrYlRd"
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
        "y": 7
      },
      "id": 2,
      "options": {
        "displayMode": "basic",
        "maxVizHeight": 300,
        "minVizHeight": 16,
        "minVizWidth": 8,
        "namePlacement": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [],
          "fields": "",
          "values": true
        },
        "showUnfilled": true,
        "sizing": "auto",
        "valueMode": "color"
      },
      "pluginVersion": "10.4.1",
      "targets": [
        {
          "connectionArgs": {
            "catalog": "__default",
            "database": "__default",
            "region": "__default",
            "resultReuseEnabled": true,
            "resultReuseMaxAgeInMinutes": 60
          },
          "datasource": {
            "type": "${athena_data_source_type}",
            "uid": "${athena_data_source_id}"
          },
          "format": 1,
          "rawSQL": "with completed_workflow_runs as (\r\n    select workflow_run.id, project from github_data.workflow_run\r\n    where action='completed'\r\n),\r\njobs_runs as (\r\n    select \r\n        j.branch || '/' || j.project || '/' || j.workflow_job.workflow_name as run_full_name,\r\n        c.id as run_id,\r\n        date_diff(\r\n            'second',\r\n            date_parse(j.workflow_job.started_at, '%Y-%m-%dT%H:%i:%sZ'),\r\n            date_parse(j.workflow_job.completed_at, '%Y-%m-%dT%H:%i:%sZ')\r\n        ) as duration,\r\n        date_format(date_trunc('hour', date_parse(workflow_job.started_at, '%Y-%m-%dT%H:%i:%sZ')), '%Y-%m-%dT%H:00:00Z') AS rounded_start_time\r\n    from github_data.workflow_job as j\r\n    left join completed_workflow_runs as c\r\n    on j.workflow_job.run_id = c.id  \r\n    where j.project = c.project and action='completed'\r\n)\r\nselect \r\n    run_full_name, \r\n    sum(duration)/60 as total_duration \r\nfrom jobs_runs\r\ngroup by run_full_name\r\norder by total_duration desc",
          "refId": "A"
        }
      ],
      "title": "Total Workflow Duration (mins)",
      "transformations": [
        {
          "disabled": true,
          "id": "groupBy",
          "options": {
            "fields": {
              "run_full_name": {
                "aggregations": [],
                "operation": "groupby"
              },
              "total_duration": {
                "aggregations": [
                  "mean"
                ],
                "operation": "aggregate"
              }
            }
          }
        }
      ],
      "type": "bargauge"
    },
    {
      "datasource": {
        "type": "${athena_data_source_type}",
        "uid": "${athena_data_source_id}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "continuous-GrYlRd"
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
        "x": 7,
        "y": 7
      },
      "id": 3,
      "options": {
        "displayMode": "basic",
        "maxVizHeight": 300,
        "minVizHeight": 16,
        "minVizWidth": 8,
        "namePlacement": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [],
          "fields": "",
          "values": true
        },
        "showUnfilled": true,
        "sizing": "auto",
        "valueMode": "color"
      },
      "pluginVersion": "10.4.1",
      "targets": [
        {
          "connectionArgs": {
            "catalog": "__default",
            "database": "__default",
            "region": "__default",
            "resultReuseEnabled": false,
            "resultReuseMaxAgeInMinutes": 60
          },
          "datasource": {
            "type": "${athena_data_source_type}",
            "uid": "${athena_data_source_id}"
          },
          "format": 1,
          "rawSQL": "with completed_workflow_runs as (\r\n    select workflow_run.id, project from github_data.workflow_run\r\n    where action='completed'\r\n),\r\njobs_runs as (\r\n    select \r\n        j.branch || '/' || j.project || '/' || j.workflow_job.workflow_name as run_full_name,\r\n        c.id as run_id,\r\n        date_diff(\r\n            'second',\r\n            date_parse(j.workflow_job.started_at, '%Y-%m-%dT%H:%i:%sZ'),\r\n            date_parse(j.workflow_job.completed_at, '%Y-%m-%dT%H:%i:%sZ')\r\n        ) as duration,\r\n        date_format(date_trunc('hour', date_parse(workflow_job.started_at, '%Y-%m-%dT%H:%i:%sZ')), '%Y-%m-%dT%H:00:00Z') AS rounded_start_time\r\n    from github_data.workflow_job as j\r\n    left join completed_workflow_runs as c\r\n    on j.workflow_job.run_id = c.id  \r\n    where j.project = c.project and action='completed'\r\n)\r\nselect \r\n    run_full_name,\r\n    count(distinct run_id) as total_runs\r\nfrom jobs_runs\r\ngroup by run_full_name\r\norder by total_runs desc",
          "refId": "A"
        }
      ],
      "title": "Total Workflow Executions",
      "type": "bargauge"
    },
    {
      "datasource": {
        "type": "${athena_data_source_type}",
        "uid": "${athena_data_source_id}"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "continuous-GrYlRd"
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
        "w": 6,
        "x": 14,
        "y": 7
      },
      "id": 4,
      "options": {
        "displayMode": "basic",
        "maxVizHeight": 300,
        "minVizHeight": 16,
        "minVizWidth": 8,
        "namePlacement": "auto",
        "orientation": "horizontal",
        "reduceOptions": {
          "calcs": [],
          "fields": "",
          "values": true
        },
        "showUnfilled": true,
        "sizing": "auto",
        "valueMode": "color"
      },
      "pluginVersion": "10.4.1",
      "targets": [
        {
          "connectionArgs": {
            "catalog": "__default",
            "database": "__default",
            "region": "__default",
            "resultReuseEnabled": false,
            "resultReuseMaxAgeInMinutes": 60
          },
          "datasource": {
            "type": "${athena_data_source_type}",
            "uid": "${athena_data_source_id}"
          },
          "format": 1,
          "rawSQL": "with completed_workflow_runs as (\r\n    select workflow_run.id, project from github_data.workflow_run\r\n    where action='completed' and workflow_run.conclusion='failure'\r\n),\r\njobs_runs as (\r\n    select \r\n        j.branch || '/' || j.project || '/' || j.workflow_job.workflow_name as run_full_name,\r\n        c.id as run_id,\r\n        date_diff(\r\n            'second',\r\n            date_parse(j.workflow_job.started_at, '%Y-%m-%dT%H:%i:%sZ'),\r\n            date_parse(j.workflow_job.completed_at, '%Y-%m-%dT%H:%i:%sZ')\r\n        ) as duration,\r\n        date_format(date_trunc('hour', date_parse(workflow_job.started_at, '%Y-%m-%dT%H:%i:%sZ')), '%Y-%m-%dT%H:00:00Z') AS rounded_start_time\r\n    from github_data.workflow_job as j\r\n    left join completed_workflow_runs as c\r\n    on j.workflow_job.run_id = c.id  \r\n    where j.project = c.project and action='completed'\r\n)\r\nselect \r\n    run_full_name,\r\n    count(distinct run_id) as total_runs\r\nfrom jobs_runs\r\ngroup by run_full_name\r\norder by total_runs desc",
          "refId": "A"
        }
      ],
      "title": "Workflow Fails",
      "transformations": [
        {
          "id": "convertFieldType",
          "options": {}
        }
      ],
      "type": "bargauge"
    }
  ],
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
  "version": 7,
  "weekStart": ""
}
