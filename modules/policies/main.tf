data "azurerm_policy_set_definition" "azure_monitor" {
  display_name = "Enable Azure Monitor for VMs"
}

resource "azurerm_policy_assignment" "Policy-1" {
  name                 = "example-policy-assignment"
  scope                = "/subscriptions/632fe810-836a-4fe4-8a23-c258282b16af/resourceGroups/SBD-RG-NET"
  policy_definition_id = data.azurerm_policy_set_definition.azure_monitor
  description          = "Policy assignement to monitor all vms"
  display_name         = "VM monitor initiative"

  parameters = <<PARAMETERS
{
  "logAnalytics_1": {
    "value": "594b5afb-b888-4e75-bf99-8e0cbe22a460"
  }
}
PARAMETERS

}