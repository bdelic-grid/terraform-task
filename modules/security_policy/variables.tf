variable "policy" {
  description = "Name of the security policy"
  type        = string
}

variable "source_ip_ranges" {
  description = "List of allowed IPs"
  type = list(string)
  default = ["82.117.193.213", "109.111.235.230"]
}