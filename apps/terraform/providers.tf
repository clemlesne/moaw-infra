terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
    azuread = {
      source  = "hashicorp/azuread"
    }
    azapi = {
      source  = "Azure/azapi"
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

provider "kubernetes" {
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.this.kube_config.0.cluster_ca_certificate)
  host                   = var.aks_api_host

  # Using kubelogin to get an AAD token for the cluster
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "kubelogin"
    args = [
      "get-token",
      "--client-id", var.spn_client_id,
      "--client-secret", var.spn_client_secret,
      "--login", "spn",
      "--server-id", data.azuread_service_principal.aks.application_id,
      "--tenant-id", data.azurerm_subscription.this.tenant_id,
    ]
  }
}

provider "helm" {
  kubernetes {
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.this.kube_config.0.cluster_ca_certificate)
    host                   = var.aks_api_host

    # Using kubelogin to get an AAD token for the cluster
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "kubelogin"
      args = [
        "get-token",
        "--client-id", var.spn_client_id,
        "--client-secret", var.spn_client_secret,
        "--login", "spn",
        "--server-id", data.azuread_service_principal.aks.application_id,
        "--tenant-id", data.azurerm_subscription.this.tenant_id,
      ]
    }
  }
}
