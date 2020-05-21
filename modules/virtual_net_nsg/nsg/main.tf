resource "azurerm_network_security_group" "nsg_example" {
  name                = "nsg_test1"
  location            = var.location
  resource_group_name = var.resname


  tags = var.tags
}
resource "azurerm_network_security_rule" "example_rule_1" {
  name                        = "test123"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resname
  network_security_group_name = azurerm_network_security_group.nsg_example.name
}