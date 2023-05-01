data "azurerm_subnet" "k8s_subnet" {
  name = var.k8s_subnet_name
  virtual_network_name = var.main_vnet_name
  resource_group_name = var.main_resource_group_name
}

resource "azurerm_kubernetes_cluster" "k8s_main" {
  name                = var.k8s_main_name
  location            = var.location
  resource_group_name = var.main_resource_group_name
  dns_prefix = var.dns_prefix


  
  default_node_pool {
    name       = var.default_node_pool_name
    node_count = var.default_node_pool_node_count
    vm_size    = var.default_node_pool_vm_size
    vnet_subnet_id = data.azurerm_subnet.k8s_subnet.id
  }

  identity {
    type = "SystemAssigned"
  }
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.k8s_main.kube_config_raw

  sensitive = true
}