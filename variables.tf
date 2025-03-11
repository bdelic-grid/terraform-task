variable "project" {
  description = "Name of the project"
  type        = string
}

variable "region" {
  description = "Region of the project"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zone of the project"
  type        = string
  default     = "us-central1-a"
}

variable "vpc" {
  description = "Name of the VPC"
  type        = string
}

variable "subnet" {
  description = "Name of the subnet"
  type        = string
}

variable "firewall" {
  description = "Name of the default firewall"
  type        = string
}

variable "snapshot" {
  description = "Name of the snapshot"
  type        = string
}

variable "image" {
  description = "Name of the image created from the snapshot"
  type        = string
}

variable "machine_type" {
  description = "Type of machines in instance template"
  type        = string
}

variable "instance_group_base_name" {
  description = "Base name of each instance in instance group"
  type        = string
}

variable "instance_group" {
  description = "Name of the instance group"
  type        = string
}

variable "security_policy" {
  description = "Name of the security policy"
  type        = string
}