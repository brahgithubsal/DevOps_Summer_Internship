resource "azurerm_public_ip" "vm" {
  count               = var.nodecount
  name                = "${var.prefix}-public-ip-vm${count.index + 1}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
}
