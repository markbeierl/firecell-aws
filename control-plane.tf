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
