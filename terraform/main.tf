resource "azurerm_resource_group" "rg-audit-forward" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "servicebus" {
  source = "./modules/servicebus"

  # Pass resource group details from the root module
  resource_group_name = azurerm_resource_group.rg-audit-forward.name
  location            = azurerm_resource_group.rg-audit-forward.location
  tags                = var.tags
}
