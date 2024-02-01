resource "aws_ecr_repository" "app_repo" {
  name = "${var.environment}.demo_app"
}
