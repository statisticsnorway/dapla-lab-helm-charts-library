{{/* vim: set filetype=mustache: */}}

{{/* Template to generate a Service */}}
{{- define "library-chart.statefulset" -}}
apiVersion: apps/v1
kind: StatefulSet
spec:
  template:
    spec:
      containers:
        env:
          - name: STATBANK_BASE_URL
            value: "https://i.ssb.no/"
          - name: STAT_TEMPLATE_DEFAULT_REFERENCE
            value: "1.1.7"
          - name: PSEUDO_SERVICE_URL
            value: "https://dapla-pseudo-service.staging-bip-app.ssb.no/"
{{- end }}
