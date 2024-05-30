resource "juju_offer" "upf" {
  model            = var.user_plane_model_name
  application_name = module.user_plane.upf_app_name
  endpoint         = module.user_plane.fiveg_n4_endpoint
}

resource "juju_integration" "upf-nms" {
  model = var.control_plane_model_name

  application {
    name     = module.control_plane.nms_app_name
    endpoint = module.control_plane.fiveg_n4_endpoint
  }

  application {
    offer_url = juju_offer.upf.url
  }
}