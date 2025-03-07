terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.24.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.3"
    }
  }
}

provider "google" {
  project = var.project
  region = var.region
  zone = var.zone
}

provider "null" {
}

module "network" {
  source = "./modules/network"
  vpc = var.vpc
  subnet = var.subnet
  firewall = var.firewall
}

module "vm" {
  source = "./modules/vm"
  subnet = module.network.subnet_id
}

module "instance_group" {
  source = "./modules/instance_group"
  snapshot_source = module.vm.vm_disk
  subnet = module.network.subnet_id
}

module "load_balancer" {
  source = "./modules/load_balancer"
  vpc_id = module.network.vpc_id
  instance_group_manager_instance_group = module.instance_group.instance_group_manager_instance_group
}