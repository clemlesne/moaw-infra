terraform {
  backend "azurerm" {
    container_name       = "prod"
    key                  = "main-azure.tfstate"
    resource_group_name  = "moaw-clesne-tfstate"
    storage_account_name = "moawclesnetfstate"
  }
}
