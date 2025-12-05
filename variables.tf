variable "collection_prefix" {
  description = "The collection prefix for Typesense keys"
  type        = string
  default     = ""
}

variable "namespace" {
  description = "The Kubernetes namespace where the secret will be created"
  type        = string
}

variable "secret_name" {
  description = "The name of the Kubernetes secret"
  type        = string
  default     = ""
}

variable "typesense_external_host" {
  description = "The Typesense host URL"
  type        = string
}

variable "typesense_external_port" {
  description = "The Typesense port"
  type        = number
  default     = 443
}

variable "typesense_external_proto" {
  description = "The Typesense protocol"
  type        = string
  default     = "https"
}

variable "typesense_internal_host" {
  description = "The Typesense host URL"
  type        = string
}

variable "typesense_internal_port" {
  description = "The Typesense port"
  type        = number
  default     = 8108
}

variable "typesense_internal_proto" {
  description = "The Typesense protocol"
  type        = string
  default     = "http"
}
