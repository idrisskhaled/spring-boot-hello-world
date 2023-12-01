provider "azurerm" {
  features {}

  client_id       = "465751c7-8537-4ab8-a8df-65130d303b24"
  client_secret   = ""
  tenant_id       = "dbd6664d-4eb9-46eb-99d8-5c43ba153c61"
  subscription_id = "45d598b0-9aae-47da-b875-dad6e37e538d"
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "myVNet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_app_service_plan" "main" {
  name                = "myAppServicePlan"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  // Choisissez "Linux" pour les conteneurs Linux
  kind = "Linux"

  reserved = true  // Nécessaire pour les plans Linux

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "main" {
  name                = "AppService4167"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.main.id

  site_config {
    linux_fx_version = "DOCKER|malekghorbel/parser:latest"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }
}
