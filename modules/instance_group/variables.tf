variable "instance_template" {
  description = "Name of the instance template"
  type        = string
  default     = "bdelic-tf-instance-template"
}

variable "machine_type" {
  description = "Type of machines in instance template"
  type        = string
  default     = "e2-micro"
}

variable "snapshot_image" {
  description = "Image of a snapshot used for starting VMs"
  type        = string
}

variable "subnet" {
  description = "Subnet for instances"
  type        = string
}

variable "instance_group_base_name" {
  description = "Base name of each instance in instance group"
  type        = string
  default     = "bdelic-tf-group-instance"
}

variable "instance_group" {
  description = "Name of the instance group"
  type        = string
  default     = "bdelic-tf-instance-group-manager"
}

variable "zone" {
  description = "Zone for the instance group"
  type        = string
  default     = "us-central1-a"
}

variable "target_size" {
  description = "Number of instances in instance group"
  type        = number
  default     = 2
}