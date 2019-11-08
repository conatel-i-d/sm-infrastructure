export ANSIBLE_CONFIG=./ansible.cfg

secret:
	ansible-vault edit secret.yml

inventory:
	ansible-inventory --list

up:
	ansible-playbook up.yaml

down:
	ansible-playbook down.yaml

deploy:
	ansible-playbook local.yaml

dev:
	ansible-playbook local.yaml --extra-vars "env=dev"

build-tower-cli:
	docker build -t cdh/tower-cli ./files

dump-awx:
	docker run --network sm_network \
		-v $$(pwd)/files/tower_cli.cfg:/root/.tower_cli.cfg \
		-t cdh/tower-cli receive --all

.PHONY: secret inventory up down local