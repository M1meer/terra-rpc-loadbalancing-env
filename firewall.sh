#!/bin/bash
#ansible-playbook -i inventory.yml playbooks/firewall.yml -l all -vvv
ansible-playbook -i inventory.yml playbooks/firewall.yml -l haproxies,terra_nodes,grafana_servers,prometheus_servers -vvv