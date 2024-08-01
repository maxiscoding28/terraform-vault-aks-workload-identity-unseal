provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.support_repro.kube_config[0].host
    username               = azurerm_kubernetes_cluster.support_repro.kube_config[0].username
    password               = azurerm_kubernetes_cluster.support_repro.kube_config[0].password
    client_certificate     = base64decode(azurerm_kubernetes_cluster.support_repro.kube_config[0].client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.support_repro.kube_config[0].client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.support_repro.kube_config[0].cluster_ca_certificate)
  }
}

resource "helm_release" "vault" {
  name       = "vault"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  values = [templatefile("${path.module}/values.yaml.tftpl", {
    key_vault_name = azurerm_key_vault.support_repro.name
    key_vault_key_name = azurerm_key_vault_key.support_repro.name
    service_account_name = kubernetes_service_account.support_repro.metadata[0].name
    tenant_id = var.tenant_id
    client_id = azurerm_user_assigned_identity.support_repro.client_id
  })]
}