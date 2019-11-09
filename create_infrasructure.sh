#!/bin/bash

# delete files from old creations if present
find . -maxdepth 1 -type f -name 'plan-webapp.plan' -print -delete
find . -maxdepth 1 -type f -name 'terraform.tfstate*' -print -delete
find . -maxdepth 1 -type f -name '*.dot' -print -delete

# terraform initialization (only first execution)
terraform init -input=false

# create the plan
plan_name=plan-webapp.plan
terraform plan -out "$plan_name" -input=false

# apply the plan
terraform apply -auto-approve

# create the graph about the infrastructure and save into a .svg file
terraform graph > app.dot
dot app.dot -Tsvg -o web-application.svg
