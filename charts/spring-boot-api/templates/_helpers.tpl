{{- define "spring-boot-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "spring-boot-api.fullname" -}}
{{- printf "%s" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "spring-boot-api.labels" -}}
helm.sh/chart: {{ include "spring-boot-api.chart" . }}
{{ include "spring-boot-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "spring-boot-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "spring-boot-api.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "spring-boot-api.annotations" -}}
checksum/config: {{ (include (print $.Template.BasePath "/configmap.yaml") .) | sha256sum }}
checksum/secret: {{ (include (print $.Template.BasePath "/secret.yaml") .) | sha256sum }}
{{- end }}
