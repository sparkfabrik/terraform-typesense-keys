terraform {
  required_version = ">= 1.2"

  required_providers {
    typesense = {
      source  = "cysp/typesense"
      version = "0.0.5"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.4.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.21"
    }
  }
}
