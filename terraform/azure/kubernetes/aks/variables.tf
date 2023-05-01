variable "main_resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "main_vnet_name" {
  type = string
}

variable "k8s_subnet_name" {
  type = string
}

variable "k8s_main_name" {
  type = string
}

variable "default_node_pool_name" {
  type = string
}

variable "default_node_pool_node_count" {
  type = number
}

variable "default_node_pool_vm_size" {
  type = string
}

variable "dns_prefix" {
  type = string
}