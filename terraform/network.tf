# VPCの作成
resource "aws_vpc" "main" {
  cidr_block = local.vpc_cidr

  tags = {
    Name = "aurora-mysql-blue-green"
  }
}

# パブリックサブネットの作成
resource "aws_subnet" "public_subnet" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.public_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "aurora-mysql-blue-green-public-${count.index}"
  }
}

# プライベートサブネットの作成
resource "aws_subnet" "private_subnet" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "aurora-mysql-blue-green-private-${count.index}"
  }
}

# インターネットゲートウェイの作成
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "aurora-mysql-blue-green-internet-gateway"
  }
}

# ルートテーブル（パブリックサブネット用）の作成
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "aurora-mysql-blue-green-public-route-table"
  }
}

# 各パブリックサブネットにルートテーブルを関連付ける
resource "aws_route_table_association" "public_subnet_assoc" {
  count          = 3
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# NATゲートウェイの作成（プライベートサブネット用）
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "aurora-mysql-blue-green-nat-gateway"
  }
}

# EIP for NATゲートウェイ
resource "aws_eip" "main" {
  tags = {
    Name = "aurora-mysql-blue-green-eip"
  }
}

# ルートテーブル（プライベートサブネット用）の作成
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "aurora-mysql-blue-green-private-route-table"
  }
}

# 各プライベートサブネットにルートテーブルを関連付ける
resource "aws_route_table_association" "private_subnet_assoc" {
  count          = 3
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}
