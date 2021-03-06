DATABASE_USER={{ pg_admin_username }}
DATABASE_NAME={{ pg_database }}
DATABASE_HOST={{ pg_hostname | default('postgres') }}
DATABASE_PORT={{ pg_port }}
DATABASE_PASSWORD={{ pg_admin_password }}
DATABASE_ADMIN_PASSWORD={{ pg_admin_password }}
MEMCACHED_HOST={{ memcached_host }}
MEMCACHED_PORT={{ memcached_port }}
RABBITMQ_HOST={{ rabbitmq_host }}
RABBITMQ_PORT={{ rabbitmq_port }}
AWX_ADMIN_USER={{ awx_admin_username }}
AWX_ADMIN_PASSWORD={{ awx_admin_password | quote }}