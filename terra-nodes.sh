#!/bin/bash
ansible-playbook -i inventory.yml playbooks/terra-nodes.yml -l terra_nodes -vvv