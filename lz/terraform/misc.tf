data "azurerm_subscription" "this" {}

data "azurerm_client_config" "this" {}

data "azuread_client_config" "this" {}

module "rg_default" {
  source = "./rg"

  location = var.location
  prefix   = var.prefix

  tags = {
    usage   = "default"
    version = var.app_version
  }
}

module "rg_monitoring" {
  source = "./rg"

  location = var.location_monitoring
  prefix   = "${var.prefix}-monitoring"

  tags = {
    usage   = "monitoring"
    version = var.app_version
  }
}
