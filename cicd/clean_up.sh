#!/bin/sh
# Tear Down built infrastructure
terraform state rm module.k8s_cluster
rm -rf .terraform/*
rm -rf *.plan

