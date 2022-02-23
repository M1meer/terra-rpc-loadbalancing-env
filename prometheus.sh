#!/bin/bash
ansible-playbook -i inventory.yml playbooks/prometheus-server.yml -l prometheus_servers -vvv