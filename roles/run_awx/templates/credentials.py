DATABASES = {
    'default': {
        'ATOMIC_REQUESTS': True,
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': "{{ pg_database }}",
        'USER': "{{ pg_admin_username }}",
        'PASSWORD': "{{ pg_admin_password }}",
        'HOST': "{{ pg_hostname | default('postgres') }}",
        'PORT': "{{ pg_port }}",
    }
}

BROKER_URL = 'amqp://{}:{}@{}:{}/{}'.format(
    "{{ rabbitmq_user }}",
    "{{ rabbitmq_password }}",
    "{{ rabbitmq_host | default('rabbitmq')}}",
    "{{ rabbitmq_port }}",
    "{{ rabbitmq_default_vhost }}")

CHANNEL_LAYERS = {
    'default': {'BACKEND': 'asgi_amqp.AMQPChannelLayer',
                'ROUTING': 'awx.main.routing.channel_routing',
                'CONFIG': {'url': BROKER_URL}}
}

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
        'LOCATION': '{}:{}'.format("{{ memcached_host }}", "{{ memcached_port }}")
    },
    'ephemeral': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
    },
}