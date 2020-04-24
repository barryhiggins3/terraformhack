#resource "azurerm_network_security_group" "network_security_group" {
# name                = "acceptanceTestSecurityGroup1"
#location            = var.location
#resource_group_name = var.resname
#}

#resource "azurerm_network_ddos_protection_plan" "ddos_protection_plan" {
# name                = "${var.vnetname}-ddosplan"
#location            = var.location
# resource_group_name = var.resname
#}

resource "azurerm_virtual_network" "virtual_network" {
  name                = var.vnetname
  location            = var.location
  resource_group_name = var.resname
  address_space       = var.address_space
  dns_servers         = var.dns_servers

  #ddos_protection_plan {
  # id     = azurerm_network_ddos_protection_plan.ddos_protection_plan.id
  #  enable = var.ddos_enabled
  # }

  subnet {
    name           = "web_tier"
    address_prefix = var.web_tier
  }

  subnet {
    name           = "app_tier"
    address_prefix = var.app_tier
  }

  subnet {
    name           = "data_tier"
    address_prefix = var.data_tier
    #   security_group = azurerm_network_security_group.example.id
  }

  tags = var.tags
}
