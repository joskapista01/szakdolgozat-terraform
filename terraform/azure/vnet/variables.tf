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

variable "address_space" {
  type = list
}
