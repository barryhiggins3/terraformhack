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
  source          = "./modules/securitycentre"
  resname         = var.security_centre_RG_Name
  location        = var.location
  subscription_id = var.subscription_id

}
module "log_analytics" {
  source = "./modules/log_analytics"
  #name                = var.name
  #solution_plan_map   = var.solution_plan_map
  #resource_group_name = var.rg
  #location            = var.location



}
#odule "subnets" {
#source                = "./modules/virtual_net_nsg/subnet"

#resource_group        = var.resource_group_name
#virtual_network_name  = azurerm_virtual_network.vnet.name
#subnets               = var.networking_object.subnets
#tags                  = local.tags
#location              = var.location
#}

module "virtual_net_nsg" {
  source  = "./modules/virtual_net_nsg/nsg"
  resname = module.network_resourcegroup.resource_group_name
  # virtual_network_name      = azurerm_virtual_network.vnet.name
  # subnets                   = var.networking_object.subnets
  # tags                      = local.tags
  location = var.location
  # log_analytics_workspace   = var.log_analytics_workspace
  # diagnostics_map           = var.diagnostics_map

 rules = [
        {
            name                        = "allow-https"
            priority                    = "1000"
            protocol                    = "Tcp"
            source_address_prefix       = "VirtualNetwork"
            destination_port_ranges     = "443"
            description                 = "Allow HTTPS"
        },
        {
            name                        = "allow-ssh"
            priority                    = "1010"
            protocol                    = "Tcp"
            source_address_prefix       = "VirtualNetwork"
            destination_port_ranges     = "22"
            description                 = "Allow SSH"
        },
        {
            name                        = "allow-rdp"
            priority                    = "1020"
            protocol                    = "*"
            source_address_prefix       = "VirtualNetwork"
            destination_port_ranges     = "3389"
            description                 = "Allow RDP"
        },
        {
            name                        = "deny-all"
            priority                    = "4000"
            access                      = "Deny"
            protocol                    = "*"
            source_address_prefix       = "*"
            destination_port_ranges     = "*"
            description                 = "Deny unmatched inbound traffic"
        }
  ]
}