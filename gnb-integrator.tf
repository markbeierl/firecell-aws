module "gnb01" {
  app_name   = "firecell-gnb01"
  source     = "git::https://github.com/canonical/sdcore-gnb-integrator//terraforms?ref=v1.4"
  model_name = "gnb-integration"
  channel    = "1.4/edge"
  config     = {
    tac: 1
  }
}

resource "juju_offer" "gnb01-fiveg-gnb-identity" {
  model            = "gnb-integration"
  application_name = module.gnb01.app_name
  endpoint         = module.gnb01.fiveg_gnb_identity_endpoint
}

resource "juju_integration" "nms-gnb01" {
  model = "control-plane"

  application {
    name     = module.sdcore-control-plane.nms_app_name
    endpoint = module.sdcore-control-plane.fiveg_gnb_identity_endpoint
  }

  application {
    offer_url = juju_offer.gnb01-fiveg-gnb-identity.url
  }
}
