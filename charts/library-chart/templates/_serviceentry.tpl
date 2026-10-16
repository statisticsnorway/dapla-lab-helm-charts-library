{{/* vim: set filetype=mustache: */}}

{{/* Template to generate a ServiceEntry and an FQDNNetworkPolicy */}}
{{- define "library-chart.serviceentry" -}}
{{- if .Values.security.serviceEntry.enabled -}}
apiVersion: networking.istio.io/v1beta1
kind: ServiceEntry
metadata:
  name: {{ include "library-chart.fullname" . }}-serviceentry
  namespace: {{ .Release.Namespace }}
spec:
  exportTo:
  - .
  hosts:
  {{- toYaml .Values.security.serviceEntry.hosts | nindent 2 }}
  location: MESH_EXTERNAL
  ports:
  - name: https
    number: 443
    protocol: HTTPS
  resolution: NONE
---
apiVersion: networking.gke.io/v1alpha1
kind: FQDNNetworkPolicy
metadata:
  name: {{ include "library-chart.fullname" . }}-serviceentry
  namespace: {{ .Release.Namespace }}
spec:
  podSelector:
    matchLabels:
      {{- include "library-chart.selectorLabels" . | nindent 6 }}
  egress:
  - matches:
    {{- range .Values.security.serviceEntry.hosts }}
    - name: {{ . | quote }}
    {{- end }}
    ports:
    - protocol: TCP
      port: 443
{{- end -}}
{{- end -}}
