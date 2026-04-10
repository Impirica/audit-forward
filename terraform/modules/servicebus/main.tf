resource "azurerm_servicebus_namespace" "service_bus" {
  name                = "sb-audit-forward"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_servicebus_topic" "domain_events" {
  for_each     = var.domain_topics
  name         = each.value
  namespace_id = azurerm_servicebus_namespace.service_bus.id
}

resource "azurerm_servicebus_topic" "audit_events" {
  name                  = "audit-events"
  namespace_id          = azurerm_servicebus_namespace.service_bus.id
  partitioning_enabled  = true
  max_size_in_megabytes = 5120
}

resource "azurerm_servicebus_subscription" "audit_processor" {
  name               = "audit-processor"
  topic_id           = azurerm_servicebus_topic.audit_events.id
  max_delivery_count = 10

  dead_lettering_on_message_expiration = true

  default_message_ttl = "P1D" # 1 day

  lock_duration = "PT5M" # 5 minutes
}

resource "azurerm_servicebus_subscription" "audit_forward" {
  for_each           = var.domain_topics
  name               = "audit-forward"
  topic_id           = azurerm_servicebus_topic.domain_events[each.key].id
  max_delivery_count = 10

  forward_to = azurerm_servicebus_topic.audit_events.name

  forward_dead_lettered_messages_to = null

  default_message_ttl = "P1D" # 1 day  
}
