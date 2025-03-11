project = "gd-gcp-internship-devops"

vpc      = "bdelic-tf-vpc"
subnet   = "bdelic-tf-subnet"
firewall = "bdelic-tf-default-fw"

snapshot     = "bdelic-tf-snapshot"
image        = "bdelic-tf-snapshot-image"
machine_type = "e2-micro"

instance_group_base_name = "bdelic-tf-group-instance"
instance_group           = "bdelic-tf-instance-group-manager"

security_policy = "bdelic-tf-security-policy"