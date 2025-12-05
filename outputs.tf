output "secret_name" {
  description = "The name of the created Kubernetes secret"
  value       = kubernetes_secret_v1.typesense_credentials.metadata[0].name
}

output "secret_namespace" {
  description = "The namespace of the created Kubernetes secret"
  value       = kubernetes_secret_v1.typesense_credentials.metadata[0].namespace
}
