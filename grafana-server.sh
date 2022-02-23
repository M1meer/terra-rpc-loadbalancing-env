#!/bin/bash
ansible-playbook -i inventory.yml playbooks/grafana-server.yml -l grafana_servers -vvv