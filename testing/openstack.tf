module "mantl-ci-keypair" {
  source = "./terraform/openstack/keypair"
  auth_url = "https://eu-amsterdam-1.cloud.cisco.com:5000/v2.0"
  tenant_id = "55c1ad1a57064bc89b59e8bb117e6ece"
  tenant_name = "shipped-eu"
  public_key = "~/.ssh/id_rsa.pub"
  keypair_name = "mantl-ci"
}

module "mantl-ci-hosts-floating" {
  source = "./terraform/openstack/hosts-floating"
  auth_url = "https://eu-amsterdam-1.cloud.cisco.com:5000/v2.0"
  datacenter = "mantl-ci"
  tenant_id = "55c1ad1a57064bc89b59e8bb117e6ece"
  tenant_name = "shipped-eu"
  control_flavor_name = "CO2-Medium"
  worker_flavor_name  = "CO2-Medium"
  edge_flavor_name  = "CO2-Medium"
  image_name = "CentOS-7"
  keypair_name = "${ module.mantl-ci-keypair.keypair_name }"
  control_count = 3
  worker_count = 3
  edge_count = 2
  floating_pool = "public-floating-601"
  external_net_id = "56e3d1ac-44d6-43d7-bea3-e2f334aa8f86"
  control_data_volume_size = 20
  worker_data_volume_size = 100
}
