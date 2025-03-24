variable "vm" {
  description = "Name of the temporary VM"
  type        = string
  default     = "bdelic-tf-instance"
}

variable "machine_type" {
  description = "Type of the temporary VM"
  type        = string
  default     = "e2-micro"
}

variable "zone" {
  description = "Zone for the temporary VM"
  type        = string
  default     = "us-central1-a"
}

variable "startup_script" {
  description = "Path to startup script for VMs"
  type        = string
  default     = "./startup_script.sh"
}

variable "image" {
  description = "Startup image for the temporary VM"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "subnet" {
  description = "Subnet of the VM"
  type        = string
}

