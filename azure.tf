provider "azurerm" {
  features {}
  skip_provider_registration = true
}
resource "azurerm_resource_group" "support_repro" {
  name     = "${var.name_identifier}-rg"
  location = "East US"
}
data "azurerm_client_config" "current" {}
resource "azurerm_role_assignment" "key_vault_admin" {
  scope                = azurerm_resource_group.support_repro.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}
resource "azurerm_key_vault" "support_repro" {
  depends_on                = [azurerm_role_assignment.key_vault_admin]
  name                      = "kv-${var.name_identifier}"
  location                  = "East US"
  resource_group_name       = azurerm_resource_group.support_repro.name
  tenant_id                 = var.tenant_id
  sku_name                  = "standard"
  enable_rbac_authorization = true
}
resource "azurerm_key_vault_key" "support_repro" {
  name         = "key-${var.name_identifier}"
  key_vault_id = azurerm_key_vault.support_repro.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["encrypt", "decrypt", "sign", "verify", "wrapKey", "unwrapKey"]
}
resource "azurerm_user_assigned_identity" "support_repro" {
  name                = "${var.name_identifier}-unseal-user"
  resource_group_name = azurerm_resource_group.support_repro.name
  location            = "East US"
}
resource "azurerm_role_assignment" "key_vault_user_unseal" {
  principal_id         = azurerm_user_assigned_identity.support_repro.principal_id
  role_definition_name = "Key Vault Crypto User"
  scope                = azurerm_key_vault.support_repro.id
}
resource "azurerm_kubernetes_cluster" "support_repro" {
  name                      = "${var.name_identifier}-cluster"
  location                  = azurerm_resource_group.support_repro.location
  resource_group_name       = azurerm_resource_group.support_repro.name
  dns_prefix                = var.name_identifier
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    upgrade_settings {
      max_surge = "10%"
    }
  }
  identity {
    type = "SystemAssigned"
  }
}
resource "azurerm_federated_identity_credential" "support_repro" {
  name                = "${var.name_identifier}-fed-credential"
  resource_group_name = azurerm_resource_group.support_repro.name
  audience            = ["api://AzureADTokenExchange"]
  subject             = "system:serviceaccount:${kubernetes_service_account.support_repro.metadata[0].namespace}:${kubernetes_service_account.support_repro.metadata[0].name}"
  issuer              = azurerm_kubernetes_cluster.support_repro.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.support_repro.id
}
output "inputs_for_az_aks_get_credentials" {
  value = {
    resource_group_name = azurerm_resource_group.support_repro.name
    cluster_name        = azurerm_kubernetes_cluster.support_repro.name
  }
}