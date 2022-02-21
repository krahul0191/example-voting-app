   terraform {
   backend "azurerm" {
        resource_group_name  = var.rg_name
        storage_account_name = "azurestorage"
        container_name       = "terraform"
        key                  = "tfstate"
   }
}
