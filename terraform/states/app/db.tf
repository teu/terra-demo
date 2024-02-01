resource "aws_security_group" "rds_postgresql" {
  vpc_id = local.vpc_id
  name   = "${var.environment}-${var.db_name}-sg"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "rds_postgresql" {
  subnet_ids = local.private_subnet_ids
  name       = "${var.environment}-${var.db_name}-subnet-group"
}

resource "aws_db_instance" "rds_postgresql" {
  engine                    = "postgres"
  engine_version            = "14.4"
  allocated_storage         = "5"
  instance_class            = "db.t3.micro"
  backup_retention_period   = 7
  final_snapshot_identifier = "${var.db_name}-snapshot-1"
  identifier                = "${var.environment}-${var.db_name}"
  username                  = var.db_admin_user_name
  password                  = var.db_admin_password
  port                      = 5432
  vpc_security_group_ids = [
    aws_security_group.rds_postgresql.id,
  ]
  db_subnet_group_name         = aws_db_subnet_group.rds_postgresql.name
  backup_window                = "22:00-23:00"
  maintenance_window           = "Wed:08:00-Wed:09:00"
  copy_tags_to_snapshot        = true
  performance_insights_enabled = false
  multi_az                     = false

  tags = {
    Name = "${var.environment}-${var.db_name}"
  }

  lifecycle {
    ignore_changes = [engine_version]
  }
}

