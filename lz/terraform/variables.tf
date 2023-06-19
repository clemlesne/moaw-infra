variable "location" {
  description = "Azure region for compute and storage"
  type        = string
}

variable "location_monitoring" {
  description = "Azure region for monitoring ; should be different from 'location' variable"
  type        = string
}

variable "prefix" {
  description = "Prefix to apply to all resources"
  type        = string
}

variable "zones" {
  description = "Availability zones to use"
  type        = list(number)
}

variable "app_version" {
  description = "Version tag for resources"
  type        = string
}
