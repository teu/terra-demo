resource "aws_lb" "default" {
  name            = "${var.name}-ext-lb"
  subnets         = var.public_subnet_ids
  security_groups = [aws_security_group.lb.id]
  internal        = false
}

resource "aws_lb_target_group" "tg" {
  name        = "${var.name}-target-group"
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "http80" {
  load_balancer_arn = aws_lb.default.id
  port              = var.http_listener_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tg.id
    type             = "forward"
  }
}
