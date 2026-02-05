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
Pour builder l'image, l'importer dans le cluster et déployer les pods, lancez simplement :
```bash
make all
