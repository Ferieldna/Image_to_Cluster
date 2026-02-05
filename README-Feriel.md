TP : Maison SVG Déployée sur Kubernetes (K3d)

Ce projet permet de générer une page web statique affichant une maison en SVG, de l'empaqueter dans une image Docker via Packer et de la déployer automatiquement sur un cluster K3d local à l'aide d'Ansible.

Fonctionnalités
* **Design SVG** : Une maison personnalisable (actuellement avec un toit vert `limegreen`).
* **Infrastructure as Code** : Automatisation complète du build et du déploiement.
* **Makefile** : Une seule commande pour tout orchestrer.

Stack Technique
* **Serveur Web** : Nginx
* **Provisioning** : Packer (Docker builder)
* **Orchestration** : K3d (Kubernetes local)
* **Déploiement** : Ansible
* **Automatisation** : Makefile

---

Prérequis
* Docker installé
* K3d installé et un cluster nommé `lab` actif
* Packer et Ansible installés

---

Utilisation

Déploiement Complet
Lancer le tunnel (Port-Forward) :
```bash
make forward

```

Cette commande redirige le trafic du port 80 du cluster vers le port 8081 de votre Codespace.

Ouvrir le lien :

Allez dans l'onglet Ports de VS Code.
Cliquez sur l'icône du globe (🌐) en face du port 8081.
Si une notification apparaît en bas à droite, cliquez sur "Open in Browser".

Sauvegarder son travail
Pour sauvegarder on commit les changements puis on sync avant de relancer la page.

En cas de bug
Commandes de Débogage
```bash
kubectl rollout restart deployment custom-nginx
make forward
```

Structure du Projet

index.html : Source de l'application (maison en SVG).
nginx.pkr.hcl : Configuration Packer pour créer l'image Docker.
deploy.yml : Playbook Ansible pour le déploiement Kubernetes.
Makefile : Orchestrateur des commandes (build, import, deploy, forward).

