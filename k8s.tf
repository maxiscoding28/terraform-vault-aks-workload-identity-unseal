provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.support_repro.kube_config[0].host
  username               = azurerm_kubernetes_cluster.support_repro.kube_config[0].username
  password               = azurerm_kubernetes_cluster.support_repro.kube_config[0].password
  client_certificate     = base64decode(azurerm_kubernetes_cluster.support_repro.kube_config[0].client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.support_repro.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.support_repro.kube_config[0].cluster_ca_certificate)
}

resource "kubernetes_service_account" "support_repro" {
  metadata {
    name      = "${var.name_identifier}-sa-unseal"
    namespace = "default"

    annotations = {
      "azure.workload.identity/client-id" = azurerm_user_assigned_identity.support_repro.client_id
    }
  }
}
resource "kubernetes_secret" "vault_ent_license" {
  metadata {
    name = "vault-ent-license"
  }
  data = {
    license = var.vault_license
  }
}