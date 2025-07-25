# Reference the existing Virtual Network
data "azurerm_virtual_network" "vnet" {
  name                = "agentPool-vnet"
  resource_group_name = "myRg"
}

# Reference the existing Subnet
data "azurerm_subnet" "subnet" {
  name                 = "default"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}


resource "azurerm_kubernetes_cluster" "aks" {
  name                      = "testaks01"
  location                  = var.location # Update the location if necessary
  resource_group_name       = data.azurerm_virtual_network.vnet.resource_group_name
  dns_prefix                = "aksdns"
  kubernetes_version        = "1.32.5"
  sku_tier                  = "Free"
  node_os_channel_upgrade   = "none"
  network_policy            = "none"
  load_balancer_sku         = "standard"

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_D4ds_v5"
    vnet_subnet_id      = data.azurerm_subnet.subnet.id
  }

  identity {
    type = "SystemAssigned"
  }
}
