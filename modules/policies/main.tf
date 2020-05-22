data "azurerm_policy_set_definition" "azure_monitor" {
  display_name = "Enable Azure Monitor for VMs"
}

resource "azurerm_policy_assignment" "Policy-1" {
  name  = "example-policy-assignment"
  scope = var.resid
  # policy_definition_id = data.azurerm_policy_set_definition.example.id
  policy_definition_id = data.azurerm_policy_set_definition.azure_monitor.id
  description          = "Policy assignement to monitor all vms"
  display_name         = "VM monitor initiative"
  location             = "uksouth"
  identity {
    type = "SystemAssigned"
  }
  parameters = <<PARAMETERS
{
  "logAnalytics_1": {
    "value": "594b5afb-b888-4e75-bf99-8e0cbe22a460"
  }
}
PARAMETERS

}
