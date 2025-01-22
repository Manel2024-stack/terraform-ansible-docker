Projet Terraform et Ansible : Déploiement d'une Infrastructure avec Docker
Description
Ce projet déploie une infrastructure sur AWS à l'aide de Terraform, configure des instances EC2 avec Ansible et installe Docker pour l'orchestration de conteneurs.

Étapes du Projet

1. Génération de la clé SSH
Une clé SSH est nécessaire pour sécuriser les connexions aux instances EC2.

   ssh-keygen -t rsa -b 4096 -f ./ssh-terra


2. Déploiement de l'infrastructure avec Terraform
Terraform est utilisé pour créer une infrastructure AWS comprenant des instances EC2, un VPC, un Subnet, une Internet Gateway et un Security Group.

Commandes exécutées :
Initialiser Terraform :

terraform init

Planifier le déploiement :

terraform plan

Appliquer les changements :

terraform apply
3. Vérification de la connectivité avec Ansible
Testez la connexion SSH avec les instances EC2 configurées dans le fichier hosts :

ansible all -i hosts -m ping --private-key ssh-terra

4. Déploiement de Docker avec Ansible
Un playbook Ansible est utilisé pour installer Docker sur les instances EC2.

Commandes exécutées :
Vérification syntaxique du playbook :

ansible-playbook -i hosts install.yml --syntax-check

Exécution en mode check (simulation) :

ansible-playbook -i hosts install.yml --check
Exécution réelle :

ansible-playbook -i hosts install.yml --private-key ssh-terra

5. Vérification de l'installation de Docker
Vérifiez la version de Docker installée :

ansible -i hosts ec2_instances -a "docker --version"

Résultat attendu
Infrastructure AWS avec 3 instances EC2.
Docker installé et fonctionnel sur toutes les instances.


Auteurs
Manel