terraform {
  backend "azurerm" {
    container_name       = "prod"
    key                  = "main-k8s.tfstate"
    resource_group_name  = "moaw-clesne-tfstate"
    storage_account_name = "moawclesnetfstate"
  }
}
