provider "google" {
# the credentials are in the .drone.sec file
  credentials = ""
}

module "gce-dc" {
  source = "./terraform/gce"
  datacenter = "gce-dc"
  control_type = "n1-standard-1"
  worker_type = "n1-highcpu-2"
  network_ipv4 = "10.0.0.0/16"
  long_name = "mantl-drone-ci"
  short_name = "drone-ci"
  region = "us-central1"
  zone = "us-central1-a"
  control_count = 3
  worker_count = 3
  edge_count = 2
}
