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

resource "azurerm_sql_server" "database_server" {
  name                         = "minecrafthosting"
  resource_group_name          = var.main_resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "Admin1234567"
  administrator_login_password = data.azurerm_key_vault_secret.database_password.value

  depends_on = [
    data.azurerm_key_vault_secret.database_password
  ]

}

resource "azurerm_sql_database" "main_db" {
  name                = "main"
  resource_group_name = var.main_resource_group_name
  location            = var.location
  server_name         = azurerm_sql_server.database_server.name

  depends_on = [
    azurerm_sql_server.database_server
  ]
}

data "azurerm_subnet" "k8s_subnet" {
  name = var.k8s_subnet_name
  virtual_network_name = var.main_vnet_name
  resource_group_name = var.main_resource_group_name
}

resource "azurerm_mssql_virtual_network_rule" "example" {
  name      = "k8s-subnet-rule"
  server_id = azurerm_sql_server.database_server.id
  subnet_id = data.azurerm_subnet.k8s_subnet.id

  depends_on = [
    azurerm_sql_server.database_server
  ]
}