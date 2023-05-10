terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.54.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.20.0"      
    }
  }
}

provider "azurerm" {
    features {
      
    }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}