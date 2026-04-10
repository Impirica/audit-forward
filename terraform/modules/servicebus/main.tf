resource "azurerm_servicebus_namespace" "audit_forward" {
  name                = "sb-audit-forward"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_servicebus_topic" "billing_events" {
  name         = "billing-events"
  namespace_id = azurerm_servicebus_namespace.audit_forward.id
}

resource "azurerm_servicebus_topic" "audit_events" {
  name         = "audit-events"
  namespace_id = azurerm_servicebus_namespace.audit_forward.id
}

resource "azurerm_servicebus_subscription" "billing_to_audit" {
  name               = "forward-to-audit-events"
  topic_id           = azurerm_servicebus_topic.billing_events.id
  max_delivery_count = 10
  forward_to         = azurerm_servicebus_topic.audit_events.name
}
