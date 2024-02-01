# @todo remove
resource "aws_security_group_rule" "external-access" {
  from_port         = 8080
  protocol          = "tcp"
  security_group_id = module.ecs_server.load_balancer_security_group_id
  to_port           = 8080
  cidr_blocks       = ["75.2.60.0/24"]
  type              = "ingress"
}

# app -> db
resource "aws_security_group_rule" "db-app-access" {
  from_port                = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_postgresql.id
  source_security_group_id = module.ecs_server.ecs_task_security_group_id
  to_port                  = 5432
  type                     = "ingress"
}
