# Creates the resource group that contains the azure resources
resource "azurerm_resource_group" "main-reource-group" {
  name     = var.main_resource_group_name
  location = var.location
}