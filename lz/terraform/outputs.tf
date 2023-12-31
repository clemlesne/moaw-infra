output "aks_api_host" {
  description = "The full URL of the Kubernetes cluster API."
  sensitive   = true
  value       = azurerm_kubernetes_cluster.this.kube_config.0.host
}

output "aks_name" {
  description = "The name of the Kubernetes cluster."
  value       = azurerm_kubernetes_cluster.this.name
}

output "rg_default_name" {
  description = "The name of the default resource group."
  value       = module.rg_default.name
}

output "rg_monitoring_name" {
  description = "The name of the monitoring resource group."
  value       = module.rg_monitoring.name
}
