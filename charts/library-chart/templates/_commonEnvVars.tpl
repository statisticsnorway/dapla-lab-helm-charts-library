{{/* vim: set filetype=mustache: */}}

{{/* Shared environment variables */}}
{{- define "library-chart.commonEnvVars" -}}
- name: STAT_TEMPLATE_DEFAULT_REFERENCE
  value: "1.4.0"
{{- end }}
