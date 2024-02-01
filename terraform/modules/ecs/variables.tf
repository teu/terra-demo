variable "environment" {}
variable "aws_region" {}
variable "vpc_id" {}
variable "name" {}
variable "public_subnet_ids" {}
variable "private_subnet_ids" {}
variable "container_port" {}
variable "container_image" {}
variable "http_listener_port" {
  default = 8080
}
variable "container_memory" {
  default = 512
}
variable "container_cpu" {
  default = 256
}
