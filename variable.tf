variable "vpc_cidr" {
  description = "VPC CIDR Block"
}

variable "vpc_name" {
  description = "VPC Name"
}

variable "subnet_cidr_block" {
  description = "Subnet CIDR Block"
}

variable "availability_zone" {
  description = "Availability Zone"
}

variable "IGW_Name" {
  description = "Internet Gateway Name"
}

variable "RT_cidr_block" {
  description = "Route Table CIDR Block"
}

variable "subnet_name" {
  description = "subnet name"
}

variable "RT_Name" {
  description = "Route Table Name"
}

variable "SG_cidr_block" {
  description = "Security Group CIDR Block"
}

variable "SG_Name" {
  description = "Security Group"
}

variable "key_name" {
  description = "Key Name"
}

variable "pub_key_path" {
  description = "Public Key Path Block"
}

variable "ami" {
  description = "AMI ID"
}

variable "instance_type" {
  description = "Instance Type"
}

variable "instance_name" {
  description = "Instance Name"
}

variable "private_key_path" {
  description = "Private Key Block"
}