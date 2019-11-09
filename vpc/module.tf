# Module VPC

resource "aws_vpc" "net" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"
  tags = {
    Name = "${var.name}"
  }
}

resource "aws_internet_gateway" "net" {
  vpc_id = "${aws_vpc.net.id}"
  tags  = { 
    Name = "${var.name}-igw"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.net.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.net.id}"
}

resource "aws_subnet" "public" {
  vpc_id     = "${aws_vpc.net.id}"
  cidr_block = "${var.public_subnet}"
  tags = {
    Name = "${var.name}-public"
  }
}

resource "aws_security_group" "instances" {
  description = "Allow HTTP to instances from every IP"
  vpc_id      = "${aws_vpc.net.id}"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "elb" {
  description = "Allow HTTP to web hosts from every IP"
  vpc_id      = "${aws_vpc.net.id}"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
