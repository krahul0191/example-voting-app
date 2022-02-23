# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used

resource "random_id" "log_analytics_workspace_name_suffix" {
  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "voteworkspacetest" {
  # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
  name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "votesolutiontest" {
  solution_name         = "ContainerInsights"
  location              = var.location
  resource_group_name   = var.rg_name
  workspace_resource_id = azurerm_log_analytics_workspace.voteworkspacetest.id
  workspace_name        = azurerm_log_analytics_workspace.voteworkspacetest.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = var.dns_prefix



  default_node_pool {
    name       = "agentpool"
    node_count = var.agent_count
    vm_size    = var.vmsize
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.voteworkspacetest.id
    }
  }

  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet"
  }

  tags = {
    Environment = "dev"
  }
}