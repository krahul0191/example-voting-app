   terraform {
   backend "azurerm" {
        resource_group_name  = "provision-scripts"
        storage_account_name = "ansiblestorage"
        container_name       = "terraform"
        key                  = "tdf/template/tfstate"
   }
}