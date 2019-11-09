# Input/output interfaces

variable "name" {
  description = "The name of the VPC."
}

variable "cidr" {
  description = "The CIDR of the VPC."
}

variable "public_subnet" {
  description = "The public subnet to within the VPC."
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostname to use private DNS within the VPC."
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS to use private DNS within the VPC."
  default     = true
}

output "vpc_id" {
  value = "${aws_vpc.net.id}"
}

output "cidr" {
  value = "${aws_vpc.net.cidr_block}"
}

output "security_group_elb" {
  value = "${aws_security_group.elb.id}"
}

output "security_instances" {
  value = "${aws_security_group.instances.id}"
}

output "public_subnet_id" {
  value = "${aws_subnet.public.id}"
}
