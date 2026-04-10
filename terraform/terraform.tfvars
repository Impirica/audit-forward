# Copy this file to terraform.tfvars and fill in your actual values
# cp terraform.tfvars.example terraform.tfvars

subscription_id      = "ff732bf4-b528-43a9-8ffe-629663e04383"
tenant_id            = "4b7a10e2-0dff-47ae-ad18-61c6420d23a3"
resource_group_name  = "rg-audit-forward"
location             = "canadacentral" # e.g., "eastus", "westus2", "centralus"
environment          = "dev" # e.g., "dev", "staging", "prod"

tags = {
  Environment = "test-audit-forward"
  ManagedBy   = "Terraform"
  Project     = "test audit forward"
}
