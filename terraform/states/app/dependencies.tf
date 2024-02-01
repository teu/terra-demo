data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = var.terraform_state_bucket
    key    = "network/${var.environment}-${var.aws_region}.tfstate"
    region = var.terraform_state_bucket_region
  }
}
