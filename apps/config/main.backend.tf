terraform {
  backend "azurerm" {
    container_name       = "prod"
    key                  = "main-apps.tfstate"
    resource_group_name  = "moaw-ylasorsa-tfstate"
    storage_account_name = "moawylasorsatfstate"
  }
}
