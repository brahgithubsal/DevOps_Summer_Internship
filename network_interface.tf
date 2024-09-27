resource "azurerm_network_interface" "nic" {
  count               = var.nodecount
  name                = "${var.prefix}-nic-vm${count.index + 1}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "${var.prefix}-nic-config-vm${count.index + 1}"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm[count.index].id
  }
}

resource "azurerm_network_interface_security_group_association" "nsg-nic" {
  count                     = var.nodecount
  network_interface_id      = azurerm_network_interface.nic[count.index].id
  network_security_group_id = azurerm_network_security_group.main.id
}
