terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.14"
    }
  }
}

resource "proxmox_vm_qemu" "cloudinit" {
  for_each    = var.vm_configs
  name        = each.value.name
  desc        = var.description
  target_node = each.value.target_node
  #vm stats
  cpu      = var.host
  scsihw   = var.scsihw
  bootdisk = var.bootdisk
  cores    = each.value.vcpu
  sockets  = var.socket
  memory   = each.value.memory
  disk {
    slot     = 0
    size     = each.value.disk_size
    type     = var.disk_type
    storage  = var.disk_storage_location
    iothread = 0
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
  ipconfig0 = "ip=${each.value.ip}/24,gw=${each.value.gw}"
  # sshkeys set using variables. the variable contains the text of the key.
  ssh_user = var.ci_username
  sshkeys  = var.ssh_key


  # executes a post install of docker and other instance tasks. 
  # TODO: Kubernetes install
  provisioner "remote-exec" {
    inline = concat(var.vm_docker)
    connection {
      type = "ssh"
      user = var.ci_username
      # password = var.ci_password
      private_key = file("$HOME/.ssh/homeadm")
      host        = each.value.ip
    }
  }
}

