# Terraform test2

terraform {
  required_version = ">= 0.12.13"
  required_providers {
    aws = "~> 2.34"
  }
}

provider "aws" {
  region = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
  alias      = "east"
}

module "vpc" {
  source        = "./vpc"
  name          = "web"
  cidr          = "10.0.0.0/16"
  public_subnet = "10.0.1.0/24"
  providers = {
    "aws" = "aws.east"
  }
}

resource "aws_instance" "app" {
  ami                         = "${var.ami_id["us-east-1a"]}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  subnet_id                   = "${module.vpc.public_subnet_id}"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${module.vpc.security_instances}"]
  user_data                  = "${file("files/setup_appweb.sh")}"
  count = "${length(var.instance_ips)}"
  tags = {
    Name = "app-instance${count.index}"
  }
}

resource "aws_elb" "app" {
  name            = "app-elb"
  subnets         = ["${module.vpc.public_subnet_id}"]
  security_groups = ["${module.vpc.security_group_elb}"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  instances = "${aws_instance.app[*].id}"
}
