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

variable "rg_name" {
  type        = string
  description = "The name of the default resource group."
}

variable "aks_api_host" {
  type        = string
}
