CREATE USER {{ awx_admin_username }} WITH ENCRYPTED PASSWORD '{{ awx_admin_password }}';
CREATE USER {{ keycloak_admin_username }} WITH ENCRYPTED PASSWORD '{{ keycloak_admin_password }}';
CREATE USER {{ api_admin_username }} WITH ENCRYPTED PASSWORD '{{ api_admin_password }}';

CREATE DATABASE {{ awx_database_name }};
CREATE DATABASE {{ keycloak_database_name }};
CREATE DATABASE {{ api_database_name }};

GRANT ALL PRIVILEGES ON DATABASE {{ awx_database_name }} TO {{ awx_admin_username }};
GRANT ALL PRIVILEGES ON DATABASE {{ keycloak_database_name }} TO {{ keycloak_admin_username }};
GRANT ALL PRIVILEGES ON DATABASE {{ api_database_name }} TO {{ api_admin_username }};