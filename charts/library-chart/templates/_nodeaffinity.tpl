{{/* vim: set filetype=mustache: */}}

{{/*
We want to select the best node pool based on requested resources - i.e. prefer smallest node pool by memory -
such that we can get the best utilization of nodes which hopefully will mean lowest cost.
We will use preferredNodeAffinity. Note that nodeSeelctor can be used together with this, to avoid scheduling on unwanted nodes.
*/}}
{{- define "library-chart.nodeAffinity" -}}

{{- $nodepools := list -}}
{{- /* Ordered by memory */ -}}
{{- $nodepools = append $nodepools (dict "name" "highmem128gb" "cpu" 16000 "mem" 128 "labels" (dict "node-size" "medium" "node-type" "memory")) -}}
{{- $nodepools = append $nodepools (dict "name" "highmem256gb" "cpu" 32000 "mem" 256 "labels" (dict "node-size" "large" "node-type" "memory")) -}}
{{- $nodepools = append $nodepools (dict "name" "standard320gb" "cpu" 80000 "mem" 320 "labels" (dict "node-type" "cpu")) -}}
{{- $nodepools = append $nodepools (dict "name" "highmem640gb" "cpu" 80000 "mem" 640 "labels" (dict "node-size" "xlarge" "node-type" "memory")) -}}

{{- $requestedCpu := required "Argument must contain 'cpu' (in millicores)" .cpu | int -}}
{{- $requestedMem := required "Argument must contain 'memory' (in Gi)" .memory | int -}}
{{- $optimalNodePoolLabels := dict -}}

{{- range $nodepool := $nodepools -}}
  {{- /* Find the first nodepool in the list that has capacity  */ -}}
  {{- if and (not $optimalNodePoolLabels) (le $requestedCpu $nodepool.cpu) (le $requestedMem $nodepool.mem) -}}
    {{- $optimalNodePoolLabels = $nodepool.labels -}}
  {{- end -}}
{{- end -}}

{{- if $optimalNodePoolLabels -}}
nodeAffinity:
  preferredDuringSchedulingIgnoredDuringExecution:
  - weight: 80 {{- /* 80 is a bit random, but most to emphasise to k8s that this should really be considered */}}
    preference:
      nodeSelectorTerms:
      - matchExpressions:
        {{- range $key, $value := $optimalNodePoolLabels }}
        - key: {{ $key }}
          operator: In
          values:
          - {{ $value | quote }}
        {{- end }}
{{- end -}}
{{- end -}}