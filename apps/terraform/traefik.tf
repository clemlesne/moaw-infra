locals {
  traefik_name = "traefik"
}

resource "kubernetes_namespace" "traefik" {
  metadata {
    name = local.traefik_name
  }
}

resource "helm_release" "traefik" {
  atomic       = true
  chart        = "traefik"
  name         = local.traefik_name
  namespace    = kubernetes_namespace.traefik.metadata[0].name
  repository   = "https://traefik.github.io/charts"
  reset_values = true
  version      = "23.1.0"
  wait         = true

  values = [
    <<EOF
    service:
      spec:
        loadBalancerIP: ${azurerm_public_ip.traefik.ip_address}
      annotations:
        service.beta.kubernetes.io/azure-load-balancer-resource-group: ${data.azurerm_resource_group.this.name}
    ports:
      web:
        redirectTo: websecure
    autoscaling:
      enabled: true
      maxReplicas: 10
      minReplicas: 1
      metrics:
        - type: Resource
          resource:
            name: cpu
            target:
              averageUtilization: 50
              type: Utilization
        - type: Resource
          resource:
            name: memory
            target:
              averageUtilization: 50
              type: Utilization
    EOF
  ]

  depends_on = [azurerm_public_ip.traefik, azurerm_role_assignment.traefik]
}

resource "random_string" "dns_suffix" {
  length  = 12
  numeric = true
  special = false
  upper   = false
}

resource "azurerm_public_ip" "traefik" {
  allocation_method   = "Static"
  domain_name_label   = "${data.azurerm_resource_group.this.name}-${random_string.dns_suffix.result}"
  location            = data.azurerm_resource_group.this.location
  name                = "${data.azurerm_resource_group.this.name}-${local.traefik_name}"
  resource_group_name = data.azurerm_resource_group.this.name
  sku                 = "Standard"
  zones               = var.zones

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_role_assignment" "traefik" {
  principal_id         = data.azurerm_kubernetes_cluster.this.identity.0.principal_id
  role_definition_name = "Network Contributor"
  scope                = data.azurerm_resource_group.this.id
}
