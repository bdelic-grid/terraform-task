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
  source         = "./modules/instance_group"
  subnet         = module.network.subnet_id
  snapshot_image = module.vm.snapshot_image
  depends_on     = [module.vm]
}

module "security_policy" {
  source = "./modules/security_policy"
  policy = var.policy
}

module "load_balancer" {
  source                                = "./modules/load_balancer"
  vpc_id                                = module.network.vpc_id
  instance_group_manager_instance_group = module.instance_group.instance_group_manager_instance_group
  security_policy_id                    = module.security_policy.security_policy_id
}