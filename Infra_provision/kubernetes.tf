# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used

#creating Azure Kubernetes cluster...
resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = var.aks_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = "kubes"

  default_node_pool {
    name       = "agentpool"
    node_count = 3
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "dev"
  }
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config_raw
  sensitive = true
}

