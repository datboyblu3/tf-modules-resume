variable "description" {
  description = "small description of the vm purpose"
  type        = string
  default     = "Home VM for testing and other deployments"

}

#variable "ssh_key" {
# description = "ssh public key used for server access"
# type        = string
#}

variable "host" {
  description = "CPU Type"
  type        = string
  default     = "host"

}

variable "scsihw" {
  description = "SCSI HW type"
  type        = string
  default     = "virtio-scsi-pci"
}

variable "bootdisk" {
  description = "bootdisk designator"
  type        = string
  default     = "scsi0"

}

variable "socket" {
  description = "Number of CPU sockets"
  type        = number
  default     = 1

}

variable "disk_type" {
  description = "type of disk"
  type        = string
  default     = "scsi"
}

variable "disk_storage_location" {
  description = "Location of the vm storage"
  type        = string
  default     = "local-lvm"
}

variable "ntwk_model" {
  description = "Interface"
  type        = string
  default     = "virtio"
}

variable "ntwk_bridge" {
  description = "Id of the network bridge"
  type        = string
  default     = "vmbr0"
}


variable "os_type" {
  description = "type of Proxmox OS"
  type        = string
  default     = ""

}

variable "ci_username" {
  description = "vm username"
  type        = string
  default     = "ubuntu"

}
variable "ci_password" {
  description = "vm password"
  type        = string
  default     = ""

}

variable "vm_configs" {
  description = "vm variables"
  type        = map(any)

}

variable "vm_docker" {
  description = "Docker install"
  type        = list(any)

}
