output "app_service_url" {
  value = azurerm_app_service.main.default_site_hostname
}

output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "virtual_network_name" {
  value = azurerm_virtual_network.main.name
}
