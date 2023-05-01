
resource "azurerm_virtual_network" "main_vnet" {
  name                = var.main_vnet_name
  location            = var.location
  resource_group_name = var.main_resource_group_name
  address_space       = var.address_space
}

resource "azurerm_subnet" "k8s_subnet" {
  resource_group_name = var.main_resource_group_name
  virtual_network_name = var.main_vnet_name
  name = var.k8s_subnet_name
  address_prefixes = ["10.10.0.0/24"]
  service_endpoints    = ["Microsoft.Sql"]
  depends_on = [
    azurerm_virtual_network.main_vnet
  ]
}