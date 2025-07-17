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

## Create a new Network Interface connected to the existing Subnet
resource "azurerm_network_interface" "example" {
  name                = "${var.prefix}-nic"
  location            = var.location # Update the location if necessary
  resource_group_name = data.azurerm_virtual_network.vnet.resource_group_name # Replace with your resource group name

  ip_configuration {
    name                          = "${var.prefix}-ip"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_windows_virtual_machine" "testvm" {
  name                  = "${var.prefix}-01"
  location              = var.location
  resource_group_name   = data.azurerm_virtual_network.vnet.resource_group_name
  size                  = "Standard_B2s"
  network_interface_ids = [azurerm_network_interface.example.id]
  admin_username        = "azadmin"
  admin_password        = "Admin@123"

  os_disk {
    name                 = "${var.prefix}-disk1"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}



