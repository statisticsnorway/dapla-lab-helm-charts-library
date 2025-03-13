{{- define "library-chart.podDisruptionBudget" -}}
{{ if .Values.podDisruptionBudget.enabled }}
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: {{ include "library-chart.fullname" . }}
spec:
  minAvailable: 100%
  selector:
    matchLabels:
      {{- include "library-chart.selectorLabels" . | nindent 6 }}
{{end}}
{{end}}