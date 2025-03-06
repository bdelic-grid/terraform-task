variable "project" {
  description = "Name of the project"
  type = string
}

variable "region" {
  default = "us-central1"
  description = "Region of the project"
  type = string
}

variable "zone" {
  default = "us-central1-a"
  description = "Zone of the project"
  type = string
}

variable "startup_script" {
  description = "Path to startup script for VMs"
  type = string
}

variable "instance_group_startup_script" {
  description = "Path to startup script for VMs in the instance group"
  type = string
}