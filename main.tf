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
    enable-hw-checksum           = "true"
    gnb-subnet                   = "10.8.0.0/24"
    upf-mode                     = "dpdk"
  }
}

resource "juju_offer" "prometheus" {
  model            = "cos-lite"
  application_name = "prometheus"
  endpoint         = "receive-remote-write"
}

resource "juju_integration" "prometheus" {
  model = var.user_plane_model_name

  application {
    name     = module.user_plane.grafana_agent_app_name
    endpoint = module.user_plane.send_remote_write_endpoint
  }

  application {
    offer_url = juju_offer.prometheus.url
  }
}

resource "juju_offer" "loki" {
  model            = "cos-lite"
  application_name = "loki"
  endpoint         = "logging"
}

resource "juju_integration" "loki" {
  model = var.user_plane_model_name

  application {
    name     = module.user_plane.grafana_agent_app_name
    endpoint = module.user_plane.logging_consumer_endpoint
  }

  application {
    offer_url = juju_offer.loki.url
  }
}