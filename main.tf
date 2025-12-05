resource "random_password" "readonly_key" {
  length           = 16
  special          = true
  override_special = "_~@"
}

# Read-only key for searching documents
resource "typesense_key" "readonly" {
  actions     = ["documents:search"]
  collections = [var.collection_prefix != "" ? "${var.collection_prefix}_.+" : "*"]
  value       = random_password.readonly_key.result
  description = "RO key ${var.collection_prefix}"
}

resource "random_password" "full_access_key" {
  length           = 16
  special          = true
  override_special = "_~@"
}

# Full access key with all permissions
resource "typesense_key" "full_access" {
  actions     = ["*"]
  collections = [var.collection_prefix != "" ? "${var.collection_prefix}_.+" : "*"]
  value       = random_password.full_access_key.result
  description = "Full access key ${var.collection_prefix}"
}

# Kubernetes secret with Typesense credentials
resource "kubernetes_secret_v1" "typesense_credentials" {
  count = var.secret_name != "" ? 1 : 0

  metadata {
    name      = var.secret_name
    namespace = var.namespace
  }

  type = "Opaque"

  data = {
    TYPESENSE_EXTERNAL_HOST      = var.typesense_external_host
    TYPESENSE_EXTERNAL_PORT      = var.typesense_external_port
    TYPESENSE_EXTERNAL_PROTO     = var.typesense_external_proto
    TYPESENSE_INTERNAL_HOST      = var.typesense_internal_host
    TYPESENSE_INTERNAL_PORT      = var.typesense_internal_port
    TYPESENSE_INTERNAL_PROTO     = var.typesense_internal_proto
    TYPESENSE_API_KEY_READ_ONLY  = typesense_key.readonly.value
    TYPESENSE_API_KEY_READ_WRITE = typesense_key.full_access.value
    TYPESENSE_COLLECTION_PREFIX  = var.collection_prefix != "" ? "${var.collection_prefix}_" : ""
  }
}
