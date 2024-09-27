resource "azurerm_linux_virtual_machine" "vm" {
  count                        = var.nodecount
  name                         = "${var.prefix}-vm${count.index + 1}"
  location                     = azurerm_resource_group.main.location
  resource_group_name          = azurerm_resource_group.main.name
  size                         = "Standard_B2s"
  admin_username               = var.username
  disable_password_authentication = true

  network_interface_ids = [azurerm_network_interface.nic[count.index].id]

  admin_ssh_key {
    username   = var.username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "${var.prefix}-osdisk-${count.index + 1}"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = var.ubuntu_image_version
  }

  connection {
    type        = "ssh"
    user        = var.username
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip_address
    timeout     = "4m"
  }
}

resource "local_file" "inventory" {
  depends_on = [azurerm_linux_virtual_machine.vm]

  filename = "${path.module}/inventory.ini"
  content  = join("\n", [
    "[master]",
    format("master ansible_host=%s ansible_user=adminuser ansible_ssh_private_key_file=~/.ssh/id_rsa", azurerm_linux_virtual_machine.vm[0].public_ip_address),
    "[worker]",
    join("\n", [
      for ip in slice(azurerm_linux_virtual_machine.vm.*.public_ip_address, 1, length(azurerm_linux_virtual_machine.vm)) : format("worker ansible_host=%s ansible_user=adminuser ansible_ssh_private_key_file=~/.ssh/id_rsa", ip)
    ])
  ])
}



resource "null_resource" "aziz" {
  depends_on = [azurerm_linux_virtual_machine.vm]

  provisioner "local-exec" {
    command = <<EOT
      ansible-playbook -i inventory.ini playbook.yml
    EOT
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }
}
