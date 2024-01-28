os_type = "cloud-init"

#ssh_key = "value""

ci_username = "ubuntu"

ci_password = "supersecretpassword"


#scripts to run after vm creation

vm_configs = {
  v1 = { target_node = "node", template_name = "ubuntu-cloud-1", vcpu = "2", memory = "4096", disk_size = "30G", name = "vm-001", ip = "x.x.x.x", gw = "x.x.x.x" },
  v2 = { target_node = "node", template_name = "ubuntu-cloud-1", vcpu = "2", memory = "2048", disk_size = "20G", name = "vm-002", ip = "x.x.x.x", gw = "x.x.x.x" },
  v3 = { target_node = "node", template_name = "ubuntu-cloud-1", vcpu = "2", memory = "2048", disk_size = "20G", name = "vm-003", ip = "x.x.x.x", gw = "x.x.x.x" }
  #v4 = { target_node = "home", template_name = "ubuntu-cloud", vcpu = "2", memory = "4096", disk_size = "20G", name = "home-vm-004", ip = "10.3.3.54", gw = "10.3.3.1" }
  #v5 = { target_node = "home", template_name = "ubuntu-cloud", vcpu = "2", memory = "2048", disk_size = "20G", name = "home-vm-005", ip = "10.3.3.55", gw = "10.3.3.1" }
  #v6 = { target_node = "home", template_name = "ubuntu-cloud", vcpu = "2", memory = "2048", disk_size = "20G", name = "home-vm-006", ip = "10.3.3.56", gw = "10.3.3.1" }
}

vm_docker = [
  "sleep 4m && curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh",
  "sudo usermod -aG docker ubuntu"
]

