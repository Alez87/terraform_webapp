Terraform IaC with AWS provider  

Structure of the folder:
- terraform.tfvars: containes the secrets
- app.tf: main components of the infrastructure
- variables.tf: contains the variables used
- module VPC: contains the definition for all the components related to the VPC
- files: contains a script file to install and start a NGNIX web server in order to: test the results obtained, allow ELB to performe healthy checks on the connected EC2 instances
- create_infrastructure.sh: bash file to automate the creation of the infrastructure
  
How to run:  
1. modify the file "terraform.tfvars" with the credential needed
2. run the script "create_infrastructure.sh"
3. open the browser, copy-paste the DNS address of the load balancer (from the AWS dashboard) and check that NGINX is up and running

Output:  
- creation of an AWS infrastructure based on two EC2 instances with a load balancer that dispatch traffic toward them
- app.dot file that contains the dependency graph in DOT graph format
- web-application.svg file that is a graphical representation of the previous file
  
Versions used:  
- Terraform v0.12.13
- AWS Provider v2.34.0
