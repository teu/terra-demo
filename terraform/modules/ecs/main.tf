locals {
  container_name = "${var.name}-api"
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.environment}-${var.name}-ecs-cluster"
}

resource "aws_ecs_service" "ecs_service" {
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"
  name                               = "${var.environment}-${var.name}-ecs-service"
  cluster                            = aws_ecs_cluster.ecs_cluster.id
  task_definition                    = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count                      = 2
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = local.container_name
    container_port   = var.container_port
  }

  network_configuration {
    security_groups  = [aws_security_group.task.id]
    subnets          = var.private_subnet_ids
    assign_public_ip = false
  }

  depends_on = [aws_lb_listener.http80]
}

resource "aws_ecs_task_definition" "demo_api" {
  family = local.container_name

  container_definitions = <<EOF
  [
    {
      "name": "${local.container_name}",
      "image": "${var.container_image}",
      "memory": ${var.container_memory},
      "portMappings": [
        {
          "containerPort": ${var.container_port},
          "hostPort": ${var.container_port}
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-region": "${var.aws_region}",
          "awslogs-group": "/ecs/demo-api",
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ]
EOF
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "${var.environment}-${var.name}-ecs-task"
  container_definitions    = aws_ecs_task_definition.demo_api.container_definitions
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
}

resource "aws_cloudwatch_log_group" "demo_app" {
  name = "/ecs/${local.container_name}"
}
