export ANSIBLE_CONFIG=./ansible.cfg

secret:
	ansible-vault edit secret.yml

inventory:
	ansible-inventory --list

up:
	ansible-playbook up.yaml

down:
	ansible-playbook down.yaml

local:
	ansible-playbook local.yaml

local-dev:
	ansible-playbook local.yaml --extra-vars "env=dev"

.PHONY: secret inventory up down local