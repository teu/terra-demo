output "load_balancer_dns_name" {
  value = aws_lb.default.dns_name
}

output "load_balancer_security_group_id" {
  value = aws_security_group.lb.id
}

output "ecs_task_security_group_id" {
  value = aws_security_group.task.id
}
