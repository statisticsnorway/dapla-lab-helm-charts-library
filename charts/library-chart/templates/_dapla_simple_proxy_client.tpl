{{- define "library-chart.daplaSimpleProxyClientName" -}}
{{- $name:= (printf "%s-client-redirect-uri" (include "library-chart.fullname" .) )  }}
{{- default $name .Values.security.oauth2.daplaSimpleProxyClientName }}
{{- end }}

{{- define "library-chart.daplaSimpleProxyClientSecretName" -}}
{{- $name:= (printf "%s-oauth2proxy" (include "library-chart.fullname" .) )  }}
{{- default $name .Values.security.oauth2.daplaSimpleProxyClientName }}
{{- end }}

{{- define "library-chart.daplaSimpleProxyClient" -}}
apiVersion: dapla.ssb.no/v1alpha1
kind: SimpleProxyClient
metadata:
  name: {{ include "library-chart.daplaSimpleProxyClientName" . }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
spec:
  redirectUris:
    - "https://{{ .Values.istio.hostname }}/oauth2/callback"
    {{- if .Values.istio.extraHostname }}
    - "https://{{ .Values.istio.serviceSubDomain}}.{{ .Values.istio.extraHostname }}/oauth2/callback"
    {{- end }}
  secretName: {{ include "library-chart.daplaSimpleProxyClientSecretName" . | quote }}

{{- end }}