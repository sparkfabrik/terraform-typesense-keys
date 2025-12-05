# Typesense Keys Module

This module creates Typesense API keys and a Kubernetes secret for Drupal projects.

## What it creates

- **Read-only API key**: For document search operations
- **Full access API key**: For all Typesense operations  
- **Kubernetes secret**: Contains host URL, API keys, and collection prefix

## Diagram

flowchart LR
  typesense_module["Typesense Keys Module"] -- "generates" --> api_keys["API Keys (RO + Full Access)"]
  api_keys -- "stored in" --> k8s_secret["Kubernetes Secret"]
  terraform_config["Terraform Config"] -- "configures" --> typesense_provider["Typesense Provider"]
  typesense_provider -- "manages" --> typesense_module
  drupal_projects["Drupal Projects"] -- "consumes" --> k8s_secret


## Usage

```terraform
module "typesense_keys" {
  source               = "github.com/sparkfabrik/terraform-typesense-keys?ref=X.Y.Z"
  
  collection_prefix = "myproject"
  namespace         = "myproject-1200-stage"
  secret_name       = "drupal-stage-1200-typesense"
  typesense_host    = "https://typesense.example.com"
}
```

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.21 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.4.3 |
| <a name="provider_typesense"></a> [typesense](#provider\_typesense) | 0.0.5 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.21 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.4.3 |
| <a name="requirement_typesense"></a> [typesense](#requirement\_typesense) | 0.0.5 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_collection_prefix"></a> [collection\_prefix](#input\_collection\_prefix) | The collection prefix for Typesense keys | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Kubernetes namespace where the secret will be created | `string` | n/a | yes |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | The name of the Kubernetes secret | `string` | n/a | yes |
| <a name="input_typesense_external_host"></a> [typesense\_external\_host](#input\_typesense\_external\_host) | The Typesense host URL | `string` | n/a | yes |
| <a name="input_typesense_external_port"></a> [typesense\_external\_port](#input\_typesense\_external\_port) | The Typesense port | `number` | `443` | no |
| <a name="input_typesense_external_proto"></a> [typesense\_external\_proto](#input\_typesense\_external\_proto) | The Typesense protocol | `string` | `"https"` | no |
| <a name="input_typesense_internal_host"></a> [typesense\_internal\_host](#input\_typesense\_internal\_host) | The Typesense host URL | `string` | n/a | yes |
| <a name="input_typesense_internal_port"></a> [typesense\_internal\_port](#input\_typesense\_internal\_port) | The Typesense port | `number` | `8108` | no |
| <a name="input_typesense_internal_proto"></a> [typesense\_internal\_proto](#input\_typesense\_internal\_proto) | The Typesense protocol | `string` | `"http"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_name"></a> [secret\_name](#output\_secret\_name) | The name of the created Kubernetes secret |
| <a name="output_secret_namespace"></a> [secret\_namespace](#output\_secret\_namespace) | The namespace of the created Kubernetes secret |

## Resources

| Name | Type |
|------|------|
| [kubernetes_secret_v1.typesense_credentials](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) | resource |
| [random_password.full_access_key](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.readonly_key](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [typesense_key.full_access](https://registry.terraform.io/providers/cysp/typesense/0.0.5/docs/resources/key) | resource |
| [typesense_key.readonly](https://registry.terraform.io/providers/cysp/typesense/0.0.5/docs/resources/key) | resource |

## Modules

No modules.

<!-- END_TF_DOCS -->