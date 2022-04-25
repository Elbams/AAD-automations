resource "azurerm_resource_group" "deployment" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_aadb2c_directory" "tenant" {
  country_code            = "CH"
  data_residency_location = "Europe"
  display_name            = var.rg_name
  domain_name             = "${var.rg_name}.onmicrosoft.com"
  resource_group_name     = azurerm_resource_group.deployment.name
  tag                     = "ifrc-test"
}

module "tenant" {
  source        = "./tenant"

  tenant_id           = azurerm_aadb2c_directory.tenant.tenant_id
  tenant_domain_name  = azurerm_aadb2c_directory.tenant.domain_name
}


output "tenant_id" {
  value = azurerm_aadb2c_directory.tenant.tenant_id
}