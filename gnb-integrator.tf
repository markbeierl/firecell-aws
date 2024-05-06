resource "juju_model" "gnb" {
  name = var.gnb_model_name
}


module "gnb01" {
  app_name   = "fc01"
  source     = "git::https://github.com/canonical/sdcore-gnb-integrator//terraform?ref=v1.4"
  model_name = juju_model.gnb.name
  channel    = "1.4/edge"
  config     = {
    tac: 1
  }
}

resource "juju_offer" "gnb01-fiveg-gnb-identity" {
  model            = juju_model.gnb.name
  application_name = module.gnb01.app_name
  endpoint         = module.gnb01.fiveg_gnb_identity_endpoint
}

resource "juju_integration" "nms-gnb01" {
  model = juju_model.sdcore.name

  application {
    name     = module.sdcore.nms_app_name
    endpoint = module.sdcore.fiveg_gnb_identity_endpoint
  }

  application {
    offer_url = juju_offer.gnb01-fiveg-gnb-identity.url
  }
}
