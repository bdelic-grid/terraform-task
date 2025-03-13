module "network" {
  source   = "./modules/network"
  vpc      = var.vpc
  subnet   = var.subnet
  firewall = var.firewall
}

module "vm" {
  source = "./modules/vm"
  subnet = module.network.subnet_id
}

module "instance_group" {
  source                   = "./modules/instance_group"
  snapshot_source          = module.vm.vm_disk
  subnet                   = module.network.subnet_id
  snapshot                 = var.snapshot
  image                    = var.image
  machine_type             = var.machine_type
  instance_group_base_name = var.instance_group_base_name
  instance_group           = var.instance_group
}

module "security_policy" {
  source          = "./modules/security_policy"
  security_policy = var.security_policy
}

module "security_policy" {
  source = "./modules/security_policy"
  policy = var.policy
}

module "load_balancer" {
  source                                = "./modules/load_balancer"
  vpc_id                                = module.network.vpc_id
  instance_group_manager_instance_group = module.instance_group.instance_group_manager_instance_group
  security_policy_id = module.security_policy.security_policy_id
}