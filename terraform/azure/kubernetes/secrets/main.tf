data "azurerm_key_vault" "vault" {
  name = var.keyvault_name
  resource_group_name = var.keyvault_resource_group_name
  
}

data "azurerm_key_vault_secret" "database_password" {
  name = "database-password" 
  key_vault_id = data.azurerm_key_vault.vault.id

  depends_on = [
    data.azurerm_key_vault.vault
  ]
}

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