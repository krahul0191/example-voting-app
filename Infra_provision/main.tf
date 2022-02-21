terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.97.0"
    }
  }
}

provider "azurerm" {
  version = "~>2.97.0"
  features {}
  skip_provider_registration = true
}

resource "azurerm_resource_group" "resource_group" {
  name     = var.rg_name
  location = var.location
  
}

module "acr" {
source              = "./modules/acr"
acr_name =  var.acr_name
rg_name  = var.rg_name
location = var.location
location1 = var.location1

}

module "aks" {

source   = "./modules/aks"
aks_name =  var.aks_name
rg_name  = var.rg_name
location = var.location
}
