
resource "azurerm_kubernetes_cluster" "aks" {
  name                      = "testaks01"
  location                  = var.location # Update the location if necessary
  resource_group_name       = data.azurerm_virtual_network.vnet.resource_group_name
  dns_prefix                = "aksdns"
  kubernetes_version        = "1.32.5"
  sku_tier                  = "Free"

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_D2_v4"
    #vnet_subnet_id      = data.azurerm_subnet.subnet.id
  }

  identity {
    type = "SystemAssigned"
  }
}
