provider "azurerm" {
  features {}
}

locals {
  name_prefix     = var.name_prefix
  location        = var.location
}

resource "azurerm_resource_group" "deliciousdetails" {
  name     = local.name_prefix
  location = local.location
}

resource "azurerm_app_service_plan" "deliciousdetailsasp" {
  name                = "${local.name_prefix}-plan"
  location            = azurerm_resource_group.deliciousdetails.location
  resource_group_name = azurerm_resource_group.deliciousdetails.name

  kind     = "Linux"
  reserved = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "dockerapp" {
  name                = "${local.name_prefix}-dockerapp"
  location            = azurerm_resource_group.deliciousdetails.location
  resource_group_name = azurerm_resource_group.deliciousdetails.name
  app_service_plan_id = azurerm_app_service_plan.deliciousdetailsasp.id

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = "80"
    
  }

  site_config {
    linux_fx_version = var.docker_image
    always_on        = "true"
  }

  identity {
    type = "SystemAssigned"
  }
}