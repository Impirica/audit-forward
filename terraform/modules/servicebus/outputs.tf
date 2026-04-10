output "namespace_id" {
  description = "The ID of the Service Bus namespace"
  value       = azurerm_servicebus_namespace.audit_forward.id
}

output "namespace_name" {
  description = "The name of the Service Bus namespace"
  value       = azurerm_servicebus_namespace.audit_forward.name
}

output "billing_events_topic_id" {
  description = "The ID of the billing-events topic"
  value       = azurerm_servicebus_topic.billing_events.id
}

output "audit_events_topic_id" {
  description = "The ID of the audit-events topic"
  value       = azurerm_servicebus_topic.audit_events.id
}
