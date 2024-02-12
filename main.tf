variable "project_name" {
  type        = string
  default     = "aboyere"
  description = "The name of the project"
}

resource "azurerm_resource_group" "app01" {
  name     = "rg-${var.project_name}-01-resources"
  location = "West Europe"
}

resource "azurerm_service_plan" "plan01" {
  name                = "as-${var.project_name}-01-plan"
  resource_group_name = azurerm_resource_group.app01.name
  location            = azurerm_resource_group.app01.location
  sku_name            = "P1v2"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "webapp01" {
  name                = "aw-${var.project_name}-webapp01"
  resource_group_name = azurerm_resource_group.app01.name
  location            = azurerm_service_plan.plan01.location
  service_plan_id     = azurerm_service_plan.plan01.id

  site_config {}
}