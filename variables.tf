# Variables file

#terraform.tfvars
variable "access_key" {}
variable "secret_key" {}

variable "region" {
  default     = "us-east-1"
  type        = "string"
  description = "AWS region"
}

variable "ami_id" {
  default = {
    us-east-1a = "ami-0d729a60"
    us-east-1b = "ami-0d729a60"
  }
  type        = "map"
  description = "AMIs to use per AZ"
}

variable "instance_type" {
  type        = "string"
  description = "Type of instance EC2"
  default     = "t2.micro"
}

variable "key_name" {
  default     = "myKeyPair"
  type        = "string"
  description = "The AWS key pair to use for resources"
}

variable "instance_ips" {
  default     = ["10.0.1.10", "10.0.1.11"]
  type        = "list"
  description = "List of IPs available for instances"
}
