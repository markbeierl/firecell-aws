resource "juju_model" "sdcore" {
  name = var.sdcore_model_name
}

module "sdcore" {
  source = "git::https://github.com/canonical/terraform-juju-sdcore-k8s//modules/sdcore-k8s?ref=v1.4"

  model_name = juju_model.sdcore.name
  sdcore_channel = "1.4/beta"
  create_model = false
  deploy_cos = true

  depends_on = [juju_model.sdcore]

  traefik_config = {
    routing_mode = "subdomain"
    external_hostname = "10.8.0.1.nip.io"
  }

  upf_config = {
    cni-type                     = "vfioveth"
    access-gateway-ip            = "10.0.4.95"
    access-interface-mac-address = "02:b7:3b:6f:cb:01"
    access-ip                    = "10.0.4.253/24"
    core-gateway-ip              = "10.0.3.1"
    core-interface-mac-address   = "02:2d:7e:c2:24:9d"
    core-ip                      = "10.0.3.74/24"
    enable-hw-checksum           = "false"
    gnb-subnet                   = "10.8.0.0/24"
    upf-mode                     = "dpdk"
  }

#  upf_config = {
#    cni-type                     = "vfioveth"
#    access-gateway-ip            = "10.0.4.95"
#    access-interface-mac-address = "02:28:4d:51:cc:15"
#    access-ip                    = "10.0.4.211/24"
#    core-gateway-ip              = "10.0.3.1"
#    core-interface-mac-address   = "02:c9:57:70:9c:db"
#    core-ip                      = "10.0.3.72/24"
#    enable-hw-checksum           = "false"
#    gnb-subnet                   = "10.8.0.0/24"
#    upf-mode                     = "dpdk"
#  }

}
