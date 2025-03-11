resource "google_compute_security_policy" "policy" {
  name = var.security_policy

  rule {
    description = "Allow traffic from my IPs"
    action      = "allow"
    priority    = 1000
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["82.117.193.213", "109.111.235.230"]
      }
    }
  }

  rule {
    description = "Deny requests from all other IPs"
    action      = "deny(403)"
    priority    = 2147483647
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
  }
}