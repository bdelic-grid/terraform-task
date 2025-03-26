variable "vpc" {
  description = "Name of the VPC"
  type        = string
}

variable "subnet" {
  description = "Name of the subnet"
  type        = string
}

variable "ip_cidr_range" {
  description = "Range of IPs for an instance"
  type        = string
  default     = "10.2.0.0/24"
}

variable "stack_type" {
  description = "Stack type for the subnet"
  type        = string
  default     = "IPV4_ONLY"
}

variable "region" {
  description = "Region for the subnet"
  type        = string
  default     = "us-central1"
}

variable "firewall" {
  description = "Name of the firewall"
  type        = string
}

variable "source_ranges" {
  description = "Source ranges for the firewall"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "port_list" {
  description = "List of enabled ports in the firewall"
  type        = list(string)
  default     = ["22", "80", "443", "8080"]
}