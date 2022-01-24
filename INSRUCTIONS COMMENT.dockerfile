{
  "annotations": {
    "list": [
      {
        "builtIn": 1,
        "datasource": "-- Grafana --",
        "enable": true,
        "hide": true,
        "iconColor": "rgba(0, 211, 255, 1)",
        "name": "Annotations & Alerts",
        "type": "dashboard"
      }
    ]
  },
  "description": "General stats dashboard with node selector, uses metrics from windows_exporter",
  "editable": true,
  "gnetId": 2129,
  "graphTooltip": 1,
  "id": 37,
  "iteration": 1642521218278,
  "links": [],
  "panels": [
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "Prometheus",
      "fieldConfig": {
        "defaults": {
          "unit": "percent"
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 6,
        "w": 6,
        "x": 0,
        "y": 0
      },
      "hiddenSeries": false,
      "hideTimeOverride": false,
      "id": 4,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": false,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.5.2",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "application": {
            "filter": ""
          },
          "exemplar": true,
          "expr": "100 - (avg by (instance) (irate(windows_cpu_time_total{mode=\"idle\", instance=~\"$server.*\"}[$interval])) * 100) > 0",
          "functions": [],
          "group": {
            "filter": ""
          },
          "hide": false,
          "host": {
            "filter": ""
          },
          "interval": "",
          "intervalFactor": 1,
          "item": {
            "filter": ""
          },
          "legendFormat": "{{mode}}",
          "metric": "mysql_global_status_questions",
          "mode": 0,
          "options": {
            "showDisabledItems": false
          },
          "refId": "A",
          "step": 20
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "CPU load",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "percent",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "cacheTimeout": null,
      "dashLength": 10,
      "dashes": false,
      "datasource": "Prometheus",
      "fieldConfig": {
        "defaults": {
          "unit": "percent"
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 6,
        "w": 6,
        "x": 6,
        "y": 0
      },
      "hiddenSeries": false,
      "hideTimeOverride": false,
      "id": 14,
      "interval": null,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": false,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.5.2",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "application": {
            "filter": ""
          },
          "exemplar": true,
          "expr": "(windows_cs_physical_memory_bytes{instance=~\"$server.*\"} - windows_os_physical_memory_free_bytes{instance=~\"$server.*\"}) / windows_cs_physical_memory_bytes{instance=~\"$server.*\"} * 100",
          "functions": [],
          "group": {
            "filter": ""
          },
          "hide": false,
          "host": {
            "filter": ""
          },
          "instant": false,
          "interval": "",
          "intervalFactor": 1,
          "item": {
            "filter": ""
          },
          "legendFormat": "Free physical memory",
          "metric": "mysql_global_status_questions",
          "mode": 0,
          "options": {
            "showDisabledItems": false
          },
          "refId": "C",
          "step": 5
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "Memory",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "percent",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "Prometheus",
      "fieldConfig": {
        "defaults": {
          "unit": "binbps"
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 12,
        "y": 0
      },
      "hiddenSeries": false,
      "hideTimeOverride": false,
      "id": 11,
      "legend": {
        "alignAsTable": true,
        "avg": true,
        "current": true,
        "max": false,
        "min": false,
        "rightSide": false,
        "show": true,
        "total": true,
        "values": true
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null as zero",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.5.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "application": {
            "filter": ""
          },
          "exemplar": true,
          "expr": "irate(windows_net_bytes_sent_total{instance=~\"$server\"}[$interval])*8 >0",
          "functions": [],
          "group": {
            "filter": ""
          },
          "hide": false,
          "host": {
            "filter": ""
          },
          "interval": "",
          "intervalFactor": 1,
          "item": {
            "filter": ""
          },
          "legendFormat": "Sent {{nic}}",
          "metric": "mysql_global_status_questions",
          "mode": 0,
          "options": {
            "showDisabledItems": false
          },
          "refId": "B",
          "step": 10
        },
        {
          "application": {
            "filter": ""
          },
          "exemplar": true,
          "expr": "- irate(windows_net_bytes_received_total{instance=~\"$server\"}[$interval])*8 <0",
          "functions": [],
          "group": {
            "filter": ""
          },
          "hide": false,
          "host": {
            "filter": ""
          },
          "interval": "",
          "intervalFactor": 1,
          "item": {
            "filter": ""
          },
          "legendFormat": "Received {{nic}}",
          "metric": "mysql_global_status_questions",
          "mode": 0,
          "options": {
            "showDisabledItems": false
          },
          "refId": "A",
          "step": 10
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "Network",
      "tooltip": {
        "shared": false,
        "sort": 2,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "binbps",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": null,
      "description": "",
      "fieldConfig": {
        "defaults": {
          "unit": "ms"
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 9,
        "w": 12,
        "x": 0,
        "y": 6
      },
      "hiddenSeries": false,
      "id": 19,
      "legend": {
        "alignAsTable": true,
        "avg": true,
        "current": true,
        "hideEmpty": false,
        "hideZero": false,
        "max": true,
        "min": false,
        "show": true,
        "total": false,
        "values": true
      },
      "lines": true,
      "linewidth": 1,
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.5.2",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "exemplar": true,
          "expr": "irate(windows_logical_disk_write_latency_seconds_total{instance=~\"$server\", volume !~\"HarddiskVolume.+\"}[$interval])",
          "interval": "",
          "legendFormat": "Write Latency  {{volume}}",
          "refId": "A"
        },
        {
          "exemplar": true,
          "expr": "irate(windows_logical_disk_read_latency_seconds_total{instance=~\"$server\", volume !~\"HarddiskVolume.+\"}[$interval])",
          "hide": false,
          "interval": "",
          "legendFormat": "Read Latency {{volume}}",
          "refId": "B"
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "Disk Latency",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "ms",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "Prometheus",
      "fieldConfig": {
        "defaults": {
          "unit": "bytes"
        },
        "overrides": []
      },
      "fill": 2,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 7
      },
      "hiddenSeries": false,
      "hideTimeOverride": false,
      "id": 8,
      "legend": {
        "alignAsTable": true,
        "avg": true,
        "current": false,
        "max": true,
        "min": false,
        "rightSide": false,
        "show": true,
        "total": true,
        "values": true
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null as zero",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.5.2",
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "application": {
            "filter": ""
          },
          "exemplar": true,
          "expr": "irate(windows_logical_disk_write_bytes_total{instance=~\"$server\", volume !~\"HarddiskVolume.+\"}[$interval])",
          "functions": [],
          "group": {
            "filter": ""
          },
          "hide": false,
          "host": {
            "filter": ""
          },
          "interval": "",
          "intervalFactor": 1,
          "item": {
            "filter": ""
          },
          "legendFormat": "Write {{volume}}",
          "metric": "mysql_global_status_questions",
          "mode": 0,
          "options": {
            "showDisabledItems": false
          },
          "refId": "A",
          "step": 20
        },
        {
          "application": {
            "filter": ""
          },
          "exemplar": true,
          "expr": "- irate(windows_logical_disk_read_bytes_total{instance=~\"$server\", volume !~\"HarddiskVolume.+\"}[$interval])",
          "functions": [],
          "group": {
            "filter": ""
          },
          "hide": false,
          "host": {
            "filter": ""
          },
          "interval": "",
          "intervalFactor": 1,
          "item": {
            "filter": ""
          },
          "legendFormat": "Read {{volume}}",
          "metric": "mysql_global_status_questions",
          "mode": 0,
          "options": {
            "showDisabledItems": false
          },
          "refId": "B",
          "step": 20
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "Hard drive load",
      "tooltip": {
        "shared": false,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "bytes",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "Prometheus",
      "fieldConfig": {
        "defaults": {
          "unit": "decbytes"
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 9,
        "w": 12,
        "x": 0,
        "y": 15
      },
      "hiddenSeries": false,
      "hideTimeOverride": false,
      "id": 15,
      "legend": {
        "avg": false,
        "current": true,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": true
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.5.2",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "application": {
            "filter": ""
          },
          "exemplar": true,
          "expr": "windows_logical_disk_free_bytes{instance=~\"$server\", volume !~\"HarddiskVolume.+\"}",
          "functions": [],
          "group": {
            "filter": ""
          },
          "hide": false,
          "host": {
            "filter": ""
          },
          "interval": "",
          "intervalFactor": 1,
          "item": {
            "filter": ""
          },
          "legendFormat": "free {{volume}}",
          "metric": "mysql_global_status_questions",
          "mode": 0,
          "options": {
            "showDisabledItems": false
          },
          "refId": "A",
          "step": 20
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "Hard disk free space",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "decbytes",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": null,
      "decimals": 1,
      "fieldConfig": {
        "defaults": {},
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 7,
        "w": 12,
        "x": 12,
        "y": 15
      },
      "hiddenSeries": false,
      "id": 17,
      "legend": {
        "alignAsTable": true,
        "avg": true,
        "current": false,
        "max": true,
        "min": false,
        "rightSide": false,
        "show": true,
        "total": false,
        "values": true
      },
      "lines": true,
      "linewidth": 1,
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.5.2",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "exemplar": true,
          "expr": "irate(windows_logical_disk_requests_queued{instance=~\"$server\", volume !~\"HarddiskVolume.+\"}[30m])",
          "interval": "",
          "legendFormat": "write {{volume}}",
          "refId": "A"
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "Disk Requests Queued",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "Prometheus",
      "fieldConfig": {
        "defaults": {
          "unit": "short"
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 24
      },
      "hiddenSeries": false,
      "hideTimeOverride": false,
      "id": 9,
      "legend": {
        "alignAsTable": true,
        "avg": true,
        "current": false,
        "max": true,
        "min": false,
        "rightSide": false,
        "show": true,
        "total": false,
        "values": true
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.5.2",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "application": {
            "filter": ""
          },
          "exemplar": true,
          "expr": "rate(windows_logical_disk_reads_total{instance=~\"$server\", volume !~\"HarddiskVolume.+\"}[2m]) + rate(windows_logical_disk_writes_total{instance=~\"$server\", volume !~\"HarddiskVolume.+\"}[2m])",
          "functions": [],
          "group": {
            "filter": ""
          },
          "hide": false,
          "host": {
            "filter": ""
          },
          "interval": "",
          "intervalFactor": 1,
          "item": {
            "filter": ""
          },
          "legendFormat": "i/o {{volume}}",
          "metric": "mysql_global_status_questions",
          "mode": 0,
          "options": {
            "showDisabledItems": false
          },
          "refId": "A",
          "step": 20
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "Hard disk i/o ops total",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    }
  ],
  "refresh": false,
  "schemaVersion": 27,
  "style": "dark",
  "tags": [],
  "templating": {
    "list": [
      {
        "auto": false,
        "auto_count": 500,
        "auto_min": "30s",
        "current": {
          "selected": false,
          "text": "30s",
          "value": "30s"
        },
        "description": null,
        "error": null,
        "hide": 2,
        "label": "Interval",
        "name": "interval",
        "options": [
          {
            "selected": true,
            "text": "30s",
            "value": "30s"
          }
        ],
        "query": "30s",
        "refresh": 2,
        "skipUrlSync": false,
        "type": "interval"
      },
      {
        "allValue": null,
        "current": {
          "selected": false,
          "text": "172.30.30.10:9182",
          "value": "172.30.30.10:9182"
        },
        "datasource": "Prometheus",
        "definition": "label_values(go_memstats_last_gc_time_seconds{job=\"$job\"}, instance)",
        "description": null,
        "error": null,
        "hide": 0,
        "includeAll": false,
        "label": "Server",
        "multi": false,
        "name": "server",
        "options": [],
        "query": {
          "query": "label_values(go_memstats_last_gc_time_seconds{job=\"$job\"}, instance)",
          "refId": "StandardVariableQuery"
        },
        "refresh": 1,
        "regex": "",
        "skipUrlSync": false,
        "sort": 0,
        "tagValuesQuery": "",
        "tags": [],
        "tagsQuery": "",
        "type": "query",
        "useTags": false
      },
      {
        "allValue": null,
        "current": {
          "selected": false,
          "text": "Axis-Qa-Lab",
          "value": "Axis-Qa-Lab"
        },
        "datasource": null,
        "definition": "label_values(windows_system_system_up_time, job)",
        "description": null,
        "error": null,
        "hide": 0,
        "includeAll": false,
        "label": "Job",
        "multi": false,
        "name": "job",
        "options": [],
        "query": {
          "query": "label_values(windows_system_system_up_time, job)",
          "refId": "StandardVariableQuery"
        },
        "refresh": 1,
        "regex": "/(.*)/",
        "skipUrlSync": false,
        "sort": 0,
        "tagValuesQuery": "",
        "tags": [],
        "tagsQuery": "",
        "type": "query",
        "useTags": false
      }
    ]
  },
  "time": {
    "from": "now-6h",
    "to": "now"
  },
  "timepicker": {
    "refresh_intervals": [
      "5s",
      "10s",
      "30s",
      "1m",
      "5m",
      "15m",
      "30m",
      "1h",
      "2h",
      "1d"
    ],
    "time_options": [
      "5m",
      "15m",
      "1h",
      "6h",
      "12h",
      "24h",
      "2d",
      "7d",
      "30d"
    ]
  },
  "timezone": "browser",
  "title": "Stress Lab Dashboard",
  "uid": "KJnz8-znk",
  "version": 20
}