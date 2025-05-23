{{/* vim: set filetype=mustache: */}}


{{/* Create the name of the secret Git to use */}}
{{- define "library-chart.secretNameGit" -}}
{{- if .Values.gitConfig.git.enabled }}
{{- $name:= (printf "%s-secretgit" (include "library-chart.fullname" .) )  }}
{{- default $name .Values.gitConfig.git.secretName }}
{{- else }}
{{- default "default" .Values.gitConfig.git.secretName }}
{{- end }}
{{- end }}

{{/* Template to generate a secret for git */}}
{{- define "library-chart.secretGit" -}}
{{- if .Values.gitConfig.git.enabled -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "library-chart.secretNameGit" . }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
stringData:
  GIT_USER_NAME: "{{ .Values.gitConfig.git.name }}"
  GIT_USER_MAIL: "{{ .Values.gitConfig.git.email }}"
  GIT_CREDENTIALS_CACHE_DURATION: "{{ .Values.gitConfig.git.cache }}"
  GIT_PERSONAL_ACCESS_TOKEN: "{{ .Values.gitConfig.github.token }}"
  GIT_REPOSITORY: "{{ .Values.gitConfig.github.repository }}"
  GIT_BRANCH: "{{ .Values.gitConfig.github.branch }}"
  SSB_PROJECT_BUILD_ON_LAUNCH: "{{ .Values.gitConfig.github.build }}"
{{- end }}
{{- end }}

{{/* Create the name of the secret Token to use */}}
{{- define "library-chart.secretNameToken" -}}
{{- $name:= (printf "%s-secrettoken" (include "library-chart.fullname" .) )  }}
{{- default $name (printf "%s-secrettoken" (include "library-chart.fullname" .) )  }}
{{- end }}

{{/* Template to generate a secret for token */}}
{{- define "library-chart.secretToken" -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "library-chart.secretNameToken" . }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
stringData:
  PASSWORD: "{{ .Values.security.password }}"
{{- end }}


{{/* Create the name of the config map OIDC to use */}}
{{- define "library-chart.secretNameOidc" -}}
{{- if .Values.oidc.enabled }}
{{- $name:= (printf "%s-secretoidc" (include "library-chart.fullname" .) )  }}
{{- default $name .Values.oidc.secretName }}
{{- else }}
{{- default "default" .Values.oidc.secretName }}
{{- end }}
{{- end }}

{{/* Template to generate a Secret for OIDC */}}
{{- define "library-chart.secretOidc" -}}
{{- if and (.Values.oidc.enabled) (.Values.userAttributes) -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "library-chart.secretNameOidc" . }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
stringData:
  OIDC_TOKEN_EXCHANGE_URL: "{{ .Values.oidc.tokenExchangeUrl }}"
  {{ .Values.userAttributes.environmentVariableName }}: "{{ .Values.userAttributes.value }}"
{{- end }}
{{- end }}
