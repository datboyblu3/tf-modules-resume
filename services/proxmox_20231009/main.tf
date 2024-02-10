terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.14"
    }
  }
}


resource "tls_private_key" "ssh-ed25519" {
  algorithm = "ED25519"
}

resource "proxmox_vm_qemu" "cloudinit" {
  for_each    = var.vm_configs
  name        = each.value.name
  desc        = var.description
  target_node = each.value.target_node
  #vm stats
  cpu      = var.host
  bios     = "ovmf"
  scsihw   = var.scsihw
  bootdisk = var.bootdisk
  cores    = each.value.vcpu
  sockets  = var.socket
  memory   = each.value.memory
  disks {
    scsi {
      scsi0 {
        disk {
          backup  = true
          storage = var.disk_storage_location
          size    = each.value.disk_size
        }
      }
    }
  }


  network {
    model  = var.ntwk_model
    bridge = var.ntwk_bridge
  }


  #cloud init creds override
  cipassword = var.ci_password

  clone = each.value.template_name

  #cloud init image name, generated during manual clone
  os_type = var.os_type
  #networking
  nameserver = "1.1.1.1"
  ipconfig0  = "ip=${each.value.ip}/24,gw=${each.value.gw}"
  # sshkeys set using variables. the variable contains the text of the key.
  ssh_user = var.ci_username
  sshkeys  = trimspace(tls_private_key.ssh-ed25519.public_key_openssh)


}

