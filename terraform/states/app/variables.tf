variable "max_retries" {}
variable "environment" {}
variable "aws_account_id" {}
variable "aws_region" {}
variable "aws_profile" {}
variable "terraform_state_bucket" {}
variable "terraform_state_bucket_region" {}
variable "default_aws_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
}

#db
variable "db_name" {
  default = "demo"
}
variable "db_admin_user_name" {
  sensitive = true
  default   = "adm" # yeah, I know
}
variable "db_admin_password" {
  sensitive = true
  default   = "password" # yeah, I know
}
