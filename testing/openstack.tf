module "mantl-ci-keypair" {
  source = "./terraform/openstack/keypair"
  auth_url = "https://us-texas-3.cloud.cisco.com:5000/v2.0"
  tenant_id = "239238473d674e138ac07bc5c9b0a6d5"
  tenant_name = "mantl-tx-3"
  public_key = "~/.ssh/id_rsa.pub"
  keypair_name = "mantl-ci"
}

module "mantl-ci-hosts-floating" {
  source = "./terraform/openstack/hosts-floating"
  auth_url = "https://us-texas-3.cloud.cisco.com:5000/v2.0"
  datacenter = "mantl-ci"
  tenant_id = "239238473d674e138ac07bc5c9b0a6d5"
  tenant_name = "mantl-tx-3"
  control_flavor_name = "CO2-Medium"
  worker_flavor_name  = "CO2-Medium"
  edge_flavor_name  = "CO2-Medium"
  image_name = "CentOS-7"
  keypair_name = "${ module.mantl-ci-keypair.keypair_name }"
  control_count = 3
  worker_count = 3
  edge_count = 2
  floating_pool = "public-floating-601"
  external_net_id = ""
  control_data_volume_size = 20
  worker_data_volume_size = 100
}
