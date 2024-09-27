output "ssh_commands" {
  description = "SSH commands for virtual machines"
  value = [
    for ip in azurerm_public_ip.vm.*.ip_address : "ssh ${var.username}@${ip}"
  ]
}
