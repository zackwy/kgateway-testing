up:
	kind create cluster --name kgateway || true
	docker-compose up -d
	sh ./hack/install-kgateway.sh
	sh ./hack/install-httpbin.sh

pf:
	kubectl port-forward deployment/http -n kgateway-system 8080:8080 > /tmp/port-forward.log 2>&1 &
