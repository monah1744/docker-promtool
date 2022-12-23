
PROM_VERSION=0.41.0
DOCKER_VERSION=2.41.0
DOCKER_IMAGE=monah1744/promtool:${DOCKER_VERSION}

.DEFAULT_GOAL := push

.PHONY: build
build:
	docker build --build-arg prom_version=${PROM_VERSION} -t ${DOCKER_IMAGE} .

.PHONY: push
push: build
	docker push ${DOCKER_IMAGE} 
