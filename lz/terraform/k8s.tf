data "azurerm_kubernetes_service_versions" "this" {
  include_preview = false
  location        = module.rg_default.location
}

resource "random_string" "temporary_name_for_rotation" {
  length  = 12
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_kubernetes_cluster" "this" {
  azure_policy_enabled      = true
  dns_prefix                = replace(lower(module.rg_default.name), "/[^a-zA-Z0-9]/", "")
  image_cleaner_enabled     = true
  kubernetes_version        = data.azurerm_kubernetes_service_versions.this.latest_version
  local_account_disabled    = true
  location                  = module.rg_default.location
  name                      = module.rg_default.name
  oidc_issuer_enabled       = true
  resource_group_name       = module.rg_default.name
  workload_identity_enabled = true
  automatic_channel_upgrade = "patch"

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    enable_auto_scaling         = true
    max_count                   = 10
    min_count                   = 1
    name                        = "default"
    os_disk_type                = "Ephemeral"
    os_sku                      = "CBLMariner"
    temporary_name_for_rotation = random_string.temporary_name_for_rotation.result
    vm_size                     = "Standard_D8a_v4"
    zones                       = var.zones
  }

  azure_active_directory_role_based_access_control {
    azure_rbac_enabled = true
    managed            = true
    tenant_id          = data.azurerm_subscription.this.tenant_id
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  }

  microsoft_defender {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  }

  workload_autoscaler_profile {
    keda_enabled                    = true
    vertical_pod_autoscaler_enabled = true
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "calico"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "user" {
  enable_auto_scaling   = true
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  max_count             = 10
  min_count             = 1
  name                  = "user"
  os_disk_type          = "Ephemeral"
  os_sku                = "CBLMariner"
  vm_size               = "Standard_D8a_v4"
  zones                 = var.zones
}

resource "azurerm_role_assignment" "sys_admin_user" {
  principal_id         = data.azuread_client_config.this.object_id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
  scope                = azurerm_kubernetes_cluster.this.id
}
