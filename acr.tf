resource "azurerm_container_registry" "acr" {
  name                = "myconregistry1"
  resource_group_name = data.azurerm_virtual_network.vnet.resource_group_name
  location            = "westus"
  sku                 = "Basic"
}