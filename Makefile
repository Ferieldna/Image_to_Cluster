IMAGE_NAME=my-nginx-custom
CLUSTER_NAME=lab
PACKER_FILE=nginx.pkr.hcl
ANSIBLE_PLAYBOOK=deploy.yml
PYTHON_PATH=/home/codespace/.python/current/bin/python3

.PHONY: all build import deploy clean

all: build import deploy

build:
	@echo "### Building image with Packer..."
	packer build $(PACKER_FILE)

import:
	@echo "### Importing image to K3d..."
	docker save $(IMAGE_NAME):latest | k3d image import - --cluster $(CLUSTER_NAME)

deploy:
	@echo "### Deploying to Kubernetes via Ansible..."
	ansible-playbook $(ANSIBLE_PLAYBOOK) -e "ansible_python_interpreter=$(PYTHON_PATH)"

forward:
	@echo "### Starting Port-Forward on 8081..."
	kubectl port-forward svc/custom-nginx-service 8081:80 >/tmp/nginx-custom.log 2>&1 &

clean:
	@echo "### Cleaning up deployment..."
	kubectl delete -f $(ANSIBLE_PLAYBOOK) || true
