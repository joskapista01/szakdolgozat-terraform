# Uses a keyvault to query secrets
data "azurerm_key_vault" "vault" {
  name = var.keyvault_name
  resource_group_name = var.keyvault_resource_group_name
  
}

# Queries the database password from the keyvault
data "azurerm_key_vault_secret" "database_password" {
  name = "database-password" 
  key_vault_id = data.azurerm_key_vault.vault.id

  depends_on = [
    data.azurerm_key_vault.vault
  ]
}

# Creates a kubernetes secret that contains the database password
resource "kubernetes_secret" "database_password" {
  metadata {
    name = "database-password"
    namespace = "apps"
  }

  data = {
    DATABASE_PASSWORD = data.azurerm_key_vault_secret.database_password.value
  }

  depends_on = [
    data.azurerm_key_vault_secret.database_password
  ]
}