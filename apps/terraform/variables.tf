variable "zones" {
  description = "Availability zones to use"
  type        = list(number)
}

variable "app_version" {
  description = "Version tag for resources"
  type        = string
}

variable "aks_name" {
  type        = string
  description = "The name of the Kubernetes cluster."
}

variable "aks_api_host" {
  description = "The full URL of the Kubernetes cluster API."
  type        = string
}

variable "rg_name" {
  type        = string
  description = "The name of the default resource group."
}

variable "spn_client_id" {
  description = "The client ID of the service principal."
  type        = string
}

variable "spn_client_secret" {
  description = "The client secret of the service principal."
  sensitive   = true
  type        = string
}
