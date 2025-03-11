variable "zone" {
  description = "Zone for the temporary VM"
  type        = string
  default     = "us-central1-a"
}

variable "snapshot" {
  description = "Name of the snapshot"
  type        = string
  default     = "bdelic-tf-snapshot"
}

variable "snapshot_source" {
  description = "Disk that is used to create the snapshot"
  type        = string
}

variable "image" {
  description = "Name of the image created from the snapshot"
  type        = string
  default     = "bdelic-tf-snapshot-image"
}

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

variable "instance_group_startup_script" {
  description = "Path to startup script for instances in instance template"
  type        = string
  default     = "./instance_group_startup_script.sh"
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

variable "target_size" {
  description = "Number of instances in instance group"
  type        = number
  default     = 3
}