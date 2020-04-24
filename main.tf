provider "azurerm" {
  version = ">= 2.0"
  features {}
}
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}
module "storage" {
  source               = "./modules/storageaccounts"
  storage_account_name = "modalityhacksto4"
  location             = azurerm_resource_group.example.location
  resourcegroupname    = azurerm_resource_group.example.name
}
module "storage2" {
  source               = "./modules/storageaccounts"
  storage_account_name = "modalityhacksto5"
  Replication_type     = "GRS"
  location             = azurerm_resource_group.example.location
  resourcegroupname    = azurerm_resource_group.example.name
}
terraform {
  backend "azurerm" {
    storage_account_name = "modalitytfstate"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}