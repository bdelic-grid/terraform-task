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