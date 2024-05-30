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