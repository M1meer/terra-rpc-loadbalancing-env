#!/bin/bash
ansible-playbook -i inventory.yml playbooks/node-exporter.yml -l prometheus_node_exporters -vvv