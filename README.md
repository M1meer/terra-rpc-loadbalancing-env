# terra-rpc-loadbalancing-env

## 💡 Introduction

This collection of playbooks provides a starting point for building a load-balanced RPC environment, and contains the following roles:
- grafana-server 
	- Deploys a grafana server listening on the standard port, ```3000```
- haproxy
	- Deploys an HAProxy instance to the target, sets TCP-based load balancing based on number of connections, and binds listening ports to ```1317```, ```9090```, ```26657```, and populates ```/etc/haproxy/haproxy.cfg``` with back-end IPs defined in ```vars/main.yml```
- node-exporter
	- Deploys node-exporters to each target, port ```9100```
- prometheus-server
	- Deploys a prometheus server, and populates prometheus.yml with scraping endpoints based on host: port defined in ```vars/main.yml```
- terra-nodes
	- Deploys full terra nodes, opens RPC endpoints
- firewall
	- Deploys ```allow``` rules with ```deny``` policy


## Getting started
Target machine IPs are defined in ```group_vars/all.yml```, and these variables are re-used throughout the playbook. As such, define your targets with the relevant public and private IPs. You also need to make sure that the targets are able to communicate locally, be that by existing in the same VPC and subnet, or using e.g. VPC peering. If you want them to communicate on public addresses in all instances, private IP variables need to be replaced with their public-IP counterparts (```group_vars/all.yml```) in all relevant places, or alternatively, by giving the ```_local``` variables the same values as their public counterparts in ```group_vars/all.yml```



## Usage

Scripts are provided to run each role against pre-set host group targets based on the diagram here. These can be changed based on need. Hosts and groups are defined in ```inventory.yml```, pulling addressing information from ```group_vars/all.yml```


## Caveats
By default, ansible runs against the public IP:22 to deploy. If you are running from a VPN or a local host, change the inventory.yml targets' variables to their ```_local``` counterparts.

## Sample environment
![sample environment](./topology.svg)

## Docs
Terra documentation: https://docs.terra.money/docs/full-node/run-a-full-terra-node/README.html

