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
	cd lib/docker/postgres && docker-compose up -d --force-recreate && cd -

_db_down:
	docker stop postgres && docker rm postgres
	rm -rf lib/docker/postgres
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
	ansible-playbook update_tower_config.yml
	docker run --network sm_network \
		-v $$(pwd)/files/export.json:/root/export.json \
		-v $$(pwd)/files/tower_cli.cfg:/root/.tower_cli.cfg \
		-t cdh/tower-cli send /root/export.json



update_certs:
	cd lib/docker/proxy && docker-compose up -d --force-recreate && cd -

update_keycloak_credentials:
	cd lib/docker/keycloak && docker-compose up -d --force-recreate && cd -

update_prime_credentials:
	cd lib/docker/api && docker-compose up -d --force-recreate && cd -

update_switches_credentials:
	cd lib/docker/api && docker-compose up -d --force-recreate && cd -

update_ldap_credentials:
	echo "update"

.PHONY: secret inventory up down local version_minor version_mayor version_patch db_up _db_down setup tear_down version_push prod

