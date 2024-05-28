module "control_plane" {
  source = "git::https://github.com/canonical/terraform-juju-sdcore-k8s//modules/sdcore-control-plane-k8s?ref=v1.4"

  model_name = var.control_plane_model_name
  sdcore_channel = "1.4/edge"
  create_model = false
  deploy_cos = true

  traefik_config = {
    routing_mode = "subdomain"
    external_hostname = "10.8.0.1.nip.io"
  }
}

module "user_plane" {
  source = "git::https://github.com/canonical/terraform-juju-sdcore-k8s//modules/sdcore-user-plane-k8s?ref=v1.4"
  model_name = var.user_plane_model_name
  upf_channel = "1.4/edge"
  create_model = false
  upf_config = {
    cni-type                     = "vfioveth"
    access-gateway-ip            = "10.0.4.95"
    access-interface-mac-address = "02:97:f6:3d:aa:43"
    access-ip                    = "10.0.4.163/24"
    core-gateway-ip              = "10.0.3.1"
    core-interface-mac-address   = "02:f7:d2:e1:61:93"
    core-ip                      = "10.0.3.94/24"
    enable-hw-checksum           = "false"
    gnb-subnet                   = "10.8.0.0/24"
    upf-mode                     = "dpdk"
  }
}
