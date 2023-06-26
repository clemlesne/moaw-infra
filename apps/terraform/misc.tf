data "azurerm_subscription" "this" {}

data "azurerm_resource_group" "this" {
  name = var.rg_name
}

data "azurerm_kubernetes_cluster" "this" {
  name                = var.aks_name
  resource_group_name = data.azurerm_resource_group.this.name
}
