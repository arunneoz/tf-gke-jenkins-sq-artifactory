#!/bin/sh
# Initialize tf gke infrastructure
terraform init
terraform plan -out gke_jenkins_sonar.plan
terraform apply gke_jenkins_sonar.plan

