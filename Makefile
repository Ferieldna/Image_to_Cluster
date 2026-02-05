CLUSTER_NAME=lab
NAMESPACE=demo
SERVICE_NAME=nginx-custom-service
PORT=8100
IMAGE_NAME=my-nginx-custom

.DEFAULT_GOAL := all

.PHONY: all cluster build import deploy access clean

all:
	@echo "🚀 Déploiement du projet en un clic..."
	@$(MAKE) cluster
	@$(MAKE) build
	@$(MAKE) import
	@$(MAKE) deploy
	@echo ""
	@echo "TP entièrement déployé"
	@echo "Accès à l'application :"
	@echo "Lancez : make access"
	@echo "Puis ouvrez le port $(PORT) dans l’onglet PORTS (Visibility: Public)"

cluster:
	@echo "Création du cluster K3d..."
	k3d cluster create $(CLUSTER_NAME) --servers 1 --agents 2 || echo "Cluster déjà existant"

build:
	@echo "Construction de l'image avec Packer..."
	packer init nginx.pkr.hcl
	packer build nginx.pkr.hcl

import:
	@echo "Importation de l'image dans K3d..."
	k3d image import $(IMAGE_NAME):latest -c $(CLUSTER_NAME)

deploy:
	@echo "Déploiement Kubernetes via Ansible..."
	ansible-playbook deploy.yml -e "ansible_python_interpreter=/usr/bin/python3"

access:
	@echo "Ouverture du tunnel vers l'application..."
	kubectl port-forward svc/$(SERVICE_NAME) $(PORT):80 -n $(NAMESPACE)

clean:
	@echo "Suppression du cluster et nettoyage..."
	k3d cluster delete $(CLUSTER_NAME)
