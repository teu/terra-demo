variable "terraform_state_bucket" {}
variable "terraform_state_bucket_region" {}
variable "max_retries" {}
variable "environment" {}
variable "aws_account_id" {}
variable "aws_region" {}
variable "default_aws_tags" {
  type = map(any)
}
variable "vpc_cidr" {
  type = string
}
variable "availability_zones" {
  type = list(string)
}
variable "private_subnet_cidrs" {
  type = list(string)
}
variable "public_subnet_cidrs" {
  type = list(string)
}
