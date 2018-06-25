# A container for running datanommer

This repository contains configuration and supporting files for running
[datanommer](https://github.com/fedora-infra/datanommer) in a container.
The image is built on top of the [Fedora](https://getfedora.org/) 28 base
image.

## Build

To build the container in OpenShift, you can run:
```
oc new-build https://github.com/release-engineering/datanommer-container
```

## Deployment

The recommended deployment method is OpenShift.

### Configuration

All configuration of the image is handled via environment variables,
provided by your container runtime environment.

- BROKER_URI: the URI of the broker to connect to. The current config
  assumes this is a ActiveMQ broker. The value can be a comma-separated
  list of broker addresses, and datanommer will then failover between
  brokers if it loses its connection.
- TOPICS: a space-separated list of topics to subscribe to.
- ENVIRONMENT: the environment the datanommer instance is running in,
  usually `dev`, `stg`, or `prod` (default: dev)
- DB_HOST: the host where the `datanommer` database is located
- DB_NAME: the name of the `datanommer` database
- DB_USERNAME: the username to connect to the `datanommer` database
- DB_PASSWORD: the password to connect to the `datanommer` database
- LOGLEVEL: what level of logging to use (default: WARNING)

The config assumes the broker accepts SSL client certificate
authentication. The client certificate must be available at
`/secrets/cert`, and the private key must be available at
`/secrets/key`.
