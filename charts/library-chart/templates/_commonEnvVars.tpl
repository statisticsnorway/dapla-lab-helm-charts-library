{{/* vim: set filetype=mustache: */}}

{{/* Shared environment variables */}}
{{- define "library-chart.commonEnvVars" -}}
- name: STATBANK_BASE_URL
  value: "https://i.ssb.no/"
- name: STAT_TEMPLATE_DEFAULT_REFERENCE
  value: "1.1.8"
- name: PSEUDO_SERVICE_URL
  value: "https://dapla-pseudo-service.staging-bip-app.ssb.no/"
{{- end }}
