terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
    azuread = {
      source  = "hashicorp/azuread"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
    }
    helm = {
      source  = "hashicorp/helm"
    }
    random = {
      source  = "hashicorp/random"
    }
    time = {
      source  = "hashicorp/time"
    }
  }
}

provider "azurerm" {
  features {}
}
