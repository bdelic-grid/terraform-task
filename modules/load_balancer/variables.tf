variable "healthcheck_firewall" {
  description = "Name of the healthcheck firewall"
  type        = string
  default     = "bdelic-tf-healthcheck-firewall"
}

variable "vpc_id" {
  description = "ID of created VPC"
  type        = string
}

variable "source_ranges" {
  description = "Source ranges for the healthcheck firewall"
  type        = list(string)
  default     = ["130.211.0.0/22", "35.191.0.0/16"]
}

variable "lb_ip" {
  description = "Name of the static load balancer IP"
  type        = string
  default     = "bdelic-tf-lb-ip"
}

variable "ip_version" {
  description = "Version of static load balancer IP"
  type        = string
  default     = "IPV4"
}

variable "healthcheck" {
  description = "Name of the healthcheck"
  type        = string
  default     = "bdelic-tf-http-basic-check"
}

variable "backend" {
  description = "Name of the backend"
  type        = string
  default     = "bdelic-tf-backend"
}

variable "instance_group_manager_instance_group" {
  description = "Instance group inside the instance group manager"
  type        = string
}

variable "url_map" {
  description = "Name of the URL map"
  type        = string
  default     = "bdelic-tf-map"
}

variable "proxy" {
  description = "Name of the HTTP proxy"
  type        = string
  default     = "bdelic-tf-http-lb-proxy"
}

variable "forwarding_rule" {
  description = "Name of the forwarding rule"
  type        = string
  default     = "bdelic-tf-http-content-rule"
}

variable "port_range" {
  description = "Port range for the forwarding rule"
  type        = string
  default     = "80-80"
}

variable "security_policy_id" {
  description = "ID of the security policy"
  type        = string
}