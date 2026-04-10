variable "resource_group_name" {
  description = "Name of the resource group (passed from root module)"
  type        = string
}

variable "location" {
  description = "Azure region (passed from root module)"
  type        = string
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}

variable "domain_topics" {
  description = "Map of domain-specific Service Bus topic IDs to subscribe to"
  type        = map(string)
  default = {
    "billing-events" = "billing-events"
    "user-events"    = "user-events"
    "tenant-events"  = "tenant-events"
  }
}