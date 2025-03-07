terraform {
  backend "gcs" {
    bucket = "bdelic-tf-state-bucket"
    prefix = "/tf/state"
  }
}