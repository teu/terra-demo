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
  container_image    = "ealen/echo-server:0.8.12"
}

