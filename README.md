# docker-promtool

## Why?

Keeping your prometheus config files under source control is great for shared ownership of a monitoring system.  But you want to use a CI/CD system to make sure that nobody breaks monitoring by pushing an invalid config file.

Prometheus has a nice utility called [promtool](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/#syntax-checking-rules) which can be used to check that a config/rules file is valid.  But to use it, you need to build it yourself, or run it from the base prom/prometheus docker image which isn't compatible with the drone.io CI system because it runs as a custom user inside the container.

We built this image to be lightweight, just alpine linux with the `promtool` binary, and nothing else.

## About this repo

This repo just tracks changes to the Dockerfile.  The built image can be found at <https://hub.docker.com/repository/docker/monah1744/promtool>

## Usage

### Using `docker run`

Check a prometheus config file:

```
docker run \
  -v /path/to/local/prometheus/configs:/tmp \
  dnanexus/promtool:2.9.2 \
  promtool check config /tmp/prometheus.yml
```

Check a prometheus rules file

```
docker run \
  -v /path/to/local/prometheus/configs:/tmp \
  dnanexus/promtool:2.9.2 \
  promtool check rules /tmp/prometheus.rules.yml
```

### Using drone pipeline step

```
pipeline:
  validate:
    image: dnanexus/promtool:2.9.2
    commands:
      - promtool check rules prometheus.rules.yml
      - promtool check config prometheus.yml
```

### Using wercker pipeline step

```
validate-prometheus-config:
  box:
    id: dnanexus/promtool:2.9.2
  steps:
  - script:
    name: Validate prometheus configuration rules (alerting rules)
    description: if this is failing prometheus will not be able to start, better fail fast
    code: |
      promtool check config prometheus.yml
      promtool check rules prometheus.rules.yml
```

## Version History

* 2.41.0: Upgrade releases (go, alpine)
* 2.9.2: Alignment with prometheus releases
* 1.0: Initial release
