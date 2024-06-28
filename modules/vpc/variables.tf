variable "cidr_block" {
  type = string
  description = "Plage cidr pour le vpc"
  default = "10.0.0.0/16"
}

variable "enable_dns_hostnames"{
  type = bool
  description = "Support dns hostnames"
  default = true
}

variable "enable_dns_support" {
  type = bool
  description = "Support dns"
  default = true
}

variable "cidr_public_subnet_a" {
  type = string
  description = "cidr public subnet a "
  default = "10.0.128.0/20"
}

variable "cidr_public_subnet_b" {
  type = string
  description = "cidr public subnet b "
  default = "10.0.144.0/20"
}

variable "az_public_subnet_a" {
  type = string
  description = "az public subnet a "
  default = "eu-west-3a"
}

variable "az_public_subnet_b" {
  type = string
  description = "az public subnet b "
  default = "eu-west-3b"
}

variable "cidr_wordpress_subnet_a" {
  type = string
  description = "cidr wordpress subnet a "
  default = "10.0.0.0/19"
}

variable "cidr_wordpress_subnet_b" {
  type = string
  description = "cidr wordpress subnet b "
  default = "10.0.32.0/19"
}

