# main.tf example

```
terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.14"
    }
  }
}

provider "proxmox" {
  pm_api_url          = "https://x.x.x.x:8006/api2/json"
  pm_api_token_id     = "terraform-prov@pve!terraform-provisioner"
  pm_api_token_secret = "<secret>"
  pm_tls_insecure     = true
  pm_debug            = false
  pm_parallel         = 3
  pm_log_enable       = false
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}

module "dev" {
  source = "https://github.com/alexrf/tf-modules-resume//services/proxmox-vm"
  #ssh_key    = trimspace(module.dev.private-key)
  vm_configs = var.vm_configs
  vm_docker  = var.vm_docker

}

```
