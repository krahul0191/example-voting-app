# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used

resource "azurerm_resource_group" "resource_group" {
  name     = var.rg_name
  location = var.location
  
}

# Creating Azure Container Registry...

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  sku                 = "Premium"
  admin_enabled       = false
  georeplications {
    location                = var.location
    zone_redundancy_enabled = true
    tags                    = {}
  }
}
