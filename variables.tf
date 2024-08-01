variable "tenant_id" {
  type        = string
  description = "If you need to verify this, navigate here in the portal: https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/Properties"
}
variable "subscription_id" {
  type        = string
  description = "Your azure subscription ID"
}
variable "name_identifier" {
  type        = string
  description = "A unique name identifier used to distinguish created resources."
}
variable "vault_license" {
  type        = string
  description = "Enterprise Vault License"
}