export ANSIBLE_CONFIG=./ansible.cfg

create_secrets:
	ansible-vault create secret.yml

secret:
	ansible-vault edit secret.yml

inventory:
	ansible-inventory --list

certs:
	ansible-playbook certs.yml

up:
	ansible-playbook up.yaml

down:
	ansible-playbook down.yaml

db_up:
	ansible-playbook db.yml --extra-vars "state=present"

_db_down:
	ansible-playbook db.yml --extra-vars "state=absent"

setup:
	ansible-playbook setup_project.yml --extra-vars "state=present"

tear_down:
	ansible-playbook setup_project.yml --extra-vars "state=absent"

dev:
	ansible-playbook local.yaml --extra-vars "env=dev"

prod:
	ansible-playbook local.yaml --extra-vars "env=prod"

version_minor:
	ansible-playbook versioning.yml --tags "new" --extra-vars "bump=minor"

version_mayor:	
	ansible-playbook versioning.yml --tags "new" --extra-vars "bump=mayor"

version_patch:
	ansible-playbook versioning.yml --tags "new" --extra-vars "bump=patch"

version_build:
	ansible-playbook versioning.yml --tags "build"

version_push:
	ansible-playbook versioning.yml --tags "push"

build-tower-cli:
	docker build -t cdh/tower-cli ./files

awx-receive:
	docker run --network sm_network \
		-v $$(pwd)/files/tower_cli.cfg:/root/.tower_cli.cfg \
		-t cdh/tower-cli receive --all

awx-send:
	docker run --network sm_network \
		-v $$(pwd)/files/export.json:/root/export.json \
		-v $$(pwd)/files/tower_cli.cfg:/root/.tower_cli.cfg \
		-t cdh/tower-cli send /root/export.json

.PHONY: secret inventory up down local version_minor version_mayor version_patch db_up _db_down setup tear_down version_push prod