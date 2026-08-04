{{/* vim: set filetype=mustache: */}}

{{/*
We want liveness and readiness probes that do not cause the service to restart
if it is doing some medium/heavy computing. We therefore define these with
quite a high timeout and period. An eager startup probe is defined to mark the
container as ready ASAP during startup.
*/}}
{{- define "library-chart.probes" -}}
startupProbe:
  httpGet:
    path: /
    port: {{ .Values.networking.service.port }}
  failureThreshold: 60
  periodSeconds: 5
livenessProbe:
  failureThreshold: 3
  httpGet:
    path: /
    port: {{ .Values.networking.service.port }}
    scheme: HTTP
  periodSeconds: 60
  successThreshold: 1
  timeoutSeconds: 15
readinessProbe:
  failureThreshold: 3
  httpGet:
    path: /
    port: {{ .Values.networking.service.port }}
    scheme: HTTP
  periodSeconds: 60
  successThreshold: 1
  timeoutSeconds: 15
{{- end -}}
