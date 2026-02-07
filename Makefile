up:
	kind create cluster --name kgateway || true
	docker-compose up -d
	sh ./hack/install-kgateway.sh
	sh ./hack/install-httpbin.sh
	sh ./hack/setup-fake-ecs-backend.sh

pf:
	sh ./hack/port-forward-gateway.sh
