# MOAW Backend

Backend IaC for the Microsoft MAOW workshops.

## Getting started

Enable preview features:

```bash
# KEDA preview (AKS)
az feature register --namespace "Microsoft.ContainerService" --name "AKS-KedaPreview"

# Image Cleaner preview (AKS)
az feature register --namespace "Microsoft.ContainerService" --name "EnableImageCleanerPreview"

# Vertical Pod Autoscaler preview (AKS)
az feature register --namespace "Microsoft.ContainerService" --name "AKS-VPAPreview"
```
