resource "docker_image" "demo_app_local" {
  name = "${aws_ecr_repository.app_repo.repository_url}:latest"

  build {
    context = "${path.cwd}/docker"
  }
}

resource "docker_registry_image" "demo_app_remote" {
  name          = docker_image.demo_app_local.name
  keep_remotely = true

  depends_on = [docker_image.demo_app_local]
}

module "ecs_server" {
  source = "../../modules/ecs"

  environment        = var.environment
  vpc_id             = local.vpc_id
  public_subnet_ids  = local.public_subnet_ids
  private_subnet_ids = local.private_subnet_ids
  name               = "demo-app"
  aws_region         = var.aws_region
  container_port     = 80
  http_listener_port = 8080
  container_image    = docker_image.demo_app_local.name
}
