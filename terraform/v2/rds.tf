locals {
  aurora_mysql_param_group_57 = [
    {
      name         = "general_log"
      value        = "1"
      apply_method = "immediate"
    },
    {
      name         = "slow_query_log"
      value        = "1"
      apply_method = "immediate"
    },
    {
      name         = "long_query_time"
      value        = "1"
      apply_method = "immediate"
    },
    {
      name         = "server_audit_logging"
      value        = "1"
      apply_method = "immediate"
    },
    {
      name         = "server_audit_events"
      value        = "CONNECT,QUERY,QUERY_DCL,QUERY_DDL,QUERY_DML,TABLE"
      apply_method = "immediate"
    }
  ]
}

# Aurora MySQL用のDBクラスタパラメータグループの作成
resource "aws_rds_cluster_parameter_group" "aurora_mysql_param_group_57" {
  name   = "aurora-mysql-cluster-param-group-57"
  family = "aurora-mysql5.7"

  dynamic "parameter" {
    for_each = local.aurora_mysql_param_group_57
    content {
      name         = parameter.value["name"]
      value        = parameter.value["value"]
      apply_method = parameter.value["apply_method"]
    }
  }
  tags = {
    Name = "aurora-mysql-cluster-param-group-57"
  }
}

# Aurora MySQL用のDBパラメータグループの作成
resource "aws_db_parameter_group" "aurora_mysql_db_param_group_57" {
  name   = "aurora-mysql-db-param-group-57"
  family = "aurora-mysql5.7"

  tags = {
    Name = "aurora-mysql-db-param-group-57"
  }
}

# Aurora MySQL DBクラスタの作成
resource "aws_rds_cluster" "aurora_mysql" {
  cluster_identifier              = "aurora-mysql-blue-green-cluster"
  engine                          = "aurora-mysql"
  engine_version                  = "5.7.mysql_aurora.2.11.5"
  availability_zones              = data.aws_availability_zones.available.names
  database_name                   = "mydb"
  master_username                 = "admin"
  master_password                 = "your_password" # セキュアな方法で保存
  db_subnet_group_name            = aws_db_subnet_group.private_subnets.name
  vpc_security_group_ids          = [aws_security_group.rds_sg.id]
  apply_immediately               = true
  storage_encrypted               = true
  skip_final_snapshot             = true
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_mysql_param_group_57.name
  # ログエクスポートの有効化
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  tags = {
    Name            = "aurora-mysql-blue-green-cluster"
    devops-guru-rds = "ture"
  }
}

# DBサブネットグループの作成（プライベートサブネット用）
resource "aws_db_subnet_group" "private_subnets" {
  name       = "aurora-mysql-private-subnets"
  subnet_ids = aws_subnet.private_subnet[*].id

  tags = {
    Name = "aurora-mysql-private-subnets"
  }
}

# Aurora MySQL DBインスタンス（WRITE用）の作成
resource "aws_rds_cluster_instance" "write_instance" {
  identifier              = "aurora-mysql-write"
  cluster_identifier      = aws_rds_cluster.aurora_mysql.id
  instance_class          = "db.r5.large"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.11.5"
  db_parameter_group_name = aws_db_parameter_group.aurora_mysql_db_param_group_57.name
  publicly_accessible     = false
  apply_immediately       = true
  # performance_insightsの有効化
  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  # 拡張モニタリングを有効化
  monitoring_interval = 60 # 60秒間隔のモニタリング
  monitoring_role_arn = aws_iam_role.rds_monitoring_role.arn

  tags = {
    Name            = "aurora-mysql-write-instance"
    devops-guru-rds = "ture"
  }
}

# Aurora MySQL DBインスタンス（READ用）の作成
resource "aws_rds_cluster_instance" "read_instance" {
  identifier              = "aurora-mysql-read"
  cluster_identifier      = aws_rds_cluster.aurora_mysql.id
  instance_class          = "db.r5.large"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.11.5"
  db_parameter_group_name = aws_db_parameter_group.aurora_mysql_db_param_group_57.name
  publicly_accessible     = false
  apply_immediately       = true
  # performance_insightsの有効化
  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  # 拡張モニタリングを有効化
  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_monitoring_role.arn

  tags = {
    Name            = "aurora-mysql-read-instance"
    devops-guru-rds = "ture"
  }
}

# セキュリティグループの作成（RDS用）
resource "aws_security_group" "rds_sg" {
  name        = "aurora-mysql-sg"
  description = "Security group for Aurora MySQL"

  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # VPC内の通信を許可
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aurora-mysql-sg"
  }
}

# IAM Role for RDS Enhanced Monitoring
resource "aws_iam_role" "rds_monitoring_role" {
  name = "rds-monitoring-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Action" : "sts:AssumeRole",
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "monitoring.rds.amazonaws.com"
      }
    }]
  })

  tags = {
    Name = "rds-monitoring-role"
  }
}

# IAM Role Policy for Enhanced Monitoring
resource "aws_iam_role_policy_attachment" "rds_monitoring_role_policy" {
  role       = aws_iam_role.rds_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
