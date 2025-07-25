# Reference the existing Virtual Network
data "azurerm_virtual_network" "aksvnet" {
  name                = "aks-vnet"
  resource_group_name = "myRg"
}

# Reference the existing Subnet
data "azurerm_subnet" "akssubnet" {
  name                 = "default"
  virtual_network_name = data.azurerm_virtual_network.aksvnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                      = "testaks01"
  location                  = var.location # Update the location if necessary
  resource_group_name       = data.azurerm_virtual_network.aksvnet.resource_group_name
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
