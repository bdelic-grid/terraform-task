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

variable "vpc" {
  description = "Name of the VPC"
  type = string
}

variable "subnet" {
  description = "The name of the subnet"
  type = string
}

variable "firewall" {
  description = "The name of the firewall"
  type = string
}