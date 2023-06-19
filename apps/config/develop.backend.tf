terraform {
  backend "azurerm" {
    container_name       = "nonprod"
    key                  = "develop-apps.tfstate"
    resource_group_name  = "moaw-clesne-tfstate"
    storage_account_name = "moawclesnetfstate"
  }
}
