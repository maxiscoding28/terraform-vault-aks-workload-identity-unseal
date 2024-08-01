## Summary
This module can be used to "quickly" provision an enterprise Vault cluster in Azure's managed kubernetes service AKS. The Vault uses Azure Key Vault for its seal and authentication to managed the key is delegated via [workload identity](https://learn.microsoft.com/en-us/azure/aks/workload-identity-overview?tabs=dotnet).

## Instructions
1. Provide the following variables to the module:
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name_identifier"></a> [name\_identifier](#input\_name\_identifier) | A unique name identifier used to distinguish created resources. | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Your azure subscription ID | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | # If you need to verify this, navigate here in the portal: https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/Properties | `string` | n/a | yes |
| <a name="input_vault_license"></a> [vault\_license](#input\_vault\_license) | Enterprise Vault License | `string` | n/a | yes |

2. `terraform init`

3. `terraform apply`


## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.114.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.14.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.31.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_federated_identity_credential.support_repro](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) | resource |
| [azurerm_key_vault.support_repro](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_key.support_repro](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_kubernetes_cluster.support_repro](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_resource_group.support_repro](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.key_vault_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.key_vault_user_unseal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.support_repro](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [helm_release.vault](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_secret.vault_ent_license](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_service_account.support_repro](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name_identifier"></a> [name\_identifier](#input\_name\_identifier) | A unique name identifier used to distinguish created resources. | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Your azure subscription ID | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | # If you need to verify this, navigate here in the portal: https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/Properties | `string` | n/a | yes |
| <a name="input_vault_license"></a> [vault\_license](#input\_vault\_license) | Enterprise Vault License | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_inputs_for_az_aks_get_credentials"></a> [inputs\_for\_az\_aks\_get\_credentials](#output\_inputs\_for\_az\_aks\_get\_credentials) | n/a |
