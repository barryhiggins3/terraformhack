provider "azurerm" {
  version = ">= 2.0"
  features {}
}
terraform {
  backend "azurerm" {
    storage_account_name = "modalitytfstate"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = var.location
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

module "network_resourcegroup" {
  source   = "./modules/resourcegroups"
  resname  = var.network_resourcegroup_name
  location = var.location
}
module "network" {
  source   = "./modules/network"
  resname  = module.network_resourcegroup.resource_group_name
  location = var.location
}
module "security_centre" {
  source = "./modules/securitycentre"
  resname = var.security_centre_RG_Name
  location = var.location
  subscription_id = var.subscription_id

}
module "log_analytics" {
    source                  = "https://github.com/aztfmod/log_analytics.git?ref=latest"

    name                              = var.name
    solution_plan_map                 = var.solutions
    resname                           = azurerm_resource_group.example.name
    location                          = var.location
    tags                              = var.tags

}

