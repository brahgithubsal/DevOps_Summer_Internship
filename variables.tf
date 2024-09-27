variable "prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = "k8s-cluster"
}

variable "location" {
  description = "Location for resources"
  type        = string
  default     = "Italy North"
}

variable "nodecount" {
  description = "Number of virtual machines"
  type        = number
  default     = 2
}

variable "username" {
  description = "Admin username for the virtual machines"
  type        = string
  default     = "adminuser"
}

variable "password" {
  description = "Admin password for the virtual machines"
  type        = string
  default     = "Password1234"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ubuntu_image_version" {
  description = "Ubuntu image version"
  type        = string
  default     = "latest"
}
