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
	- Deploys full terra nodes, opens RPC endpoints. Relies on [the quicksync Terra chain snapshot](https://quicksync.io/networks/terra.html)

- firewall
	- Deploys ```allow``` rules with ```deny``` policy (default deny)


## Getting started
Target machine IPs are defined in ```group_vars/all.yml```, and these variables are re-used throughout the playbook. As such, define your targets with the relevant public and private IPs. You also need to make sure that the targets are able to communicate locally, be that by existing in the same VPC and subnet, or using e.g. VPC peering. If you want them to communicate on public addresses in all instances, private IP variables need to be replaced with their public-IP counterparts (```group_vars/all.yml```) in all relevant places, or alternatively, by giving the ```_local``` variables the same values as their public counterparts in ```group_vars/all.yml```.



## Usage
Scripts are provided to run each role against a pre-set host group target, based on the diagram below. These can be changed based on need. Hosts and groups are defined in ```inventory.yml```, pulling addressing information from ```group_vars/all.yml```. Also, make sure to define the terra version, the [latest quicksync filename](https://quicksync.io/networks/terra.html), and other variables in ```roles/terra-nodes/vars/main.yml```

To configure monitoring, access your grafana server on port :3000 and start building dashboards. Prometheus-server will be populated with endpoinds to scrape, so all that remains is the selection of metrics. Terra nodes will have two endpoints: 9100 for general metrics, and :26660 for blockchain data. HAProxy will have :9100 accessible.

## Sample environment
![sample environment](./topology.svg)

## Caveats
By default, ansible runs against the public IP:22 to deploy. If you are running from a VPN or a local host, change the inventory.yml targets' variables to their ```_local``` counterparts.

### Disk space needed
You need sufficient harddisk space to store the download, as well as the unpacked chain. Check the snapshot size, consider that it needs to be unpacked, and configure your resources accordingly.

### Quicksync download
The terra-nodes role includes the downloading and unpacking of the quicksync snapshot. Running this task several times over will download the entire quicksync file every time, and is not recommended due to time and resource use. The tasks involved in that process -- the downloading and extraction of the snapshot -- can be disabled by commenting out ``` - include_tasks: download_extract_snapshot.yml``` in the ```roles/terra-nodes/tasks/main.yml``` file.

### Limitations on the number of hosts
For now, this project assumes three RPC hosts. If less or more are needed, changes need to be made to the ```/roles/haproxy/vars/main.yml``` host list, among possible other locations, to account for the different number of hosts.

## Docs
Terra documentation: https://docs.terra.money/docs/full-node/run-a-full-terra-node/README.html

