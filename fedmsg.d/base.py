import os

config = dict(
    environment='stage',
    zmq_enabled=False,
    stomp_uri=os.environ['UMB_URI'],
    stomp_heartbeat=1000,
    stomp_ssl_crt='/secrets/cert',
    stomp_ssl_key='/secrets/key',
)
