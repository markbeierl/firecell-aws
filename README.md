# Firecell AWS
Terraform plans for Firecell in AWS

Requires the control-plane and user-plane models to be pre-created as they can be deployed on separate clouds.

```bash
juju add-model control-plane <control-plane-cloud>
juju add-model user-plane <user-plane-cloud>
terraform apply
```

## Subscriber provisioning

```bash
export WEBUI_IP=10.1.36.136

for sub in `seq 0 9` ; do
curl -v ${WEBUI_IP}:5000/api/subscriber/imsi-20893010000748${sub} --header 'Content-Type: text/plain' --data "{
    \"UeId\":\"20893010000748${sub}\",
    \"opc\":\"981d464c7c52eb6e5036234984ad0bcf\",
    \"key\":\"5122250214c33e723a5dd523fc145fc0\",
    \"sequenceNumber\":\"16f3b3f70fc2\"
}"
done

curl -v ${WEBUI_IP}:5000/config/v1/device-group/default-default --header 'Content-Type: application/json' --data '{
    "imsis": [
        "208930100007480",
        "208930100007481",
        "208930100007482",
        "208930100007483",
        "208930100007484",
        "208930100007485",
        "208930100007486",
        "208930100007487",
        "208930100007488",
        "208930100007489"
    ],
    "site-info": "demo",
    "ip-domain-name": "pool1",
    "ip-domain-expanded": {
        "dnn": "internet",
        "ue-ip-pool": "172.250.1.0/16",
        "dns-primary": "8.8.8.8",
        "mtu": 1460,
        "ue-dnn-qos": {
            "dnn-mbr-uplink": 500,
            "dnn-mbr-downlink": 500,
            "bitrate-unit": "mbps",
            "traffic-class": {
                "name": "platinum",
                "arp": 6,
                "pdb": 300,
                "pelr": 6,
                "qci": 8
            }
        }
    }
}'
curl -v ${WEBUI_IP}:5000/config/v1/network-slice/default --header 'Content-Type: application/json' --data '{
  "slice-id": {
    "sst": "1",
    "sd": "010203"
  },
  "site-device-group": [
    "default-default"
  ],
  "site-info": {
    "site-name": "demo",
    "plmn": {
      "mcc": "208",
      "mnc": "93"
    },
    "gNodeBs": [
      {
        "name": "demo-gnb1",
        "tac": 1
      }
    ],
    "upf": {
      "upf-name": "10.0.1.152",
      "upf-port": "8805"
    }
  }
}'
```
